import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../data/datasources/local_datasource.dart';
import '../../data/datasources/remote_datasource.dart';
import '../../data/models/repository_model.dart';
import '../../data/repositories/repository_repository_impl.dart';
import '../../domain/repositories/repository_repository.dart';
import '../../domain/usecases/get_popular_repositories.dart';
import '../../presentation/bloc/repository_bloc.dart';
import '../network/network_info.dart';
final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => RepositoryBloc(getPopularRepositories: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetPopularRepositories(sl()));

  // Repository
  sl.registerLazySingleton<RepositoryRepository>(
        () => RepositoryRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<RemoteDataSource>(
        () => RemoteDataSourceImpl(dio: sl()),
  );

  // Open the Hive box for RepositoryModel.
  final repositoryBox = await Hive.openBox<RepositoryModel>('repositoryBox');
  sl.registerLazySingleton<Box<RepositoryModel>>(() => repositoryBox);

  sl.registerLazySingleton<LocalDataSource>(
        () => LocalDataSourceImpl(repositoryBox: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // External: Register Dio
  sl.registerLazySingleton(() => Dio());
}
