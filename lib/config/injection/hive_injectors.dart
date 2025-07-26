import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:todo/features/notifications/data/repo_impl/notification_repo_impl.dart';
import 'package:todo/features/notifications/domain/respository/notifcation_repo.dart';
import 'package:todo/features/notifications/domain/usecase/notification.usecase.dart';
import 'package:todo/features/notifications/presentation/provider/notification_provider.dart';

import '../../features/notifications/data/data_source/notifications_local_data_source.dart';
import '../../features/notifications/data/model/notifications_local_model/notification_model.dart';

final getIt = GetIt.instance;

Future<void> setupHiveInjection() async {
  Hive.registerAdapter(NotificationModelAdapter());
  final notificationBox = await Hive.openBox<NotificationModel>(
    'notificationsBox',
  );

  getIt.registerLazySingleton<LocalNotificationDataSource>(
    () => LocalNotificationDataSource(notificationBox),
  );

  getIt.registerSingleton<NotificationRepository>(
    NotificationRepositoryImpl(getIt()),
  );

  getIt.registerSingleton(NotificationUseCase(getIt()));
  getIt.registerSingleton(NotificationProvider(notificationUseCase: getIt()));
}
