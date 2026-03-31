import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_vista/src/features/instructor/domain/entities/instructor.dart';
import 'package:edu_vista/src/features/instructor/presentation/Screens/instructor_screen.dart';

import '../../../shared/utils/color_utility.dart';
import '../../../shared/utils/image_utility.dart';
import '../../../shared/utils/text_utility.dart';
import '../../../shared/widgets/fetch_image_widget.dart';

class InstructorTile extends StatelessWidget {
  final Instructor? instructor;
  const InstructorTile({required this.instructor, super.key});

  @override
  Widget build(BuildContext context) {
    if (instructor == null) return const SizedBox.shrink();

    return ListTile(
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: FetchImageWidget(
                image: instructor!.image,
                imagePlaceHolder: ImageUtility.instructorImagePlaceholder)),
        title: Text(instructor!.name,
            style: TextUtility.headerText(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Text(
              instructor!.education,
              style: TextUtility.fringeText(color: ColorUtility.grey),
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: ColorUtility.grey,
          size: 15.sp,
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      InstructorScreen(instructor: instructor!)));
        });
  }
}
