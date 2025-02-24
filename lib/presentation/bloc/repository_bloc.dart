import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/repository.dart';
import '../../domain/usecases/get_popular_repositories.dart';
import '../../core/error/failures.dart';

// Events
abstract class RepositoryEvent {}

class FetchRepositories extends RepositoryEvent {}

// States
abstract class RepositoryState {}

class RepositoryInitial extends RepositoryState {}

class RepositoryLoading extends RepositoryState {}

class RepositoryLoaded extends RepositoryState {
  final List<Repository> repositories;
  RepositoryLoaded(this.repositories);
}

class RepositoryError extends RepositoryState {
  final String message;
  RepositoryError(this.message);
}

// Bloc
class RepositoryBloc extends Bloc<RepositoryEvent, RepositoryState> {
  final GetPopularRepositories getPopularRepositories;

  RepositoryBloc({required this.getPopularRepositories}) : super(RepositoryInitial()) {
    on<FetchRepositories>(_onFetchRepositories);
  }

  Future<void> _onFetchRepositories(FetchRepositories event, Emitter<RepositoryState> emit) async {
    emit(RepositoryLoading());
    final result = await getPopularRepositories.execute();
    result.fold(
          (failure) => emit(RepositoryError(failure.message)),
          (repositories) => emit(RepositoryLoaded(repositories)),
    );
  }
}
