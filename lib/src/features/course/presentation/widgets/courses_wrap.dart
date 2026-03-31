import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_vista/src/features/course/domain/entities/course.dart';
import 'package:edu_vista/src/features/course/presentation/widgets/course_card.dart';
import 'package:edu_vista/src/shared/utils/color_utility.dart';

class CoursesWrap extends StatelessWidget {
  final List<Course> courses;
  const CoursesWrap({required this.courses, super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10.w,
      runSpacing: 10.h,
      children: List.generate(courses.length, (index) {
        return Container(
          width: 170.w,
          height: 320.h,
          padding: EdgeInsets.all(8.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: ColorUtility.softGrey)),
          child: CourseCard(course: courses[index]),
        );
      }),
    );
  }
}
