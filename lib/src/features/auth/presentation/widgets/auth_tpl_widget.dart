import 'package:edu_vista/l10n/app_localizations.dart';
import 'package:edu_vista/src/shared/utils/text_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../pages/login_page.dart';
import '../pages/signup_page.dart';
import '../../../../shared/utils/color_utility.dart';
import '../../../../shared/widgets/buttons/my_elevated_button.dart';
import '../../../../shared/widgets/buttons/my_text_button.dart';

class AuthTplWidget extends StatefulWidget {
  final Future<void> Function()? onLogin;
  final Future<void> Function()? onSignUp;
  final Widget body;

  AuthTplWidget({this.onLogin, this.onSignUp, required this.body, super.key}) {
    assert(onLogin != null || onSignUp != null,
        'onLogin or onSignUp should not be null');
  }

  @override
  State<AuthTplWidget> createState() => _AuthTplWidgetState();
}

class _AuthTplWidgetState extends State<AuthTplWidget> {
  bool get isLogin => widget.onLogin != null;
  String getTitle(AppLocalizations localization) =>
      isLogin ? localization.login : localization.signUp;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final title = getTitle(localization);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50.h),
          Text(title, style: TextUtility.titleText()),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 100.h, left: 37.w, right: 37.w),
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [widget.body],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 20.h, right: 35.w, left: 35.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MyElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await (isLogin ? widget.onLogin : widget.onSignUp)?.call();
                setState(() {
                  isLoading = false;
                });
              },
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      title,
                      style: TextUtility.subtitleText(color: Colors.white),
                    ),
            ),
            SizedBox(height: 50.h),
            Divider(
              thickness: 1,
              color: ColorUtility.softGrey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLogin
                      ? localization.dontHaveAccount
                      : localization.alreadyHaveAccount,
                  style: TextUtility.body2Text(),
                ),
                MyTextButton(
                  text: isLogin ? localization.signUpHere : localization.loginHere,
                  textStyle:
                      TextUtility.body2Text(color: ColorUtility.secondary),
                  textButtonStyle:
                      TextButton.styleFrom(padding: EdgeInsets.all(3.h)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => isLogin
                                ? const SignUpPage()
                                : const LoginPage()));
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
