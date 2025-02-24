import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/injection/injection_container.dart' as di;
import '../../presentation/bloc/repository_bloc.dart';
import '../widgets/repository_item.dart';
import 'repository_detail_page.dart';
import '../../domain/entities/repository.dart';

class RepositoryListPage extends StatelessWidget {
  const RepositoryListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<RepositoryBloc>()..add(FetchRepositories()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Popular GitRepos'),
        ),
        body: BlocBuilder<RepositoryBloc, RepositoryState>(
          builder: (context, state) {
            if (state is RepositoryLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is RepositoryLoaded) {
              final repos = state.repositories;
              return ListView.builder(
                itemCount: repos.length,
                itemBuilder: (context, index) {
                  return RepositoryItem(
                    repository: repos[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RepositoryDetailPage(repository: repos[index]),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state is RepositoryError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
