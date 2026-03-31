import 'package:edu_vista/l10n/app_localizations.dart';
import 'package:edu_vista/src/features/course/domain/repositories/course_repository.dart';
import 'package:edu_vista/src/features/course/presentation/manager/course_bloc.dart';
import 'package:edu_vista/src/features/course/presentation/widgets/courses_wrap.dart';
import 'package:edu_vista/src/features/instructor/domain/entities/instructor.dart';
import 'package:edu_vista/src/shared/utils/color_utility.dart';
import 'package:edu_vista/src/shared/utils/image_utility.dart';
import 'package:edu_vista/src/shared/utils/text_utility.dart';
import 'package:edu_vista/src/shared/widgets/fetch_image_widget.dart';
import 'package:edu_vista/src/shared/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InstructorScreen extends StatelessWidget {
  final Instructor instructor;
  const InstructorScreen({required this.instructor, super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => CourseBloc(context.read<CourseRepository>())
        ..add(GetCoursesEvent(instructorId: instructor.id)),
      child: Scaffold(
        appBar: MyAppBar(title: localization.instructorInfo),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(16.h),
          child: Column(
            children: [
              SizedBox(
                width: 90.w,
                height: 90.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.r),
                  child: FetchImageWidget(
                    image: instructor.image,
                    imagePlaceHolder: ImageUtility.instructorImagePlaceholder,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                instructor.name,
                style: TextUtility.titleText(),
              ),
              SizedBox(height: 60.h),
              Container(
                  padding: EdgeInsets.all(20.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.r),
                      border: Border.all(color: ColorUtility.softGrey)),
                  child: Column(
                    children: [
                      _infoPoint(localization.education, instructor.education),
                      SizedBox(height: 20.h),
                      _infoPoint(localization.yearsOfExperience,
                          '${instructor.yearsOfExperience} ${localization.years}'),
                    ],
                  )),
              SizedBox(height: 30.h),
              Row(
                children: [
                  const Icon(
                    Icons.lightbulb,
                    color: ColorUtility.secondary,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          localization.continueLearning,
                          style: TextUtility.headerText(
                              color: ColorUtility.mediumBlack,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              BlocBuilder<CourseBloc, CourseState>(
                builder: (context, state) {
                  if (state is CourseLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CourseError) {
                    return Center(child: Text(state.message));
                  } else if (state is CoursesLoaded) {
                    return state.courses.isNotEmpty
                        ? CoursesWrap(courses: state.courses)
                        : Text(localization.noCoursesForInstructor,
                            style: TextUtility.fringeText(
                                color: ColorUtility.grey));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget _infoPoint(String point, String info) {
    return Row(
      children: [
        const Icon(Icons.arrow_right_alt, color: ColorUtility.mediumBlack),
        SizedBox(width: 10.w),
        Text(
          point,
          style: TextUtility.headerText(
              color: ColorUtility.mediumBlack, fontWeight: FontWeight.w700),
        ),
        SizedBox(width: 5.w),
        Expanded(
          child: Column(
            children: [
              Text(
                info,
                style: TextUtility.fringeText(color: ColorUtility.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
