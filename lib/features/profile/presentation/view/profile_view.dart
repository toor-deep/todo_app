import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/design-system/styles.dart';
import 'package:todo/features/auth/presentation/provider/auth_provider.dart';
import 'package:todo/features/auth/presentation/sign_in_view.dart';
import 'package:todo/shared/assets/images.dart';

import '../../../../design-system/app_colors.dart';
import '../../../../shared/app_constants.dart';

class ProfileView extends StatefulWidget {
  static const String path = '/profile';
  static const String name = 'profile';

  ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late AuthenticationProvider authProvider;

  @override
  void initState() {
    authProvider = context.read<AuthenticationProvider>();
    authProvider.getCurrentUser();
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: 209.h,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [kSecondaryColor, Color(0xFFFF9C42)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -50.r,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60.r,
                        backgroundImage: AssetImage(AppImages.on1),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 2,
                        child: Container(
                          height: 24.r,
                          width: 24.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kPrimaryColor,
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Icon(
                            Icons.edit,
                            size: 14.r,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 70.h),
            Text(
              authProvider.currentUser?.fullName ?? "",
              style: TextStyles.inter20Semi,
            ),
            Spacing.h4,
            Text(
              authProvider.currentUser?.email ?? "",
              style: TextStyles.inter12Regular.copyWith(color: Colors.black54),
            ),
            SizedBox(height: 38.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  _buildActionTile(
                    icon: Icons.edit,
                    label: 'Edit Profile',
                    onTap: () {},
                  ),
                  Spacing.h16,
                  _buildActionTile(
                    icon: Icons.lock_outline,
                    label: 'Change Password',
                    onTap: () {},
                  ),
                  Spacing.h16,
                  _buildActionTile(
                    icon: Icons.logout,
                    label: 'Log out',
                    onTap: () {
                      authProvider.signOut((){
                        context.pushReplacement(SignInView.path);
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        height: 40.h,
        width: 40.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kSecondaryColor.withValues(alpha: 0.2),
        ),
        child: Icon(icon, color: kPrimaryColor, size: 18),
      ),
      title: Text(
        label,
        style: TextStyles.inter16Regular.copyWith(color: kGreyDarkColor),
      ),
      trailing: const Icon(Icons.arrow_forward, size: 16),
      onTap: onTap,
    );
  }
}
