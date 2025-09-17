import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/resource/data_state.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/remote_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/remote_article_state.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUseCase _getArticleUseCase;

  RemoteArticleBloc(this._getArticleUseCase)
    : super(const RemoteArticleLoading()) {
    on<GetArticlesEvent>(onGetArticles);
  }

  void onGetArticles(
    GetArticlesEvent event,
    Emitter<RemoteArticleState> emit,
  ) async {
    emit(const RemoteArticleLoading());

    try {
      final dataState = await _getArticleUseCase();

      if (dataState is DataSuccess) {
        emit(RemoteArticleDone(dataState.data ?? []));
      } else if (dataState is DataFailed) {
        debugPrint('API Error: ${dataState.error?.message}');
        emit(RemoteArticleError(dataState.error!));
      }
    } catch (e) {
      debugPrint('Unexpected error: $e');
      emit(
        RemoteArticleError(
          DioException(
            error: e.toString(),
            requestOptions: RequestOptions(path: ''),
          ),
        ),
      );
    }
  }
}
