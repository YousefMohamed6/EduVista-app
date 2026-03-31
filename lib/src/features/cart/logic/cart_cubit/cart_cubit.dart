import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/src/features/course/domain/entities/course.dart';
import 'package:edu_vista/src/features/course/presentation/Screens/my_courses_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:paymob_payment/paymob_payment.dart';

import '../../../course/data/models/course_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser?.uid;
  List<Course> _cartCourses = [];
  List<Course> _boughtCourses = [];

  Future<void> fetchCart() async {
    emit(CartLoading());
    try {
      if (userId == null) {
        emit(CartError('User not logged in.'));
        return;
      }

      final cartSnapshot = await _fireStore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .get();

      _cartCourses = cartSnapshot.docs
          .map((doc) => CourseModel.fromJson({
                'id': doc.id,
                ...doc.data(),
              }))
          .toList();

      emit(CartLoaded(_cartCourses));
    } catch (e) {
      emit(CartError('Failed to load cart: $e'));
    }
  }

  Future<void> addCourseToCart(Course course) async {
    emit(CartLoading());
    try {
      if (_cartCourses.any((c) => c.id == course.id)) {
        emit(CartError('Course already in the cart.'));
        return;
      }

      _cartCourses.add(course);
      await _updateFirestoreCart();
      emit(CartUpdated(_cartCourses));
      await fetchCart();
    } catch (e) {
      emit(CartError('Failed to add course to cart: $e'));
    }
  }

  Future<void> removeCourseFromCart(Course course) async {
    emit(CartLoading());
    try {
      _cartCourses.removeWhere((c) => c.id == course.id);
      await _updateFirestoreCart();
      emit(CartUpdated(_cartCourses));
      await fetchCart();
      emit(CartLoaded(_cartCourses));
    } catch (e) {
      emit(CartError('Failed to remove course from cart: $e'));
    }
  }

  Future<void> clearCart() async {
    emit(CartLoading());
    try {
      _cartCourses.clear();
      await _updateFirestoreCart();
      emit(CartUpdated(_cartCourses));
    } catch (e) {
      emit(CartError('Failed to clear cart: $e'));
    }
  }

  Future<void> _updateFirestoreCart() async {
    if (userId == null) {
      emit(CartError('User not logged in.'));
      return;
    }

    final cartCollection =
        _fireStore.collection('users').doc(userId).collection('cart');

    final batch = _fireStore.batch();

    final cartSnapshot = await cartCollection.get();
    for (var doc in cartSnapshot.docs) {
      batch.delete(doc.reference);
    }
    emit(CartLoading());
    for (var course in _cartCourses) {
      batch.set(cartCollection.doc(course.id), (course as CourseModel).toJson());
    }

    await batch.commit();
  }

  Future<void> fetchBoughtCourses() async {
    emit(CartLoading());
    try {
      if (userId == null) {
        emit(CartError('User not logged in.'));
        return;
      }

      final boughtCoursesSnapshot = await _fireStore
          .collection('users')
          .doc(userId)
          .collection('boughtCourses')
          .get();

      _boughtCourses = boughtCoursesSnapshot.docs
          .map((doc) => CourseModel.fromJson({
                'id': doc.id,
                ...doc.data(),
              }))
          .toList();

      emit(CartBoughtCourses(_boughtCourses));
    } catch (e) {
      emit(CartError('Failed to load bought courses: $e'));
    }
  }

  double totalPriceInEGP({double conversionRate = 48}) {
    double totalPriceInUSD =
        _cartCourses.fold(0, (sum, course) => sum + (course.price ?? 0));
    return (totalPriceInUSD * conversionRate);
  }

  Future<void> buyCourses(BuildContext context) async {
    emit(CartLoading());

    try {
      await PaymobPayment.instance.initialize(
        apiKey: dotenv.env['apiKey']!,
        integrationID: int.parse(dotenv.env['integrationId']!),
        iFrameID: int.parse(dotenv.env['iFrameID']!),
      );

      final PaymobResponse? response = await PaymobPayment.instance.pay(
        context: context,
        currency: "EGP",
        amountInCents: (totalPriceInEGP() * 100).toString(),
      );

      if (response != null && response.success) {
        final boughtCoursesRef = _fireStore
            .collection('users')
            .doc(userId)
            .collection('boughtCourses');
        final cartRef =
            _fireStore.collection('users').doc(userId).collection('cart');

        final batch = _fireStore.batch();
        for (var course in _cartCourses) {
          final updatedCourse = course.copyWith(hasBought: true);
          batch.set(boughtCoursesRef.doc(updatedCourse.id), (updatedCourse as CourseModel).toJson());
          batch.delete(cartRef.doc(updatedCourse.id));
        }

        await batch.commit();

        _boughtCourses = _cartCourses;
        await clearCart();

        emit(CartPurchaseSuccess());

        if (!context.mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MyCoursesScreen(),
          ),
        );
      } else {
        emit(CartError('payment has failed.'));
      }
    } catch (e) {
      emit(CartError('Payment has failed: ${e.toString()}'));
    }
  }
}
