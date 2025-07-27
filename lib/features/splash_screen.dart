import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/design-system/app_colors.dart';
import 'package:todo/features/auth/presentation/provider/auth_provider.dart';
import 'package:todo/features/on_boarding/on_boarding_view.dart';
import 'package:todo/shared/app_icons.dart';
import '../design-system/styles.dart';
import '../shared/app_constants.dart';
import 'bottom_bar/bottom_screen_view.dart';

class SplashScreen extends StatefulWidget {
  static const String path = '/splash';
  static const String name = 'splashScreen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    _checkLoginState();
  }

  Future<void> _checkLoginState() async {
    final authProvider = context.read<AuthenticationProvider>();

    bool isLoggedIn = await authProvider.isUserLoggedIn();


    await Future.delayed(const Duration(seconds: 2));

    if (isLoggedIn) {
      context.goNamed(BottomNavBar.name);
    } else {
      context.goNamed(OnboardingScreen.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kPrimaryColor.withValues(alpha: 0.4),
              kPrimaryColor,
              kPrimaryColor,
              kPrimaryColor.withValues(alpha: 0.4),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppIcon(AppIcons.logo, size: 89),
              Spacing.w24,
              Text(
                'TO-DO',
                style: TextStyles.inter27Bold.copyWith(
                  fontSize: 67,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
