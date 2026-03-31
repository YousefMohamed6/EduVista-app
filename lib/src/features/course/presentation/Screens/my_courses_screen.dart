import 'package:edu_vista/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_vista/src/features/course/domain/entities/course.dart';
import 'package:edu_vista/src/features/cart/logic/cart_cubit/cart_cubit.dart';
import 'package:edu_vista/src/features/cart/presentation/widgets/shopping_cart_button.dart';
import 'package:edu_vista/src/features/course/presentation/widgets/course_tile.dart';
import 'package:edu_vista/src/shared/utils/color_utility.dart';
import 'package:edu_vista/src/shared/utils/image_utility.dart';
import 'package:edu_vista/src/shared/utils/text_utility.dart';
import 'package:edu_vista/src/features/course/presentation/Screens/course_screen.dart';

class MyCoursesScreen extends StatefulWidget {
  const MyCoursesScreen({super.key});

  @override
  State<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().fetchBoughtCourses();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            localization.myCourses,
            style: TextUtility.titleText(),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 14.w),
              child: const ShoppingCartButton(),
            ),
          ]),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: ColorUtility.secondary,
            ));
          }

          if (state is CartBoughtCourses) {
            if (state.boughtCourses.isEmpty) {
              return Center(
                  child: Text(localization.noCoursesBought,
                      style: TextUtility.fringeText(color: ColorUtility.grey)));
            }

            return _buildBoughtCoursesList(state.boughtCourses);
          }

          return _buildPlaceHolderWidget();
        },
      ),
    );
  }

  Widget _buildBoughtCoursesList(List<Course> boughtCourses) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: boughtCourses.length,
      separatorBuilder: (context, index) => SizedBox(height: 20.h),
      itemBuilder: (context, index) {
        final course = boughtCourses[index];
        return CourseTile(
          title: course.title,
          image: course.image,
          imagePlaceHolder: ImageUtility.courseImagePlaceholder,
          width: 157.w,
          height: 105.h,
          child: Row(
            children: [
              Icon(Icons.person, size: 20.sp),
              SizedBox(width: 5.w),
              Text(
                course.instructor?.name ?? '',
                style: TextUtility.bodyText(),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CourseScreen(course: course)));
          },
        );
      },
    );
  }

  Widget _buildPlaceHolderWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageUtility.notFound, width: 200.w),
          SizedBox(height: 20.h),
          Text(AppLocalizations.of(context)!.noCoursesAvailable, style: TextUtility.bodyText())
        ],
      ),
    );
  }
}
