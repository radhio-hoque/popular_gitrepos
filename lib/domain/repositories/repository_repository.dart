import 'package:dartz/dartz.dart';
import '../entities/repository.dart';
import '../../core/error/failures.dart';

abstract class RepositoryRepository {
  Future<Either<Failure, List<Repository>>> getRepositories({required String query});
}