import 'package:flutter/material.dart';
import '../../domain/entities/repository.dart';
import '../../core/utils/date_formatter.dart';

class RepositoryDetailPage extends StatelessWidget {
  final Repository repository;

  const RepositoryDetailPage({Key? key, required this.repository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormatter.format(repository.updatedAt);
    return Scaffold(
      appBar: AppBar(
        title: Text(repository.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Owner: ${repository.ownerName}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Image.network(repository.ownerAvatarUrl, width: 100, height: 100),
            SizedBox(height: 8),
            Text('Description: ${repository.description}'),
            SizedBox(height: 8),
            Text('Last Updated: $formattedDate'),
            SizedBox(height: 8),
            Text('Stars: ${repository.stars}'),
          ],
        ),
      ),
    );
  }
}
