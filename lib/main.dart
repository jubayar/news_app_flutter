import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/app_themes.dart';
import 'package:news_app/features/daily_news/presentation/bloc/remote_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/remote_article_event.dart';
import 'package:news_app/injection_container.dart';

import 'features/daily_news/presentation/pages/daily_news.dart';

Future<void> main() async {
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticleBloc>(
        create: (context) => sl()..add(GetArticlesEvent()),
        child: MaterialApp(
          theme: theme(),
          home: const DailyNews(),
        )
    );
  }
}
