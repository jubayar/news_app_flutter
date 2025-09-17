import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/resource/data_state.dart';
import 'package:news_app/features/daily_news/data/data_source/news_api_service.dart';

import '../../domain/repository/article_repository.dart';
import '../models/article.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;

  ArticleRepositoryImpl(this._newsApiService);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {

      final httpResponse = await _newsApiService.getNewsArticles(
        apiKey: newsAPIKey,
        country: countryQuery,
        category: categoryQuery,
      );

      debugPrint('Response data: ${httpResponse.data}');

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        debugPrint('API Error: ${httpResponse.response.statusMessage}');
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (exception) {
      debugPrint('DioException occurred: ${exception.message}');
      return DataFailed(exception);
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return DataFailed(
        DioException(
          error: e.toString(),
          requestOptions: RequestOptions(path: '/top-headlines'),
        ),
      );
    }
  }
}
