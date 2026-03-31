import 'package:edu_vista/l10n/app_localizations.dart';
import 'package:edu_vista/src/features/course/domain/entities/course.dart';
import 'package:edu_vista/src/shared/utils/image_utility.dart';
import 'package:edu_vista/src/shared/widgets/my_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/utils/color_utility.dart';
import '../../../../shared/utils/text_utility.dart';
import '../../../../shared/widgets/buttons/my_elevated_button.dart';
import '../../../course/presentation/widgets/course_tile.dart';
import '../../logic/cart_cubit/cart_cubit.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.cart,
          style: TextUtility.titleText(),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20.sp,
              )),
        ),
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartPurchaseSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)!.purchaseSuccessful),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CartLoaded) {
            if (state.cartItems.isEmpty) {
              return Center(
                  child: Text(AppLocalizations.of(context)!.cartEmpty,
                      style: TextUtility.fringeText(color: ColorUtility.grey)));
            }
            double totalPrice = context.read<CartCubit>().totalPriceInEGP();

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 30.h),
              child: Column(
                children: [
                  _buildCartCoursesList(state.cartItems),
                  MyElevatedButton(
                    onPressed: () {
                      context.read<CartCubit>().buyCourses(context);
                    },
                    color: ColorUtility.main,
                    child: Text(AppLocalizations.of(context)!.startCoursesNow(
                        totalPrice.toString(),
                        AppLocalizations.of(context)!.egp)),
                  ),
                ],
              ),
            );
          }
          return _buildPlaceHolderWidget();
        },
      ),
    );
  }

  Widget _buildCartCoursesList(List<Course> cartItems) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 20.h),
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final course = cartItems[index];
          return _deleteCourse(
            course,
            CourseTile(
              title: course.title,
              image: course.image,
              imagePlaceHolder: ImageUtility.courseImagePlaceholder,
              width: 157,
              height: 105,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, size: 20.sp),
                      Text(
                        course.instructor?.name ?? '',
                        style: TextUtility.bodyText(),
                      ),
                    ],
                  ),
                  Text("\$ ${course.price!}",
                      style: TextUtility.fringeText(
                          color: ColorUtility.main,
                          fontWeight: FontWeight.w800)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _deleteCourse(Course course, Widget child) {
    return Dismissible(
      key: Key(course.id),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(9.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(Icons.delete, color: Colors.white),
              SizedBox(width: 10.w),
              Text(
                AppLocalizations.of(context)!.delete,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      onDismissed: (direction) {
        showDialog(
            context: context,
            builder: (context) {
              return MyDialog(
                  title: AppLocalizations.of(context)!.deleteConfirmation,
                  child: const SizedBox(),
                  onConfirm: () {
                    context.read<CartCubit>().removeCourseFromCart(course);
                  });
            });
      },
      child: child,
    );
  }

  Widget _buildPlaceHolderWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageUtility.notFound),
          Text(AppLocalizations.of(context)!.cartLoadError,
              style: TextUtility.fringeText(color: ColorUtility.grey))
        ],
      ),
    );
  }
}
