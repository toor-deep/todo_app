import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todo/config/injection/hive_injectors.dart' hide getIt;
import 'package:todo/features/notifications/presentation/provider/notification_provider.dart';
import 'package:todo/features/todo_home_page/presentation/provider/task_provider.dart';
import 'package:todo/shared/network_provider/network_provider.dart';

import 'config/injection/dependecy_injection.dart';
import 'core/routing.dart';
import 'design-system/app-theme/app_theme_cubit.dart';
import 'features/auth/presentation/provider/auth_provider.dart';
import 'features/bottom_bar/custom_bottom_navigation/provider/bottom_navigation_provider.dart';
import 'features/notifications/data/model/notifications_local_model/notification_model.dart';
import 'features/notifications/notification_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.init();
  await Hive.initFlutter();

  await setupHiveInjection();
  injectDependencies();


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
        ChangeNotifierProvider(
          create: (_) => AuthenticationProvider(authUseCase: getIt(),localAuthUseCase: getIt()),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskProvider(taskUseCase: getIt(),taskLocalUseCase: getIt()),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationProvider(notificationUseCase: getIt()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => StyledToast(
        locale: const Locale('en', 'US'),
        textStyle: const TextStyle(fontSize: 16.0, color: Colors.white),
        backgroundColor: const Color(0x99000000),
        borderRadius: BorderRadius.circular(5.0),
        textPadding: const EdgeInsets.symmetric(
          horizontal: 17.0,
          vertical: 10.0,
        ),
        toastPositions: StyledToastPosition.top,
        toastAnimation: StyledToastAnimation.slideFromTopFade,
        reverseAnimation: StyledToastAnimation.slideToTopFade,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
        duration: const Duration(seconds: 3),
        animDuration: const Duration(milliseconds: 200),
        dismissOtherOnShow: true,
        fullWidth: false,
        isHideKeyboard: true,
        isIgnoring: true,
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) {
            return MaterialApp.router(
              title: 'ToDo App',
              showPerformanceOverlay: false,
              themeMode: ThemeMode.light,
              debugShowCheckedModeBanner: false,
              debugShowMaterialGrid: false,
              theme: themeProvider.themeData,
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: TextScaler.linear(1.0)),
                child: child ?? const SizedBox(),
              ),
              routerConfig: appRouter,
            );
          },
        ),
      ),
    );
  }
}
