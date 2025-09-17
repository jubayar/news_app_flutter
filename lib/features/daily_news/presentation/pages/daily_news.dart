import 'package:flutter/material.dart';
import 'package:news_app/features/daily_news/presentation/bloc/remote_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/remote_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/remote_article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/article_tile.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody(context));
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Daily News', style: TextStyle(color: Colors.black)),
    );
  }

  _buildBody(BuildContext context) {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
      builder: (_, state) {
        if (state is RemoteArticleLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is RemoteArticleError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 60, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Failed to load articles',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  state.exception?.message ?? 'Something went wrong',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<RemoteArticleBloc>().add(
                      const GetArticlesEvent(),
                    );
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state is RemoteArticleDone) {
          if (state.articles!.isEmpty) {
            return const Center(child: Text('No articles available'));
          }

          return ListView.builder(
            itemBuilder: (context, index) {
              return ArticleWidget(
                null,
                state.articles![index],
              );
            },
            itemCount: state.articles!.length,
          );
        }

        return const SizedBox();
      },
    );
  }
}
