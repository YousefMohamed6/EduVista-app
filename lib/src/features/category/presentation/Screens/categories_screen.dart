import 'package:edu_vista/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/widgets/my_app_bar.dart';
import '../../../../shared/widgets/tiles/my_expansion_tile.dart';
import '../../../course/domain/repositories/course_repository.dart';
import '../../../course/presentation/manager/course_bloc.dart';
import '../../../course/presentation/widgets/courses_wrap.dart';
import '../manager/category_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
        appBar: MyAppBar(
          title: localization.categories,
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 16.w),
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (ctx, state) {
              if (state is CategoryLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CategoryError) {
                return Center(child: Text(state.message));
              } else if (state is CategoryLoaded) {
                final categories = state.categories;
                return ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 20.h),
                    itemCount: categories.length,
                    itemBuilder: (context, index) => MyExpansionTile(
                          title: categories[index].name,
                          child: BlocProvider(
                            create: (context) => CourseBloc(
                                context.read<CourseRepository>())
                              ..add(GetCoursesEvent(
                                  categoryId: categories[index].id)),
                            child: BlocBuilder<CourseBloc, CourseState>(
                              builder: (context, courseState) {
                                if (courseState is CourseLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (courseState is CourseError) {
                                  return Center(child: Text(courseState.message));
                                } else if (courseState is CoursesLoaded) {
                                  return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 30.h),
                                      child: SizedBox(
                                          height: 360.h,
                                          child: CoursesWrap(
                                              courses: courseState.courses)));
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                        ));
              }
              return const SizedBox.shrink();
            },
          ),
        )));
  }
}
