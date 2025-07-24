import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/design-system/app_colors.dart';

import '../../../design-system/styles.dart';
import '../../../shared/app_constants.dart';
import '../../../shared/app_icons.dart';
import '../../../shared/widgets/elevated_button.dart';
import '../../../shared/widgets/text_field.dart';

class SignUpView extends StatelessWidget {
  static const String path = '/sign-up';
  static const String name = 'Sign Up';

  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                kPrimaryColor.withValues(alpha: 0.1),
                kPrimaryColor.withValues(alpha: 0.1),
                Colors.white,
              ],
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 48.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppIcon(AppIcons.orangelogo, size: 26),
                  Spacing.w6,
                  Text(
                    'TO-DO',
                    style: TextStyles.inter27Bold.copyWith(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w900,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              _container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _container() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.arrow_back),
              Spacing.h24,
              Text(
                "Sign up",
                style: TextStyles.inter27Bold.copyWith(fontSize: 32),
              ),
              Spacing.h12,
              _buildSignUpText(),
              Spacing.h24,
              TextFieldClass(label: 'Full Name'),
              Spacing.h16,
              TextFieldClass(label: 'Email'),
              Spacing.h16,

              TextFieldClass(label: 'Date of Birth'),
              Spacing.h16,

              TextFieldClass(label: 'Phone Number'),
              Spacing.h16,

              TextFieldClass(label: 'Set Password', isPassword: true),
              Spacing.h24,
              AppElevatedButton(
                text: 'Register',
                backgroundColor: kPrimaryColor,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpText() => RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: 'Already have an account?  ',
          style: TextStyles.inter12Semi.copyWith(color: kGreyDarkColor),
        ),
        TextSpan(
          text: 'Login',
          style: TextStyles.inter12Regular.copyWith(color: kPrimaryColor),
          recognizer: TapGestureRecognizer()..onTap = () {},
        ),
      ],
    ),
  );
}
