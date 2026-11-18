import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../auth_interceptor/auth_interceptor.dart';
import '../dio/dio_module.dart';
import '../services/secure_storage/secure_storage_service.dart';
import '../../features/auth/data/datasources/firebase_auth_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/register_account.dart';
import '../../features/auth/domain/usecases/send_password_reset.dart';
import '../../features/auth/domain/usecases/sign_in.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() {
  if (getIt.isRegistered<Dio>()) return Future.value();
  getIt.registerLazySingleton(SecureStorageService.new);
  getIt.registerLazySingleton(
    () => AuthInterceptor(getIt<SecureStorageService>()),
  );
  getIt.registerLazySingleton(() => DioModule().dio(getIt<AuthInterceptor>()));
  getIt.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSourceImpl(() => FirebaseAuth.instance),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<FirebaseAuthDataSource>()),
  );
  getIt.registerFactory(() => SignIn(getIt<AuthRepository>()));
  getIt.registerFactory(() => RegisterAccount(getIt<AuthRepository>()));
  getIt.registerFactory(() => SendPasswordReset(getIt<AuthRepository>()));
  getIt.registerFactory(
    () => AuthCubit(
      getIt<SignIn>(),
      getIt<RegisterAccount>(),
      getIt<SendPasswordReset>(),
    ),
  );
  return Future.value();
}
