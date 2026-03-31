import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/utils/text_utility.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final IconData icon;
  final VoidCallback? onTap;

  const SettingTile({
    required this.title,
    required this.icon,
    this.trailing,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 24.sp,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(
        title,
        style: TextUtility.descriptionText(
          color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
        ),
      ),
      trailing: trailing,
    );
  }
}
