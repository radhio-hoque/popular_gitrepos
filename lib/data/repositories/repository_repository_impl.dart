import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/repository.dart';
import '../../domain/repositories/repository_repository.dart';
import '../datasources/local_datasource.dart';
import '../datasources/remote_datasource.dart';
import '../../core/network/network_info.dart';

class RepositoryRepositoryImpl implements RepositoryRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RepositoryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Repository>>> getRepositories({required String query}) async {
    if (await networkInfo.isConnected) {
      try {
        final repos = await remoteDataSource.fetchRepositories(query);
        await localDataSource.cacheRepositories(repos);
        return Right(repos);
      } on ServerException {
        return Left(ServerFailure('Failed to fetch data from server'));
      }
    } else {
      try {
        final cachedRepos = await localDataSource.getCachedRepositories();
        return Right(cachedRepos);
      } on CacheException {
        return Left(CacheFailure('No cached data available'));
      }
    }
  }
}
