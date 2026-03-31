import 'package:edu_vista/src/shared/utils/color_utility.dart';
import 'package:edu_vista/src/shared/widgets/fetch_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/utils/image_utility.dart';
import '../../data/model/user_model.dart';

class UserImage extends StatelessWidget {
  final AppUser user;
  final Function()? onPressed;
  const UserImage({required this.user, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 115,
          height: 115,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(80.r),
              child: FetchImageWidget(
                  image: user.image,
                  imagePlaceHolder: ImageUtility.userImagePlaceholder)),
        ),
        Positioned(
          bottom: 0.h,
          right: 1.w,
          child: IconButton(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(ColorUtility.blue),
            ),
            icon: Icon(
              Icons.edit,
              size: 20.sp,
              color: Colors.white,
            ),
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}
