import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/design-system/styles.dart';
import 'package:todo/features/auth/domain/entity/auth_entity.dart';
import 'package:todo/features/auth/presentation/provider/auth_provider.dart';
import 'package:todo/features/auth/presentation/sign_in_view.dart';
import 'package:todo/shared/assets/images.dart';

import '../../../../core/utils/file_browser.dart';
import '../../../../design-system/app_colors.dart';
import '../../../../shared/app_constants.dart';
import '../../../../shared/widgets/image_view.dart';

class ProfileView extends StatefulWidget {
  static const String path = '/profile';
  static const String name = 'profile';

  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late AuthenticationProvider authProvider;

  @override
  void initState() {
    authProvider = context.read<AuthenticationProvider>();
    super.initState();
  }

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
                      InkWell(
                        onTap: () {
                          _showPicker(context: context);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child:authProvider.profilePicture != null
                              ? CustomFileImage(
                                  file: authProvider.profilePicture ?? File(""),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  assetImage: AppImages.on1,
                                )
                              : HostedImage(
                                  authProvider
                                          .currentUser
                                          ?.profilePicture
                                          .originalUrl ??
                                      "",
                                  fit: BoxFit.cover,
                                  assetImage: AppImages.on1,
                                  size: const Size(100, 100),
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 2,
                        child: GestureDetector(
                          onTap: () {
                            _showPicker(context: context);
                          },
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
                      warningDialog(context);
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

  Future warningDialog(BuildContext context) {
    return showDialog(
      builder: (context) => AlertDialog(
        title: Text(
          'Are you sure you want to log out?',
          style: TextStyles.inter16Semi,
        ),
        content: Text(
          'You will need to sign in again to access your account.',
          style: TextStyles.inter14Regular.copyWith(color: kLightGreyColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel', style: TextStyles.inter16Semi),
          ),
          TextButton(
            onPressed: () {
              authProvider.signOut(() {
                context.pushReplacement(SignInView.path);
              });
            },
            child: Text(
              'Log out',
              style: TextStyles.inter16Semi.copyWith(color: kPrimaryColor),
            ),
          ),
        ],
      ),
      context: context,
    );
  }

  void _showPicker({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                onTap: () {
                  _clearImage();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel_outlined),
                title: const Text('Cancel'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _clearImage() {
    authProvider.profilePicture = null;
  }

  Future getImage(ImageSource img) async {
    final pickedFile = await FileBrowser.getImageFromSource(img);

    setState(() {
      if (pickedFile != null) {
        authProvider.profilePicture = File(pickedFile.path);
        setState(() {});
        authProvider.updateProfile(
          AuthUser(
            uid: authProvider.currentUser?.uid ?? '',
            email: authProvider.currentUser?.email ?? '',
            fullName: authProvider.currentUser?.fullName ?? '',
            dateOfBirth: '',
          ),
          () {},
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Nothing is selected')));
      }
    });
  }
}
