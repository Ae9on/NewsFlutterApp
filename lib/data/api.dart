import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/data/models/articles_request_params.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final dioProvider = Provider((ref) {
  Dio dio = Dio(BaseOptions(
    baseUrl: "https://newsapi.org/v2/",
  ));
  dio.interceptors.clear();
  dio.interceptors.add(PrettyDioLogger());
  dio.interceptors.add(InterceptorsWrapper(onRequest:
      (RequestOptions options, RequestInterceptorHandler handler) async {
    options.queryParameters['apiKey'] = 'f1a159e96d5e4117b87411b14bc2007f';
    return handler.next(options);
  }));
  return dio;
});

final apiProvider = Provider((ref) => NewsApi(ref.watch(dioProvider)));

class NewsApi {
  final Dio _dio;
  NewsApi(this._dio);

  Future<List<Article>> articles(ArticlesParams params) => _dio
      .get('everything', queryParameters: params.toJson())
      .then((value) => List.from(value.data['articles'])
          .map((e) => Article.fromJson(e))
          .toList());
}
