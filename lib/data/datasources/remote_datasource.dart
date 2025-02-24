import 'package:dio/dio.dart';
import '../models/repository_model.dart';
import '../../core/error/exceptions.dart';

abstract class RemoteDataSource {
  Future<List<RepositoryModel>> fetchRepositories(String query);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio dio;
  RemoteDataSourceImpl({required this.dio});

  @override
  Future<List<RepositoryModel>> fetchRepositories(String query) async {
    final response = await dio.get(
      'https://api.github.com/search/repositories',
      queryParameters: {
        'q': query,
        'sort': 'stars',
        'order': 'desc',
      },
    );

    if (response.statusCode == 200) {
      final body = response.data;
      final List items = body['items'];
      return items.map((item) => RepositoryModel.fromJson(item)).toList();
    } else {
      throw ServerException();
    }
  }
}
