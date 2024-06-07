import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:newsapp/data/api.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/data/models/articles_request_params.dart';
import 'package:newsapp/data/repository.dart';

import 'repository_test.mocks.dart';

@GenerateMocks([NewsApi])
void main() {
  group('DataRepositoryImp', () {
    late MockNewsApi mockApi;
    late DataRespositoryImp repository;

    setUp(() {
      mockApi = MockNewsApi();
      repository = DataRespositoryImp(mockApi);
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
  });
}
