import 'package:edu_vista/src/features/course/domain/entities/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/utils/color_utility.dart';
import '../../../cart/logic/cart_cubit/cart_cubit.dart';

class AddToCartButton extends StatelessWidget {
  final Course course;

  const AddToCartButton({required this.course, super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.read<CartCubit>().addCourseToCart(course);
      },
      backgroundColor: ColorUtility.secondary,
      child: Icon(
        Icons.add_shopping_cart,
        size: 24.sp,
      ),
    );
  }
}
