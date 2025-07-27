import 'package:get_it/get_it.dart';
import 'package:todo/features/auth/data/data_source/auth_data_source.dart';
import 'package:todo/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:todo/features/auth/domain/repository/auth_repository.dart';
import 'package:todo/features/auth/domain/usecase/auth.usecase.dart';
import 'package:todo/features/notifications/data/data_source/notifications_local_data_source.dart';
import 'package:todo/features/todo_home_page/data/data_source/task_data_source.dart';
import 'package:todo/features/todo_home_page/data/repo_impl/task_repository_impl.dart';
import 'package:todo/features/todo_home_page/domain/repository/task_repository.dart';
import 'package:todo/features/todo_home_page/domain/usecase/task.usecase.dart';
import 'package:todo/features/todo_home_page/presentation/provider/task_provider.dart';
import 'package:todo/shared/network_provider/network_provider.dart';

import '../../features/auth/presentation/provider/auth_provider.dart';

final getIt = GetIt.instance;

void injectDependencies() {
  //datasources
  getIt.registerSingleton<AuthDataSource>(AuthDataSourceImpl());
  getIt.registerSingleton<TaskDataSource>(TaskDataSourceImpl());

  //repositories
  getIt.registerSingleton<AuthRepository>(AuthRepoImpl(remoteDataSource: getIt()));
  getIt.registerSingleton<TaskRepository>(TaskRepoImpl(taskDataSource: getIt()));

  //usecases
  getIt.registerSingleton(AuthUseCase(repository: getIt()));
  getIt.registerSingleton(TaskUseCase(taskRepository: getIt()));

  //providers
  getIt.registerSingleton(AuthenticationProvider(authUseCase: getIt(),localAuthUseCase: getIt()));
  getIt.registerSingleton(TaskProvider(taskUseCase: getIt(),taskLocalUseCase: getIt()));
  getIt.registerSingleton(ConnectivityProvider());
}
