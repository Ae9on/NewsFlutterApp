import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:newsapp/data/local/local_repository.dart';
import 'package:newsapp/data/remote/api.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/data/models/articles_request_params.dart';
import 'package:newsapp/data/repository.dart';

import 'repository_test.mocks.dart';

@GenerateMocks([NewsApi, LocalDataRepository])
void main() {
  group('DataRepositoryImp', () {
    late MockNewsApi mockApi;
    late MockLocalDataRepository mockLocal;

    late DataRespositoryImp repository;

    setUp(() {
      mockApi = MockNewsApi();
      mockLocal = MockLocalDataRepository();
      repository = DataRespositoryImp(mockApi, mockLocal);
    });

    test(
        'articles returns filtered list without articles with "[Removed]" title',
        () async {
      // Mock API response with articles, including one with "[Removed]" title
      final articles = [
        Article(title: 'Article 1'),
        Article(title: '[Removed]'),
        Article(title: 'Article 3'),
      ];
      when(mockApi.articles(any)).thenAnswer((_) => Future.value(articles));

      // Expected result after filtering
      final expectedArticles =
          articles.where((element) => element.title != '[Removed]').toList();

      // Call the method
      final actualArticles =
          await repository.articles(ArticlesParams(keyword: 'test'));

      // Assert that the returned list is filtered correctly
      expect(actualArticles, equals(expectedArticles));
    });

    test('articles throws an error if API call fails', () async {
      // Mock API failure
      when(mockApi.articles(any)).thenThrow(Exception('API error'));

      // Expect an exception to be thrown
      expect(() => repository.articles(ArticlesParams(keyword: 'test')),
          throwsException);
    });

    test('fetches articles from api and returns combined list', () async {
      final keyword1Articles = [Article(title: 'article1')];
      final keyword2Articles = [Article(title: 'article2')];
      when(mockApi.articles(any)).thenAnswer((iv) {
        var params = iv.positionalArguments[0] as ArticlesParams;
        if (params.keyword == 'keyword1') {
          return Future.value(keyword1Articles);
        } else {
          return Future.value(keyword2Articles);
        }
      });

      final result =
          await repository.latestArticles(['keyword1', 'keyword2'], 1);

      expect(result, equals(keyword1Articles + keyword2Articles));
      verify(mockApi.articles(any));
      verify(mockLocal.clearCache());
    });

    test(
        'uses cached data if api throws error and there is cached data on first page',
        () async {
      final cachedArticles = [Article(title: 'cached article')];
      when(mockApi.articles(any)).thenAnswer((_) => Future.error(Exception()));
      when(mockLocal.fetchArticles())
          .thenAnswer((_) => Future.value(cachedArticles));

      final result = await repository.latestArticles(['keyword1'], 1);

      expect(result, equals(cachedArticles));
      verify(mockApi.articles(any));
      verify(mockLocal.fetchArticles());
      verifyNoMoreInteractions(mockLocal);
    });

    test('throw error if api throws error and there is no cached data',
        () async {
      final cachedArticles = <Article>[];
      when(mockApi.articles(any)).thenAnswer((_) => Future.error(Exception()));
      when(mockLocal.fetchArticles())
          .thenAnswer((_) => Future.value(cachedArticles));

      expect(() => repository.articles(ArticlesParams(keyword: 'test')),
          throwsException);
    });

    test(
        'throw error if api throws error on second page and after even there is chached data',
        () async {
      final cachedArticles = [Article(title: 'cached article')];
      when(mockApi.articles(any)).thenAnswer((_) => Future.error(Exception()));
      when(mockLocal.fetchArticles())
          .thenAnswer((_) => Future.value(cachedArticles));

      expect(
          () => repository.articles(ArticlesParams(keyword: 'test', page: 2)),
          throwsException);
    });
  });
}
