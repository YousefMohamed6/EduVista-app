import 'package:edu_vista/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:edu_vista/src/features/lecture/presentation/widgets/video_box.dart';
import 'package:edu_vista/src/shared/utils/text_utility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/utils/color_utility.dart';
import '../../../home/presentation/pages/root_page.dart';
import '../../data/lecture_model.dart';

class LectureVideoPage extends StatelessWidget {
  final Lecture? lecture;
  final List<Lecture>? allLectures;

  const LectureVideoPage({
    required this.lecture,
    required this.allLectures,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentIndex = allLectures?.indexOf(lecture!) ?? -1;
    final previousLecture =
        currentIndex > 0 ? allLectures![currentIndex - 1] : null;
    final nextLecture = currentIndex < (allLectures?.length ?? 0) - 1
        ? allLectures![currentIndex + 1]
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(lecture?.title ?? AppLocalizations.of(context)!.lectureVideo,
            style: TextUtility.titleText()),
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const RootPage()));
            },
            icon: Icon(Icons.arrow_back_ios, size: 20.sp),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            lecture?.lecture_url == null || lecture!.lecture_url!.isEmpty
                ? Center(
                    child: Text(AppLocalizations.of(context)!.invalidUrl,
                        style: TextUtility.titleText()),
                  )
                : YoutubeVideoPlayer(videoUrl: lecture!.lecture_url!),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 5.h),
                    _buildControlButtons(context, previousLecture, nextLecture),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButtons(
      BuildContext context, Lecture? previousLecture, Lecture? nextLecture) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        previousLecture != null
            ? _getIcon(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LectureVideoPage(
                      lecture: previousLecture,
                      allLectures: allLectures,
                    ),
                  ),
                );
              }, Icons.fast_rewind)
            : const SizedBox.shrink(),
        _buildInfo(),
        nextLecture != null
            ? _getIcon(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LectureVideoPage(
                      lecture: nextLecture,
                      allLectures: allLectures,
                    ),
                  ),
                );
              }, Icons.fast_forward)
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget _getIcon(VoidCallback? onPressed, IconData? icon) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: ColorUtility.secondary, size: 50.sp),
    );
  }

  Widget _buildInfo() {
    return Expanded(
      child: Column(
        children: [
          Text(
            lecture?.title ?? '',
            style: TextUtility.titleText(color: ColorUtility.mediumBlack),
            textAlign: TextAlign.center,
          ),
          Text(
            lecture?.description ?? '',
            style: TextUtility.bodyText(color: ColorUtility.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
