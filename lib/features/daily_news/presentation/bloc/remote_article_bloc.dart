import 'package:news_app/core/resource/data_state.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/remote_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/remote_article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUseCase _getArticleUseCase;

  RemoteArticleBloc(this._getArticleUseCase) : super(const RemoteArticleLoading()) {
    on<GetArticlesEvent>(onGetArticles);
  }

  void onGetArticles(GetArticlesEvent event, Emitter<RemoteArticleState> emits) async {
    final dataState = await _getArticleUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emits(
          RemoteArticleDone(dataState.data!)
      );
    }

    if (dataState is DataFailed) {
      emits(
          RemoteArticleError(dataState.error!)
      );
    }
  }
}
