import 'package:edu_vista/src/features/course/domain/entities/course.dart';
import 'package:edu_vista/src/features/course/presentation/pages/views/lectures_view.dart';
import 'package:edu_vista/src/features/course/presentation/pages/views/more_view.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/app_enums.dart';
import '../../helper/dialog_helper.dart';

class CourseOptionsWidgets extends StatefulWidget {
  final CourseOptions courseOption;
  final Course course;

  const CourseOptionsWidgets({
    required this.courseOption,
    required this.course,
    super.key,
  });

  @override
  State<CourseOptionsWidgets> createState() => _CourseOptionsWidgetsState();
}

class _CourseOptionsWidgetsState extends State<CourseOptionsWidgets> {
  @override
  Widget build(BuildContext context) {
    if (widget.courseOption == CourseOptions.Certificate) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CertificateDialog.show(context, widget.course);
      });
      return const SizedBox();
    }
    switch (widget.courseOption) {
      case CourseOptions.Lecture:
        return LecturesView(
          course: widget.course,
        );

      case CourseOptions.More:
        return MoreView(
          course: widget.course,
        );
      default:
        return Text('Invalid option ${widget.courseOption.name}');
    }
  }
}
