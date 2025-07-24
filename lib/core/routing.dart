import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/features/auth/presentation/sign_in_view.dart';
import 'package:todo/features/auth/presentation/sign_up_view.dart';
import 'package:todo/features/bottom_bar/bottom_screen_view.dart';
import 'package:todo/features/calendar/presentation/view/calendar_view.dart';
import 'package:todo/features/notifications/presentation/view/notifications_view.dart';
import 'package:todo/features/on_boarding/on_boarding_view.dart';
import 'package:todo/features/profile/presentation/view/profile_view.dart';
import 'package:todo/features/todo_home_page/presentation/view/todo_home_page.dart';

import '../features/splash_screen.dart';


final appNavigationKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
    navigatorKey: appNavigationKey,
    initialLocation: SplashScreen.path,
    routes: [
      GoRoute(
        path: SplashScreen.path,
        name: SplashScreen.name,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: SignUpView.path,
        name: SignUpView.name,
        builder: (context, state) => SignUpView(),
      ),
      GoRoute(
        path: SignInView.path,
        name: SignInView.name,
        builder: (context, state) => SignInView(),
      ),
      GoRoute(
        path: ToDoHomePage.path,
        name: ToDoHomePage.name,
        builder: (context, state) => ToDoHomePage(),
      ),
      GoRoute(
        path: NotificationsView.path,
        name: NotificationsView.name,
        builder: (context, state) => NotificationsView(),
      ),
      GoRoute(
        path: CalendarView.path,
        name: CalendarView.name,
        builder: (context, state) => CalendarView(),
      ),
      GoRoute(
        path: ProfileView.path,
        name: ProfileView.name,
        builder: (context, state) => ProfileView(),
      ),
      GoRoute(
        path: BottomNavBar.path,
        name: BottomNavBar.name,
        builder: (context, state) => BottomNavBar(),
      ),
      GoRoute(
        path: OnboardingScreen.path,
        name: OnboardingScreen.name,
        builder: (context, state) => OnboardingScreen(),
      ),


    ]);
