part of 'init_dependencies.dart';

final GetIt sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // HTTP Client
  sl.registerLazySingleton<http.Client>(() => http.Client());

  // Data Sources
  sl.registerLazySingleton<CardRemoteDataSource>(
      () => CardRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CardLocalDataSource>(
      () => CardLocalDataSourceImpl(sharedPreferences: sl()));

  // Cubit
  sl.registerFactory<CardCubit>(
      () => CardCubit(remoteDataSource: sl(), localDataSource: sl()));
}
