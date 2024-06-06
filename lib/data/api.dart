import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final dioProvider = Provider((ref) {
  Dio dio = Dio(BaseOptions(
    baseUrl: "https://newsapi.org/v2/",
  ));
  dio.interceptors.clear();
  dio.interceptors.add(PrettyDioLogger());
  return dio;
});

final apiProvider = Provider((ref) => NewsApi(ref.watch(dioProvider)));

class NewsApi {
  final Dio _dio;
  NewsApi(this._dio);

  Future<List<Article>> articles(
          String keywords, String from, String to, String sortBy) =>
      _dio.get('everything', queryParameters: {
        'q': keywords,
        'sortBy': sortBy,
        'from': from,
        'to': to,
        'language': 'en',
        'apiKey': 'e5b33812714c45c08398629e63de1076'
      }).then((value) => List.from(value.data['articles'])
          .map((e) => Article.fromJson(e))
          .toList());
}
