import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_vista/src/features/course/domain/repositories/course_repository.dart';
import 'package:edu_vista/src/features/course/presentation/manager/course_bloc.dart';
import 'course_card.dart';

class CoursesWidget extends StatelessWidget {
  final String rankValue;
  const CoursesWidget({super.key, required this.rankValue});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseBloc(context.read<CourseRepository>())
        ..add(GetCoursesEvent(rank: rankValue)),
      child: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          if (state is CourseLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CourseError) {
            return Center(child: Text(state.message));
          } else if (state is CoursesLoaded) {
            final courses = state.courses;
            return SizedBox(
              height: 300.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 170.w,
                    margin: EdgeInsets.symmetric(horizontal: 6.w),
                    child: CourseCard(course: courses[index]),
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
