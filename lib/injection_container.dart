import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:news_app/features/daily_news/data/data_source/news_api_service.dart';
import 'package:news_app/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';
import 'package:news_app/features/daily_news/presentation/bloc/remote_article_bloc.dart';

import 'features/daily_news/domain/usecases/get_article.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  sl.registerSingleton<ArticleRepository>(
    ArticleRepositoryImpl(sl())
  );

  sl.registerSingleton<GetArticleUseCase>(
      GetArticleUseCase(sl())
  );

  sl.registerFactory<RemoteArticleBloc>(
      ()=> RemoteArticleBloc(sl())
  );
}
