import 'package:edu_vista/l10n/app_localizations.dart';
import 'package:edu_vista/src/shared/utils/text_utility.dart';
import 'package:edu_vista/src/shared/widgets/buttons/my_elevated_button.dart';
import 'package:edu_vista/src/features/onboarding/onboarding_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/services/pref_service.dart';
import '../../shared/utils/color_utility.dart';
import '../../shared/utils/image_utility.dart';
import '../../shared/widgets/buttons/my_text_button.dart';
import '../auth/presentation/pages/login_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentPage = 0;
  late PageController onBoardingController;

  @override
  void initState() {
    super.initState();
    onBoardingController = PageController(initialPage: 0);
  }

  void onPageChangedEx(int page) {
    setState(() {
      currentPage = page;
    });
  }

  void skipToEnd() {
    onBoardingController.animateToPage(
      3,
      duration: const Duration(milliseconds: 250),
      curve: Curves.fastOutSlowIn,
    );
  }

  void goToNextPage() {
    onBoardingController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.fastOutSlowIn,
    );
  }

  void goToPreviousPage() {
    onBoardingController.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.fastOutSlowIn,
    );
  }

  void onStarting() {
    PreferencesService.isOnBoardingSeen = true;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  void dispose() {
    onBoardingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            buildSkipBackButton(),
            buildPageView(),
            buildBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget buildSkipBackButton() {
    return Positioned(
        top: 10.h,
        right: 10.w,
        child: MyTextButton(
            onPressed: currentPage == 3 ? goToPreviousPage : skipToEnd,
            text: currentPage == 3
                ? AppLocalizations.of(context)!.back
                : AppLocalizations.of(context)!.skip,
            textStyle: TextUtility.bodyText(
              color: ColorUtility.mediumBlack,
            )));
  }

  Widget buildPageView() {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h, right: 23.w, left: 23.w),
      child: PageView(
        controller: onBoardingController,
        onPageChanged: onPageChangedEx,
        children: [
          OnBoardingItem(
            imagePath: ImageUtility.certifications,
            title: AppLocalizations.of(context)!.certificationAndBadges,
            description: AppLocalizations.of(context)!.certificationDesc,
            sizedBoxHeight: 224.h,
            imageHeight: 290.h,
          ),
          OnBoardingItem(
            imagePath: ImageUtility.progressTracking,
            title: AppLocalizations.of(context)!.progressTracking,
            description: AppLocalizations.of(context)!.progressDesc,
          ),
          OnBoardingItem(
            imagePath: ImageUtility.offlineAccess,
            title: AppLocalizations.of(context)!.offlineAccess,
            description: AppLocalizations.of(context)!.offlineDesc,
          ),
          OnBoardingItem(
            imagePath: ImageUtility.courseCatalog,
            title: AppLocalizations.of(context)!.courseCatalog,
            description: AppLocalizations.of(context)!.courseCatalogDesc,
          ),
        ],
      ),
    );
  }

  Widget buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            width: 42.w,
            height: 7.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: currentPage == index
                    ? ColorUtility.secondary
                    : ColorUtility.grey)),
      ),
    );
  }

  Widget buildArrows() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        currentPage == 0
            ? const SizedBox()
            : IconButton(
                onPressed: goToPreviousPage,
                icon: const Icon(Icons.arrow_circle_left),
                color: Colors.grey.shade300,
                iconSize: 56.sp,
              ),
        IconButton(
          onPressed: goToNextPage,
          icon: const Icon(Icons.arrow_circle_right),
          color: ColorUtility.secondary,
          iconSize: 56.sp,
        ),
      ],
    );
  }

  Widget buildBottomSection() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildIndicator(),
            currentPage == 3
                ? Padding(
                    padding: EdgeInsets.only(
                        bottom: 73.h, top: 76.h, right: 30.w, left: 30.w),
                    child: MyElevatedButton(
                        child: Text(
                            AppLocalizations.of(context)!.letsStartLearning),
                        onPressed: () => onStarting()))
                : Padding(
                    padding: EdgeInsets.only(
                        bottom: 50.h, top: 60.h, right: 30.w, left: 30.w),
                    child: buildArrows()),
          ],
        ));
  }
}
