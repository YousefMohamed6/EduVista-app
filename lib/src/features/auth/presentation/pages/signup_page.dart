import 'package:edu_vista/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_vista/src/features/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:edu_vista/src/features/auth/logic/auth_cubit/auth_state.dart';
import 'package:edu_vista/src/features/auth/presentation/widgets/auth_tpl_widget.dart';
import 'package:edu_vista/src/shared/widgets/text_filed/my_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../home/presentation/pages/root_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignupFailed) {
          String message = _getErrorMessage(state.error, localization);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        } else if (state is SignupSuccess) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RootPage()));
        }
      },
      child: AuthTplWidget(
        onSignUp: () async {
          await context.read<AuthCubit>().signUp(
                name: nameController.text,
                email: emailController.text,
                password: passwordController.text,
                confirmPassword: confirmPasswordController.text,
              );
        },
        body: Column(
          children: [
            MyTextField(
              controller: nameController,
              hint: 'Ahmed Ramy',
              label: localization.fullName,
            ),
            SizedBox(height: 20.h),
            MyTextField(
              controller: emailController,
              hint: 'Ahmedramy52@gmail.com',
              label: localization.email,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20.h),
            MyTextField(
              controller: passwordController,
              hint: '***********',
              label: localization.password,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(height: 20.h),
            MyTextField(
              controller: confirmPasswordController,
              hint: '***********',
              label: localization.confirmPassword,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  String _getErrorMessage(String error, AppLocalizations localization) {
    switch (error) {
      case 'email-already-in-use':
        return localization.emailInUse;
      case 'weak-password':
        return localization.weakPassword;
      default:
        return localization.signupFailed;
    }
  }
}
