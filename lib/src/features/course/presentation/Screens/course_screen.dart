import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_vista/src/features/cart/presentation/widgets/add_to_cart_button.dart';
import 'package:edu_vista/src/features/course/domain/entities/course.dart';
import 'package:edu_vista/src/shared/utils/color_utility.dart';
import 'package:edu_vista/src/shared/utils/image_utility.dart';
import 'package:edu_vista/src/shared/utils/text_utility.dart';
import 'package:edu_vista/src/shared/widgets/fetch_image_widget.dart';

import '../manager/course_bloc.dart';
import '../widgets/course_chips.dart';
import '../widgets/course_options.dart';

class CourseScreen extends StatefulWidget {
  final Course course;
  const CourseScreen({required this.course, super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  void initState() {
    context.read<CourseBloc>().add(CourseFetchEvent(widget.course));
    super.initState();
  }

  bool applyChanges = false;

  void initAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        applyChanges = true;
      });
    });
  }

  @override
  void didChangeDependencies() {
    initAnimation();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              height: 390.h,
              child: FetchImageWidget(
                  image: widget.course.image,
                  imagePlaceHolder: ImageUtility.courseImagePlaceholder)),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  topRight: Radius.circular(25.r),
                ),
              ),
              duration: const Duration(seconds: 3),
              alignment: Alignment.bottomCenter,
              height:
                  applyChanges ? MediaQuery.sizeOf(context).height - 250 : null,
              curve: Curves.easeInOut,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: 10.h, top: 5.h, right: 15.w, left: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 30),
                    Text(widget.course.title, style: TextUtility.titleText()),
                    const SizedBox(height: 5),
                    Text(
                      widget.course.instructor?.name ?? '',
                      style: TextUtility.bodyText(),
                    ),
                    const SizedBox(height: 10),
                    const _BodyWidget()
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 20.h,
            left: 16.w,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: ColorUtility.secondary,
              ),
            ),
          ),
          Positioned(
            bottom: 20.h,
            right: 20.w,
            child: AddToCartButton(course: widget.course),
          ),
        ],
      ),
    );
  }
}

class _BodyWidget extends StatefulWidget {
  const _BodyWidget();

  @override
  State<_BodyWidget> createState() => __BodyWidgetState();
}

class __BodyWidgetState extends State<_BodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CourseBloc, CourseState>(
        builder: (ctx, state) {
          return Column(
            children: [
              CourseChips(
                selectedOption: (state is CourseOptionStateChanges)
                    ? state.courseOption
                    : null,
                onChanged: (courseOption) {
                  context
                      .read<CourseBloc>()
                      .add(CourseOptionChosenEvent(courseOption));
                },
              ),
              Expanded(
                child: (state is CourseOptionStateChanges)
                    ? CourseOptionsWidgets(
                        course: context.read<CourseBloc>().course!,
                        courseOption: state.courseOption,
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          );
        },
      ),
    );
  }
}
