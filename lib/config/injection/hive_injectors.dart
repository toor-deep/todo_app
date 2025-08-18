import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:todo/features/auth/data/data_source/auth_local_datasource.dart';
import 'package:todo/features/auth/data/models/hive/user_local_model.dart';
import 'package:todo/features/auth/data/repo_impl/auth_local_repo_impl.dart';
import 'package:todo/features/auth/domain/repository/auth_local_repository.dart';
import 'package:todo/features/auth/domain/usecase/auth_local.usecase.dart';
import 'package:todo/features/notifications/data/repo_impl/notification_repo_impl.dart';
import 'package:todo/features/notifications/domain/respository/notifcation_repo.dart';
import 'package:todo/features/notifications/domain/usecase/notification.usecase.dart';
import 'package:todo/features/notifications/presentation/provider/notification_provider.dart';
import 'package:todo/features/todo_home_page/data/data_source/task_local_data_source.dart';
import 'package:todo/features/todo_home_page/data/models/hive_model/task_local_model.dart';
import 'package:todo/features/todo_home_page/data/repo_impl/task_local_repo_impl.dart';
import 'package:todo/features/todo_home_page/domain/repository/task_local_repository.dart';
import 'package:todo/features/todo_home_page/domain/usecase/task_local.usecase.dart';

import '../../features/notifications/data/data_source/notifications_local_data_source.dart';
import '../../features/notifications/data/model/notifications_local_model/notification_model.dart';

final getIt = GetIt.instance;

Future<void> setupHiveInjection() async {
  Hive.registerAdapter(NotificationModelAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TaskLocalModelAdapter());
  final notificationBox = await Hive.openBox<NotificationModel>(
    'notificationsBox',
  );
  final authBox=await Hive.openBox('authBox');
  final tasksBox=await Hive.openBox('taskBox');

//datasource
  getIt.registerLazySingleton<LocalNotificationDataSource>(
    () => LocalNotificationDataSource(notificationBox),
  );
  getIt.registerLazySingleton<LocalAuthDataSource>(
        () => LocalAuthDataSource(authBox: authBox),
  );
  getIt.registerLazySingleton<TaskLocalDataSource>(
        () => TaskLocalDataSource(taskBox: tasksBox),
  );



  //repository
  getIt.registerSingleton<NotificationRepository>(
    NotificationRepositoryImpl(getIt()),
  );
  getIt.registerSingleton<AuthLocalRepository>(
    AuthLocalRepositoryImpl(getIt()),
  );
  getIt.registerSingleton<TaskLocalRepository>(
    TaskLocalRepositoryImpl(getIt()),
  );


  //useCase
  getIt.registerSingleton(NotificationUseCase(getIt()));
  getIt.registerSingleton(LocalAuthUseCase(getIt()));
  getIt.registerSingleton(TaskLocalUseCase(getIt()));

  //provider
  getIt.registerSingleton(NotificationProvider(notificationUseCase: getIt()));
}
