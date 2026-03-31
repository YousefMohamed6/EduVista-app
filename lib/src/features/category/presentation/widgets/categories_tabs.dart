import 'package:edu_vista/src/features/category/presentation/Screens/category_courses_screen.dart';
import 'package:edu_vista/src/features/category/presentation/manager/category_bloc.dart';
import 'package:edu_vista/src/shared/utils/color_utility.dart';
import 'package:edu_vista/src/shared/utils/text_utility.dart';
import 'package:edu_vista/src/shared/widgets/buttons/my_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesTabs extends StatelessWidget {
  const CategoriesTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (ctx, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryError) {
            return Center(child: Text(state.message));
          } else if (state is CategoryLoaded) {
            final categories = state.categories;
            return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (context, index) => SizedBox(width: 10.w),
                itemBuilder: (context, index) => MyTextButton(
                    text: categories[index].name,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryCoursesScreen(
                                  categoryId: categories[index].id,
                                  categoryName: categories[index].name)));
                    },
                    textStyle: TextUtility.headerText(),
                    textButtonStyle: TextButton.styleFrom(
                      backgroundColor: ColorUtility.softGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.r),
                      ),
                    )));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
