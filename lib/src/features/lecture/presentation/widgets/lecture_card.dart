import 'package:edu_vista/l10n/app_localizations.dart';
import 'package:edu_vista/src/shared/utils/text_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/lecture_model.dart';

class LectureCard extends StatelessWidget {
  final Lecture? lecture;
  final Color? containerColor;
  final Color textcolor;
  final Color iconcolor;
  final FontWeight textFontWeight;
  final Widget watchedIcon;

  const LectureCard(
      {required this.lecture,
      required this.containerColor,
      required this.textcolor,
      required this.iconcolor,
      required this.textFontWeight,
      required this.watchedIcon,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.2,
      color: containerColor,
      surfaceTintColor: containerColor,
      child: Container(
        height: 160.h,
        width: 163.w,
        padding: EdgeInsets.all(12.h),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.lectureCount(lecture!.sort!),
                    style: TextUtility.bodyText(
                      fontWeight: FontWeight.w700,
                      color: textcolor,
                    )),
                watchedIcon,
              ],
            ),
            SizedBox(height: 5.h),
            Text(lecture!.title ?? '',
                style: TextUtility.bodyText(
                    fontWeight: textFontWeight, color: textcolor)),
            SizedBox(height: 5.h),
            Text(lecture!.description ?? '',
                style: TextUtility.fringeText(
                    fontWeight: textFontWeight, color: textcolor)),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    AppLocalizations.of(context)!
                        .durationMin(lecture!.duration!),
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: textFontWeight,
                        color: textcolor)),
                Icon(
                  Icons.play_circle_outline,
                  color: iconcolor,
                  size: 40.sp,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
