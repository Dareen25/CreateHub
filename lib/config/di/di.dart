import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../auth_interceptor/auth_interceptor.dart';
import '../dio/dio_module.dart';
import '../services/secure_storage/secure_storage_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() {
  if (getIt.isRegistered<Dio>()) return Future.value();
  getIt.registerLazySingleton(SecureStorageService.new);
  getIt.registerLazySingleton(
    () => AuthInterceptor(getIt<SecureStorageService>()),
  );
  getIt.registerLazySingleton(() => DioModule().dio(getIt<AuthInterceptor>()));
  return Future.value();
}