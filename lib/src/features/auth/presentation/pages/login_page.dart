import 'package:edu_vista/l10n/app_localizations.dart';
import 'package:edu_vista/src/shared/utils/text_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_vista/src/features/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:edu_vista/src/features/auth/logic/auth_cubit/auth_state.dart';
import 'package:edu_vista/src/features/auth/presentation/widgets/auth_tpl_widget.dart';
import 'package:edu_vista/src/shared/widgets/text_filed/my_text_field.dart';
import 'package:edu_vista/src/shared/widgets/buttons/my_text_button.dart';
import 'package:edu_vista/src/features/auth/presentation/pages/password_reset_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/utils/color_utility.dart';
import '../../../home/presentation/pages/root_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginFailed) {
          String message = _getErrorMessage(state.error, localization);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        } else if (state is LoginSuccess) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RootPage()));
        }
      },
      child: AuthTplWidget(
        onLogin: () async {
          await context.read<AuthCubit>().login(
                email: emailController.text,
                password: passwordController.text,
              );
        },
        body: Column(
          children: [
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
          ],
        ),
      ),
    );
  }

  String _getErrorMessage(String error, AppLocalizations localization) {
    switch (error) {
      case 'user-not-found':
        return localization.userNotFound;
      case 'wrong-password':
        return localization.incorrectPassword;
      default:
        return localization.loginFailed;
    }
  }
}
