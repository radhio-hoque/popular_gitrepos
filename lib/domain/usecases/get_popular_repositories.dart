import 'package:dartz/dartz.dart';
import '../entities/repository.dart';
import '../repositories/repository_repository.dart';
import '../../core/error/failures.dart';

class GetPopularRepositories {
  final RepositoryRepository repository;

  GetPopularRepositories(this.repository);

  Future<Either<Failure, List<Repository>>> execute() async {
    return await repository.getRepositories(query: 'Android');
  }
}
