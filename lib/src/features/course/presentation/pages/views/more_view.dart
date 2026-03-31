import 'package:edu_vista/src/features/course/domain/entities/course.dart';
import 'package:edu_vista/src/shared/widgets/buttons/my_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../shared/utils/color_utility.dart';
import '../../../../../shared/widgets/tiles/my_expansion_tile.dart';
import '../../../../instructor/presentation/instructor_tile.dart';

class MoreView extends StatelessWidget {
  final Course? course;

  MoreView({required this.course, super.key});
  final List<String> moreOptions = [
    "About Instructor",
    "Course Resource",
  ];

  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (course == null) return const SizedBox.shrink();

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => SizedBox(height: 20.h),
      itemCount: moreOptions.length,
      itemBuilder: (context, index) => MyExpansionTile(
        title: moreOptions[index],
        child: index == 0
            ? _buildAboutInstructor()
            : index == 1
                ? _buildResources()
                : const SizedBox(),
      ),
    );
  }

  Widget _buildAboutInstructor() {
    return Padding(
      padding: EdgeInsets.all(10.h),
      child: Container(
          decoration: BoxDecoration(
              color: ColorUtility.subtleGrey,
              borderRadius: BorderRadius.circular(9.r),
              border: Border.all(color: ColorUtility.softGrey)),
          child: InstructorTile(instructor: course!.instructor)),
    );
  }

  Widget _buildResources() {
    if (course!.resource == null || course!.resource!.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(10.h),
        child: const Text('No resources available for this course'),
      );
    }
    return Padding(
        padding: EdgeInsets.all(10.h),
        child: Row(
          children: [
            const Icon(
              Icons.arrow_right_alt,
              color: ColorUtility.secondary,
            ),
            SizedBox(width: 10.w),
            Flexible(
              child: MyTextButton(
                  text: course!.title,
                  onPressed: () {
                    launchURL(course!.resource!);
                  }),
            )
          ],
        ));
  }
}
