import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_vista/src/features/course/domain/repositories/course_repository.dart';
import 'package:edu_vista/src/features/course/presentation/manager/course_bloc.dart';
import 'package:edu_vista/src/features/course/presentation/widgets/courses_wrap.dart';
import 'package:edu_vista/src/shared/widgets/my_app_bar.dart';

class CategoryCoursesScreen extends StatelessWidget {
  final String categoryId;
  final String categoryName;

  const CategoryCoursesScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseBloc(context.read<CourseRepository>())
        ..add(GetCoursesEvent(categoryId: categoryId)),
      child: Scaffold(
          appBar: MyAppBar(
            title: categoryName,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 20.h, right: 5.w, left: 30.w),
              child: BlocBuilder<CourseBloc, CourseState>(
                builder: (context, state) {
                   if (state is CourseLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CourseError) {
                    return Center(child: Text(state.message));
                  } else if (state is CoursesLoaded) {
                    return Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.h),
                        child: SizedBox(
                            height: 360.h,
                            child: CoursesWrap(courses: state.courses)));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          )),
    );
  }
}
