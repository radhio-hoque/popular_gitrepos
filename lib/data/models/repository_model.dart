import 'package:hive/hive.dart';
import '../../domain/entities/repository.dart';


@HiveType(typeId: 0)
class RepositoryModel extends Repository {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String ownerName;

  @HiveField(4)
  final String ownerAvatarUrl;

  @HiveField(5)
  final DateTime updatedAt;

  @HiveField(6)
  final int stars;

  RepositoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.ownerName,
    required this.ownerAvatarUrl,
    required this.updatedAt,
    required this.stars,
  }) : super(
    id: id,
    name: name,
    description: description,
    ownerName: ownerName,
    ownerAvatarUrl: ownerAvatarUrl,
    updatedAt: updatedAt,
    stars: stars,
  );

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      id: json['id'].toString(),
      name: json['name'],
      description: json['description'] ?? '',
      ownerName: json['owner']['login'],
      ownerAvatarUrl: json['owner']['avatar_url'],
      updatedAt: DateTime.parse(json['updated_at']),
      stars: json['stargazers_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'ownerName': ownerName,
      'ownerAvatarUrl': ownerAvatarUrl,
      'updatedAt': updatedAt.toIso8601String(),
      'stars': stars,
    };
  }
}
