import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/src/features/course/presentation/Screens/my_courses_screen.dart';
import 'package:edu_vista/src/features/home/presentation/pages/home_page.dart';
import 'package:edu_vista/src/features/search/search_page.dart';
import 'package:edu_vista/src/shared/utils/image_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/widgets/fetch_image_widget.dart';
import '../../../../shared/utils/color_utility.dart';
import '../../../../shared/widgets/builders/my_future_builder.dart';
import '../../../profile/data/model/user_model.dart';
import '../../../profile/presentation/pages/profie_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int selectedIndex = 0;

  static const List<Widget> pages = [
    HomePage(),
    MyCoursesScreen(),
    SearchPage(),
    ProfilePage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchUserData() {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    return FirebaseFirestore.instance
        .collection("users")
        .where('id', isEqualTo: userId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: MyFutureBuilder<AppUser>(
        futureCall: fetchUserData(),
        fromJson: (doc) => AppUser.fromJson({
          'id': doc.id,
          ...doc.data(),
        }),
        builder: (context, data) {
          String userImage = ImageUtility.userImagePlaceholder;

          if (data.isNotEmpty) {
            userImage = data.first.image ?? ImageUtility.userImagePlaceholder;
          }

          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            onTap: onItemTapped,
            unselectedItemColor: ColorUtility.mediumBlack,
            selectedItemColor: ColorUtility.secondary,
            iconSize: 25.sp,
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_outlined),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  height: 35,
                  width: 35,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.r),
                    child: FetchImageWidget(
                        image: userImage,
                        imagePlaceHolder: ImageUtility.userImagePlaceholder),
                  ),
                ),
                label: '',
              ),
            ],
          );
        },
      ),
    );
  }
}
