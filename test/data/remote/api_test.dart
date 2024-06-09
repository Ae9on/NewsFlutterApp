import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:newsapp/data/remote/api.dart';
import 'package:newsapp/data/models/articles_request_params.dart';
import 'package:newsapp/exceptions.dart';

import 'api_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  group('NewsApi', () {
    late MockDio mockDio;
    late NewsApi newsApi;

    setUp(() {
      mockDio = MockDio();
      newsApi = NewsApi(mockDio);
    });

    test('fetches articles successfully', () async {
      // Mock successful response from Dio
      final articlesJson = [
        {'title': 'Article 1', 'content': 'Content of article 1'},
        {'title': 'Article 2', 'content': 'Content of article 2'},
      ];
      when(mockDio.get('everything',
              queryParameters: anyNamed('queryParameters')))
          .thenAnswer((realInvocation) => Future.value(Response(
              data: {'articles': articlesJson},
              requestOptions: RequestOptions())));

      final params = ArticlesParams(keyword: 'test');
      final articles = await newsApi.articles(params);

      expect(articles.length, 2);
      expect(articles[0].title, 'Article 1');
      expect(articles[0].content, 'Content of article 1');
    });

    test('throws FailureException for DioException', () async {
      when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) => Future.error(
              DioException(error: '', requestOptions: RequestOptions())));

      final params = ArticlesParams(keyword: 'test');

      try {
        var r = await newsApi.articles(params);
      } catch (e) {
        expect(e, isInstanceOf<FailureException>());
      }
    });

    test('throws FailureException for DioException with error message',
        () async {
      const errorMessage = 'API rate limit exceeded';
      when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) => Future.error(DioException(
              response: Response(
                  data: {'message': errorMessage},
                  requestOptions: RequestOptions()),
              requestOptions: RequestOptions())));

      final params = ArticlesParams(keyword: 'test');

      try {
        await newsApi.articles(params);
      } catch (e) {
        expect(e, isInstanceOf<FailureException>());
        expect((e as FailureException).massage, equals(errorMessage));
      }
    });
  });
}
