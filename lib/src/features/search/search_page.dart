import 'package:edu_vista/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_vista/src/features/course/domain/entities/course.dart';
import 'package:edu_vista/src/features/instructor/domain/entities/instructor.dart';
import 'package:edu_vista/src/features/course/presentation/Screens/course_screen.dart';
import 'package:edu_vista/src/features/instructor/presentation/instructor_tile.dart';
import 'package:edu_vista/src/features/search/search_bar.dart';
import 'package:edu_vista/src/shared/utils/image_utility.dart';

import '../../shared/utils/text_utility.dart';
import '../../shared/widgets/tiles/my_expansion_tile.dart';
import '../cart/presentation/widgets/shopping_cart_button.dart';
import '../course/presentation/manager/course_bloc.dart';
import '../course/presentation/widgets/course_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Course>? allCourses;
  List<Course>? filteredCourses;
  List<Instructor>? filteredInstructors;
  bool hasSearched = false;

  void handleSearch(String query) {
    if (allCourses == null) return;
    setState(() {
      hasSearched = true;

      filteredCourses = allCourses!.where((course) {
        return course.title.toLowerCase().contains(query.toLowerCase());
      }).toList();

      filteredInstructors = allCourses!
          .map((course) => course.instructor)
          .where((instructor) =>
              instructor != null &&
              instructor.name.toLowerCase().contains(query.toLowerCase()))
          .cast<Instructor>()
          .toSet()
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<CourseBloc>()..add(GetCoursesEvent()),
      child: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          if (state is CoursesLoaded) {
            allCourses = state.courses;
          }

          final noCoursesFound =
              filteredCourses != null && filteredCourses!.isEmpty;
          final noInstructorsFound =
              filteredInstructors != null && filteredInstructors!.isEmpty;

          return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: SizedBox(
                    width: 290.w, child: MySearchBar(onSearch: handleSearch)),
                automaticallyImplyLeading: false,
                actions: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: 14.w,
                    ),
                    child: const ShoppingCartButton(),
                  ),
                ]),
            body: state is CourseLoading
                ? const Center(child: CircularProgressIndicator())
                : (hasSearched && noCoursesFound && noInstructorsFound
                    ? Center(child: Image.asset(ImageUtility.notFound))
                    : Padding(
                        padding: EdgeInsets.only(
                            top: 40.h, bottom: 16.h, right: 16.w, left: 16.w),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (filteredCourses != null &&
                                  filteredCourses!.isNotEmpty)
                                _buildCategorySearch(),
                              SizedBox(height: 30.h),
                              if (filteredInstructors != null &&
                                  filteredInstructors!.isNotEmpty)
                                _buildInstructorsSearch(),
                            ],
                          ),
                        ),
                      )),
          );
        },
      ),
    );
  }

  Widget _buildCategorySearch() {
    return MyExpansionTile(
      title: AppLocalizations.of(context)!.courses,
      expanded: true,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(height: 20.h),
          itemCount: filteredCourses!.length,
          itemBuilder: (context, index) {
            final course = filteredCourses![index];
            return CourseTile(
              title: course.title,
              image: course.image,
              imagePlaceHolder: ImageUtility.courseImagePlaceholder,
              width: 120,
              height: 100,
              child: Row(
                children: [
                  Icon(Icons.person, size: 20.sp),
                  Text(
                    course.instructor?.name ?? '',
                    style: TextUtility.bodyText(),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CourseScreen(course: course)));
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildInstructorsSearch() {
    return MyExpansionTile(
      title: AppLocalizations.of(context)!.instructors,
      expanded: true,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(height: 20.h),
          itemCount: filteredInstructors!.length,
          itemBuilder: (context, index) {
            final instructor = filteredInstructors![index];
            return InstructorTile(instructor: instructor);
          },
        ),
      ),
    );
  }
}
