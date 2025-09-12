import 'package:flutter/material.dart';
import 'package:news_app/features/daily_news/presentation/bloc/remote_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/remote_article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({ Key ? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text(
          'Daily News',
        style: TextStyle(
          color: Colors.black
        ),
      )
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
      builder: (_, state) {
        if (state is RemoteArticleLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is RemoteArticleError) {
          return Center(child: Icon(Icons.refresh));
        }

        if (state is RemoteArticleDone) {
          return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('$index')
                );
              },
              itemCount: state.articles!.length,
          );
        }

        return const SizedBox();
      }
    );
  }
}
