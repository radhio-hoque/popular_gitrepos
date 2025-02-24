class Repository {
  final String id;
  final String name;
  final String description;
  final String ownerName;
  final String ownerAvatarUrl;
  final DateTime updatedAt;
  final int stars;

  Repository({
    required this.id,
    required this.name,
    required this.description,
    required this.ownerName,
    required this.ownerAvatarUrl,
    required this.updatedAt,
    required this.stars,
  });
}
