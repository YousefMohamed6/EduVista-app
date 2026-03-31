import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../shared/utils/constants/app_constants.dart';
import '../../../../shared/utils/constants/firestore_keys.dart';
import '../../domain/entities/course.dart';
import '../../domain/repositories/course_repository.dart';
import '../models/course_model.dart';

class CourseRepositoryImpl implements CourseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<List<Course>> getCourses({String? rank, String? categoryId, String? instructorId}) async {
    Query query = _firestore.collection(AppConstants.coursesCollection);

    if (rank != null) {
      query = query.where(FirestoreKeys.rank, isEqualTo: rank);
    }
    if (categoryId != null) {
      query = query.where(FirestoreKeys.categoryId, isEqualTo: categoryId);
    }
    if (instructorId != null) {
      // Assuming instructor is nested or you query by instructor.id
      query = query.where('${FirestoreKeys.instructor}.${FirestoreKeys.id}', isEqualTo: instructorId);
    }

    final querySnapshot =
        await query.orderBy(FirestoreKeys.createdDate, descending: true).get();

    return querySnapshot.docs
        .map((doc) => CourseModel.fromJson(
            {'id': doc.id, ...doc.data() as Map<String, dynamic>}))
        .toList();
  }

  @override
  Future<List<Course>> getRecentlyViewedCourses() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return [];

    final snapshot = await _firestore
        .collection(AppConstants.usersCollection)
        .doc(userId)
        .collection(FirestoreKeys.cart)
        .get();

    return snapshot.docs
        .map((doc) => CourseModel.fromJson(
            {'id': doc.id, ...doc.data() as Map<String, dynamic>}))
        .toList();
  }

  @override
  Future<void> addCourseToRecentlyViewed(Course course) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore
        .collection(AppConstants.usersCollection)
        .doc(userId)
        .collection(FirestoreKeys.cart)
        .doc(course.id)
        .set((course as CourseModel).toJson());
  }
}
