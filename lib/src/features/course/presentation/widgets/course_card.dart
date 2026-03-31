import 'package:edu_vista/src/shared/utils/image_utility.dart';
import 'package:edu_vista/src/shared/utils/text_utility.dart';
import 'package:edu_vista/src/shared/widgets/rating_star.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/course.dart';
import '../Screens/course_screen.dart';
import '../../../../shared/utils/color_utility.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //    context.read<CourseBloc>().addCourseToRv(course);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CourseScreen(course: course)));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: ColorUtility.softGrey,
            surfaceTintColor: ColorUtility.softGrey,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.r),
            ),
            child: Container(
              height: 120.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.r),
                image: DecorationImage(
                  image: NetworkImage(course.image == ''
                      ? ImageUtility.courseImagePlaceholder
                      : course.image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Text(
                '${course.rating}',
                style: TextUtility.hintText(color: Colors.grey),
              ),
              RatingStar(rating: course.rating ?? 0.0)
            ],
          ),
          SizedBox(height: 5.h),
          Text(course.title,
              style: TextUtility.headerText(fontWeight: FontWeight.w600)),
          const Spacer(),
          Row(
            children: [
              Icon(Icons.person, size: 20.sp),
              Text(
                course.instructor?.name ?? '',
                style: TextUtility.bodyText(),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Text("\$ ${course.price}",
              style: TextUtility.subtitleText(
                color: ColorUtility.main,
                fontWeight: FontWeight.w800,
              )),
        ],
      ),
    );
  }
}
