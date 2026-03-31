import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/src/features/course/domain/entities/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../shared/utils/color_utility.dart';
import '../../../../lecture/data/lecture_model.dart';
import '../../../../lecture/logic/lecture_bloc/lecture_bloc.dart';
import '../../../../lecture/presentation/pages/lecture_video_page.dart';
import '../../../../lecture/presentation/widgets/lecture_card.dart';

class LecturesView extends StatefulWidget {
  final Course? course;

  const LecturesView({
    required this.course,
    super.key,
  });

  @override
  State<LecturesView> createState() => _LecturesViewState();
}

class _LecturesViewState extends State<LecturesView> {
  late Future<QuerySnapshot<Map<String, dynamic>>> futureCall;

  List<Lecture>? lectures;
  bool isLoading = true;
  Lecture? selectedLecture;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(milliseconds: 1200), () async {});
    if (!mounted) return;
    lectures =
        await context.read<LectureBloc>().fetchLectures(widget.course!.id);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (lectures == null || (lectures!.isEmpty)) {
      return const Center(
        child: Text('No lectures found'),
      );
    } else {
      return GridView.count(
        mainAxisSpacing: 40.h,
        crossAxisSpacing: 15.w,
        shrinkWrap: true,
        crossAxisCount: 2,
        children: List.generate(lectures!.length, (index) {
          return InkWell(
            onTap: () {
              context
                  .read<LectureBloc>()
                  .add(LectureProgressUpdateEvent(widget.course!.id));
              selectedLecture = lectures![index];
              context
                  .read<LectureBloc>()
                  .add(LectureChosenEvent(selectedLecture!));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LectureVideoPage(
                    lecture: lectures![index],
                    allLectures: lectures,
                  ),
                ),
              );
            },
            child: LectureCard(
              lecture: lectures![index],
              containerColor: selectedLecture?.id == lectures![index].id
                  ? ColorUtility.secondary
                  : ColorUtility.softGrey,
              textcolor: selectedLecture?.id == lectures![index].id
                  ? Colors.white
                  : Colors.black,
              textFontWeight: selectedLecture?.id == lectures![index].id
                  ? FontWeight.w700
                  : FontWeight.w400,
              iconcolor: selectedLecture?.id == lectures![index].id
                  ? Colors.white
                  : Colors.black,
              watchedIcon: selectedLecture?.id == lectures![index].id
                  ? Icon(Icons.done_all,
                      color: selectedLecture?.id == lectures![index].id
                          ? Colors.white
                          : Colors.black)
                  : const SizedBox(),
            ),
          );
        }),
      );
    }
  }
}
