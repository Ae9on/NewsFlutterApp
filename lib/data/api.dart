import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/data/models/articles_request_params.dart';
import 'package:newsapp/exceptions.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Provider for creating a Dio instance with configuration
final dioProvider = Provider((ref) {
  Dio dio = Dio(BaseOptions(
    baseUrl: "https://newsapi.org/v2/",
  ));
  dio.interceptors.clear();

  // Add a PrettyDioLogger to log detailed network requests and responses
  dio.interceptors.add(PrettyDioLogger());

  dio.interceptors.add(InterceptorsWrapper(onRequest:
      (RequestOptions options, RequestInterceptorHandler handler) async {
    // Set the API key in the query parameters (replace with your actual key)
    options.queryParameters['apiKey'] = '4717975602f54f7c963d7137374aeefa';
    return handler.next(options);
  }));
  return dio;
});

// Provider for creating a NewsApi instance that interacts with the API
final apiProvider = Provider((ref) => NewsApi(ref.watch(dioProvider)));

class NewsApi {
  final Dio _dio;
  NewsApi(this._dio);

  // Method to fetch a list of articles based on provided parameters
  Future<List<Article>> articles(ArticlesParams params) => _dio
          .get('everything', queryParameters: params.toJson())
          .then((value) => List.from(value.data['articles'])
              .map((e) => Article.fromJson(e))
              .toList())
          .catchError((e) {
        if (e is DioException &&
            e.response?.data != null &&
            e.response?.data is Map) {
          // Check if the error response contains an error message
          throw FailureException(
              massage: e.response?.data['message'] ?? 'Something went wrong!');
        } else {
          throw FailureException(massage: 'Something went wrong!');
        }
      });
}
