import 'package:edu_vista/l10n/app_localizations.dart';
import 'package:edu_vista/src/features/profile/presentation/pages/profie_page.dart';
import 'package:edu_vista/src/shared/utils/text_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/widgets/buttons/my_text_button.dart';
import '../../../auth/logic/auth_cubit/auth_cubit.dart';
import '../../../auth/presentation/pages/password_reset_page.dart';
import '../../data/model/user_model.dart';
import '../../logic/user_cubit/user_cubit.dart';
import '../../../../shared/widgets/my_dialog.dart';
import 'profile_edit_list_tile.dart';
import '../../../../shared/widgets/text_filed/my_text_field.dart';
import '../../../../shared/utils/color_utility.dart';
import '../../../../shared/widgets/buttons/my_elevated_button.dart';

class ProfileEditExpansionTile extends StatefulWidget {
  final AppUser user;

  const ProfileEditExpansionTile({
    required this.user,
    super.key,
  });

  @override
  State<ProfileEditExpansionTile> createState() =>
      _ProfileEditExpansionTileState();
}

class _ProfileEditExpansionTileState extends State<ProfileEditExpansionTile> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();

  final genderController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    phoneController.dispose();
    ageController.dispose();

    genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Form(
      key: formKey,
      child: Padding(
        padding:
            EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w, bottom: 10.h),
        child: Column(
          children: [
            ProfileListTile(
              title: localization.fullName,
              subtitle: widget.user.name,
              onPressed: () => _showNameDialog(context, localization),
            ),
            ProfileListTile(
              title: localization.email,
              subtitle: widget.user.email,
              onPressed: () => _showEmailDialog(context, localization),
            ),
            ProfileListTile(
              title: localization.password,
              onPressed: () => _showPasswordChangeDialog(context, localization),
            ),
            ProfileListTile(
              title: localization.phoneNumber,
              subtitle: widget.user.phoneNumber,
              onPressed: () => _showPhoneNumberDialog(context, localization),
            ),
            ProfileListTile(
              title: localization.age,
              subtitle: widget.user.age,
              onPressed: () => _showAgeDialog(context, localization),
            ),
            ProfileListTile(
              title: localization.gender,
              subtitle: widget.user.gender,
              onPressed: () => _showGenderSelectionDialog(context, localization),
            ),
            SizedBox(height: 15.h),
            Row(children: [
              SizedBox(width: 150.w),
              Expanded(
                child: MyElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: ColorUtility.main,
                        content: Text(
                          localization.changesSaved,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    localization.saveChanges,
                    style: TextUtility.fringeText(color: Colors.white),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  void _showEmailDialog(BuildContext context, AppLocalizations localization) {
    showDialog(
      context: context,
      builder: (context) {
        return MyDialog(
          title: localization.changeEmail,
          icon: Icons.email,
          child: MyTextField(
            label: localization.email,
            hint: widget.user.email ?? '',
            controller: emailController,
          ),
          onConfirm: () {
            context.read<UserCubit>().updateUserData(
                  email: emailController.text,
                );
          },
        );
      },
    );
  }

  void _showNameDialog(BuildContext context, AppLocalizations localization) {
    showDialog(
      context: context,
      builder: (context) {
        return MyDialog(
          title: localization.changeName,
          icon: Icons.person,
          child: MyTextField(
            label: localization.fullName,
            hint: widget.user.name ?? '',
            controller: nameController,
          ),
          onConfirm: () {
            context.read<UserCubit>().updateUserData(
                  name: nameController.text,
                );
          },
        );
      },
    );
  }

  void _showPasswordChangeDialog(BuildContext context, AppLocalizations localization) {
    showDialog(
      context: context,
      builder: (context) {
        return MyDialog(
          title: localization.changePassword,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyTextField(
                label: localization.currentPassword,
                hint: localization.enterCurrentPassword,
                controller: currentPasswordController,
                obscureText: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: MyTextButton(
                  text: localization.forgotPassword,
                  textStyle:
                      TextUtility.fringeText(color: ColorUtility.secondary),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PasswordResetPage()));
                  },
                ),
              ),
              SizedBox(height: 10.h),
              Divider(color: ColorUtility.softGrey),
              MyTextField(
                label: localization.newPassword,
                hint: localization.enterNewPassword,
                controller: newPasswordController,
                obscureText: true,
              ),
              SizedBox(height: 5.h),
              MyTextField(
                label: localization.confirmNewPassword,
                hint: localization.confirmYourNewPassword,
                controller: confirmNewPasswordController,
                obscureText: true,
              ),
            ],
          ),
          onConfirm: () {
            final currentPassword = currentPasswordController.text;
            final newPassword = newPasswordController.text;
            final confirmNewPassword = confirmNewPasswordController.text;

            context.read<AuthCubit>().updatePassword(
                  currentPassword: currentPassword,
                  newPassword: newPassword,
                  confirmNewPassword: confirmNewPassword,
                );
          },
        );
      },
    );
  }

  void _showPhoneNumberDialog(BuildContext context, AppLocalizations localization) {
    showDialog(
      context: context,
      builder: (context) {
        return MyDialog(
            title: localization.addPhoneNumber,
            icon: Icons.phone,
            child: MyTextField(
              controller: phoneController,
              label: localization.phoneNumber,
              hint: widget.user.phoneNumber!,
            ),
            onConfirm: () {
              context.read<UserCubit>().updateUserData(
                    phoneNumber: phoneController.text,
                  );
            });
      },
    );
  }

  void _showAgeDialog(BuildContext context, AppLocalizations localization) {
    showDialog(
      context: context,
      builder: (context) {
        return MyDialog(
            title: localization.addAge,
            child: MyTextField(
              controller: ageController,
              label: localization.age,
              hint: widget.user.age!,
            ),
            onConfirm: () {
              context.read<UserCubit>().updateUserData(
                    age: ageController.text,
                  );
            });
      },
    );
  }

  void _showGenderSelectionDialog(BuildContext context, AppLocalizations localization) {
    showDialog(
      context: context,
      builder: (context) {
        return MyDialog(
            title: localization.selectGender,
            icon: Icons.wc,
            child: DropdownButtonFormField<String>(
              borderRadius: BorderRadius.circular(15.r),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.h),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(
                      width: 2,
                      color: ColorUtility.softGrey,
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(
                      width: 2,
                      color: ColorUtility.softGrey,
                    )),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: ColorUtility.softGrey),
                ),
              ),
              hint: Text(widget.user.gender!, style: TextUtility.hintText()),
              value: genderController.text.isNotEmpty
                  ? genderController.text
                  : null,
              items: ['Male', 'Female'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  genderController.text = value;
                }
              },
            ),
            onConfirm: () {
              context.read<UserCubit>().updateUserData(
                    gender: genderController.text,
                  );
            });
      },
    );
  }
}
