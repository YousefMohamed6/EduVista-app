import 'package:edu_vista/l10n/app_localizations.dart';
import 'package:edu_vista/src/features/category/presentation/Screens/categories_screen.dart';
import 'package:edu_vista/src/features/course/presentation/Screens/see_all_courses_screen.dart';
import 'package:edu_vista/src/features/home/presentation/widgets/label_widget.dart';
import 'package:edu_vista/src/shared/utils/color_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/utils/text_utility.dart';
import '../../../cart/presentation/widgets/shopping_cart_button.dart';
import '../../../category/presentation/widgets/categories_tabs.dart';
import '../../../course/presentation/widgets/courses_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(localization.welcomeBack, style: TextUtility.titleText()),
                  Text(
                      ' ${FirebaseAuth.instance.currentUser?.displayName?.split(' ').first}',
                      style: TextUtility.titleText(color: ColorUtility.main))
                ],
              ),
              const ShoppingCartButton(),
            ],
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 16.w, top: 16.h, bottom: 16.h),
            child: Column(
              children: [
                LabelWidget(
                    label: localization.categories,
                    seeAllPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CategoriesScreen()));
                    }),
                SizedBox(height: 10.h),
                const CategoriesTabs(),
                SizedBox(height: 30.h),
                LabelWidget(
                    label: localization.topRatedCourses,
                    seeAllPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SeeAllCoursesScreen(
                                    label: localization.topRatedCourses,
                                    rankValue: 'top rated',
                                  )));
                    }),
                SizedBox(height: 10.h),
                const CoursesWidget(rankValue: 'top rated'),
                SizedBox(height: 20.h),
                LabelWidget(
                    label: localization.bestSellerCourses,
                    seeAllPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SeeAllCoursesScreen(
                                    label: localization.bestSellerCourses,
                                    rankValue: 'best seller',
                                  )));
                    }),
                SizedBox(height: 10.h),
                const CoursesWidget(rankValue: 'best seller'),
              ],
            ),
          ),
        )));
  }
}
