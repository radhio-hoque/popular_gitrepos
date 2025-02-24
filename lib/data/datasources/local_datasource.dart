import 'package:hive/hive.dart';
import '../../core/error/exceptions.dart';
import '../models/repository_model.dart';

abstract class LocalDataSource {
  Future<void> cacheRepositories(List<RepositoryModel> repositories);
  Future<List<RepositoryModel>> getCachedRepositories();
}

class LocalDataSourceImpl implements LocalDataSource {
  final Box<RepositoryModel> repositoryBox;

  LocalDataSourceImpl({required this.repositoryBox});

  @override
  Future<void> cacheRepositories(List<RepositoryModel> repositories) async {
    // Clear previous cached data.
    await repositoryBox.clear();
    // Use repository id as key.
    for (var repo in repositories) {
      await repositoryBox.put(repo.id, repo);
    }
  }

  @override
  Future<List<RepositoryModel>> getCachedRepositories() async {
    final repos = repositoryBox.values.toList();
    if (repos.isNotEmpty) {
      return repos;
    } else {
      throw CacheException();
    }
  }
}
