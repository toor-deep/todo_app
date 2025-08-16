import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo/features/auth/domain/entity/auth_entity.dart';
import 'package:todo/features/auth/presentation/provider/auth_provider.dart';
import 'package:todo/features/auth/presentation/sign_up_view.dart';
import 'package:todo/shared/assets/images.dart';
import 'package:todo/shared/extensions/text_field_extensions.dart';

import '../../../design-system/app_colors.dart';
import '../../../design-system/styles.dart';
import '../../../shared/app_constants.dart';
import '../../../shared/app_icons.dart';
import '../../../shared/widgets/elevated_button.dart';
import '../../../shared/widgets/text_field.dart';
import '../../bottom_bar/bottom_screen_view.dart';

class SignInView extends StatefulWidget {
  static const String path = '/sign-in';
  static const String name = 'Sign In';

  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final formKey = GlobalKey<FormState>();
  late AuthenticationProvider authProvider;
  final TextEditingController passController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool isRememberMe = false;
  bool isPassVisible = true;

  @override
  void initState() {
    authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    if(authProvider.currentUser!=null){
      emailController.text = authProvider.currentUser?.email ?? '';
    }
    super.initState();
  }

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
              SizedBox(height: 97.h),
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
              SizedBox(height: 61.h),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacing.h24,
                _login(),
                Spacing.h24,
                TextFieldClass(
                  label: 'Email',
                  controller: emailController,
                  validator: (value) => value?.isValidEmail(),
                ),
                Spacing.h16,
                TextFieldClass(
                  label: 'Password',
                  isPassVisible: isPassVisible,
                  onTogglePassword: () {
                    setState(() {
                      isPassVisible= !isPassVisible;
                    });
                  },
                  controller: passController,
                  isPassword: true,
                  validator: (value) => value?.validatePassword(),
                ),
                Spacing.h16,
                _rememberAndForgot(),
                Spacing.h24,

                Consumer<AuthenticationProvider>(
                  builder: (context, value, child) => AppElevatedButton(
                    text: 'Login',
                    widget: value.isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : null,

                    backgroundColor: kPrimaryColor,
                    onPressed: () {
                      _handleSignIn();
                    },
                  ),
                ),
                Spacing.h24,
                Row(
                  children: [
                    Expanded(
                      child: Divider(thickness: 1, color: Colors.grey.shade300),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Or', style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(
                      child: Divider(thickness: 1, color: Colors.grey.shade300),
                    ),
                  ],
                ),
                Spacing.h24,

                _outlinedButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _login() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Login", style: TextStyles.inter27Bold.copyWith(fontSize: 32)),
          Spacing.h12,
          _buildSignUpText(),
        ],
      ),
    );
  }

  Widget _buildSignUpText() => RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: 'Don’t have an account?  ',
          style: TextStyles.inter12Semi.copyWith(color: kGreyDarkColor),
        ),
        TextSpan(
          text: 'Sign Up',
          style: TextStyles.inter12Regular.copyWith(color: kPrimaryColor),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              context.pushNamed(SignUpView.name);
            },
        ),
      ],
    ),
  );

  Widget _rememberAndForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: isRememberMe,
              onChanged: (value) {
                setState(() {
                  isRememberMe = value ?? false;
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            Text(
              "Remember Me",
              style: TextStyles.inter12Regular.copyWith(color: kGreyDarkColor),
            ),
          ],
        ),
        Text(
          "Forgot Password ?",
          style: TextStyles.inter12Bold.copyWith(color: kPrimaryColor),
        ),
      ],
    );
  }

  Widget _outlinedButton() {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: OutlinedButton(
        onPressed: () {
          authProvider.signInWithGoogle(() {
            context.pushNamed(BottomNavBar.name);
          });
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: kContainerBgColor),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppImages.google, height: 24, width: 24),
            SizedBox(width: 12),
            Text(
              'Continue with Google',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSignIn() async {
    if (!formKey.currentState!.validate()) return;

    authProvider.signIn(
      emailController.text.trim(),
      passController.text.trim(),
      isRememberMe,
      () {
        context.pushNamed(BottomNavBar.name);
      },
    );
  }

}
