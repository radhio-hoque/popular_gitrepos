import 'package:flutter/material.dart';
import '../../domain/entities/repository.dart';

class RepositoryItem extends StatelessWidget {
  final Repository repository;
  final VoidCallback onTap;

  const RepositoryItem({Key? key, required this.repository, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(repository.name),
      subtitle: Text('Stars: ${repository.stars}'),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
