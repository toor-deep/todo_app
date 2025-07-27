import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo/design-system/app_colors.dart';
import 'package:todo/design-system/styles.dart';
import 'package:todo/features/auth/presentation/sign_in_view.dart';

import '../../shared/app_constants.dart';
import '../../shared/assets/images.dart';
import '../../shared/widgets/circular_button.dart';
import '../auth/presentation/sign_up_view.dart';
import '../bottom_bar/bottom_screen_view.dart';

class OnboardingScreen extends StatefulWidget {
  static const String path = '/onboarding';
  static const String name = 'onboarding';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<OnBoardingData> onboardingData = [
    OnBoardingData(
      image: AppImages.on1,
      title: '📌Stay Organized & Focused',
      description:
          "Easily create, manage, and prioritize your tasks to stay on top of your day.",
    ),
    OnBoardingData(
      image: AppImages.on2,
      title: '⏳ Never Miss a Deadline',
      description:
          "Set reminders and due dates to keep track of important tasks effortlessly.",
    ),
    OnBoardingData(
      image: AppImages.on3,
      title: '✅ Boost Productivity',
      description:
          "Break tasks into steps, track progress, and get more done with ease.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (index) => setState(() => currentIndex = index),
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        onboardingData[index].image,
                        height: size.height * 0.35,
                      ),
                      const SizedBox(height: 32),
                      Text(
                        onboardingData[index].title,
                        style: TextStyles.inter24Bold,

                        textAlign: TextAlign.center,
                      ),
                      Spacing.h8,
                      Text(
                        onboardingData[index].description,
                        style: TextStyles.inter16Regular.copyWith(
                          color: kGreyDarkColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
              ),
            ),

            SmoothPageIndicator(
              controller: _controller,
              count: onboardingData.length,
              effect: const ExpandingDotsEffect(
                activeDotColor: kPrimaryColor,
                dotColor: kLightGreyColor,
                dotHeight: 9,
                dotWidth: 9,
              ),
            ),

            Spacing.h28,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    context.goNamed(SignInView.name);
                  },
                  child:  Text("Skip",style: TextStyles.inter16Regular.copyWith(color: Colors.black),),
                ),

                InkWell(
                  onTap: (){
                    if (currentIndex < onboardingData.length - 1) {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      context.goNamed(SignInView.name);
                    }
                  },
                  child: CircularIconButton(
                    icon: Icons.arrow_forward_ios,
                    backgroundColor: kPrimaryColor,
                    iconColor: Colors.white,
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardingData {
  final String image;
  final String title;
  final String description;

  OnBoardingData({
    required this.image,
    required this.description,
    required this.title,
  });
}
