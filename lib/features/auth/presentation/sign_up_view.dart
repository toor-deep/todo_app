import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:todo/design-system/app_colors.dart';
import 'package:todo/features/auth/presentation/provider/auth_provider.dart';
import 'package:todo/features/auth/presentation/sign_in_view.dart';
import 'package:todo/features/bottom_bar/bottom_screen_view.dart';
import 'package:todo/shared/extensions/text_field_extensions.dart';

import '../../../design-system/styles.dart';
import '../../../shared/app_constants.dart';
import '../../../shared/app_icons.dart';
import '../../../shared/widgets/elevated_button.dart';
import '../../../shared/widgets/text_field.dart';

class SignUpView extends StatefulWidget {
  static const String path = '/sign-up';
  static const String name = 'Sign Up';

  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController dobController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isPassVisible = true;

  late AuthenticationProvider authProvider;
  @override
  void initState() {
    authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        dobController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
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
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [InkWell(
                onTap: (){
                  context.pushNamed(SignInView.name);

                },
                  child: Icon(Icons.arrow_back)),
                Spacing.h24,
                Text(
                  "Sign up",
                  style: TextStyles.inter27Bold.copyWith(fontSize: 32),
                ),
                Spacing.h12,
                _buildSignUpText(),
                Spacing.h24,
                TextFieldClass(
                  label: 'Full Name',
                  controller: nameController,
                  validator: (value) => value?.isEmptyField(
                    messageTitle: 'Full Name is required',
                  ),
                ),
                Spacing.h16,
                TextFieldClass(
                  label: 'Email',
                  controller: emailController,
                  validator: (value) => value?.isValidEmail(),
                ),
                Spacing.h16,
                _dateOfBirth(),
                Spacing.h16,
                _phoneNumberField(),
                Spacing.h16,

                TextFieldClass(
                  label: 'Set Password',
                  isPassword: true,
                  isPassVisible: isPassVisible,
                  onTogglePassword: () {
                    setState(() {
                      isPassVisible= !isPassVisible;
                    });
                  },
                  validator: (value) => value?.validatePassword(),
                  controller: passController,
                ),
                Spacing.h24,
                Consumer<AuthenticationProvider>(
                  builder: (context, value, child) {
                    return AppElevatedButton(
                      text: 'Register',
                      widget:  value.isLoading? CircularProgressIndicator(color: Colors.white,):null,
                      backgroundColor: kPrimaryColor,
                      onPressed: () {
                        _handleSignUp();                  },
                    );
                  },

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dateOfBirth() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Date of Birth",
          style: TextStyles.inter12Semi.copyWith(color: kGreyDarkColor),
        ),

        GestureDetector(
          onTap: () => _selectDate(context),
          child: AbsorbPointer(
            child: TextFormField(
              style: TextStyles.inter12Regular.copyWith(
                fontWeight: FontWeight.w500,
              ),

              decoration: InputDecoration(
                suffixIcon: Icon(Icons.calendar_month),
              ),
              controller: dobController,
            ),
          ),
        ),
      ],
    );
  }

  Widget _phoneNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Phone Number",
          style: TextStyles.inter12Semi.copyWith(color: kGreyDarkColor),
        ),

        IntlPhoneField(
          controller: phoneController,
          flagsButtonPadding: const EdgeInsets.all(8),
          disableLengthCheck: true,
          initialCountryCode: "IN",

          dropdownIconPosition: IconPosition.trailing,
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kContainerBgColor),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: kContainerBgColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kGreyDarkColor),
            ),
          ),
          showCursor: true,
          showDropdownIcon: true,
          onChanged: (phone) {
            print(phone.completeNumber);
          },
        ),
      ],
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
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              context.pushNamed(SignInView.name);
            },
        ),
      ],
    ),
  );

  Future<void> _handleSignUp() async {
    if (!formKey.currentState!.validate()) return;

    authProvider.signUp(
      emailController.text.trim(),
      passController.text.trim(),
      dobController.text.trim(),
      nameController.text.trim(),
      phoneController.text.trim(),
      () {
        context.goNamed(BottomNavBar.name);
      },
    );
  }
}
