import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'core/injection/injection_container.dart' as di;
import 'presentation/pages/repository_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // Register Hive adapter for RepositoryModel.
  Hive.registerAdapter(RepositoryModelAdapter());

  // Initialize dependency injection (which now opens the Hive box)
  await di.init();

  runApp(PopularGitReposApp());
}

class PopularGitReposApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Popular GitRepos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RepositoryListPage(),
    );
  }
}
