import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/data/models/articles_request_params.dart';
import 'package:newsapp/data/repository.dart';
import 'package:newsapp/usecase/latest_news_usecase.dart';

import 'lates_news_usecase_test.mocks.dart';

@GenerateMocks([DataRespository])
void main() {
  group('LatestCompaniesArticlesUseCase', () {
    late MockDataRespository mockRepo;
    late LatestCompaniesArticlesUseCase useCase;

    setUp(() {
      mockRepo = MockDataRespository();
      useCase = LatestCompaniesArticlesUseCase(mockRepo);
    });

    test('calls repo for each keyword and returns combined results', () async {
      // Sample articles for each keyword
      final keyword1Articles = [Article(title: 'Article 1 for Keyword 1')];
      final keyword2Articles = [Article(title: 'Article 1 for Keyword 2')];

      final keywords = ['keyword1', 'keyword2'];
      const page = 1;

      var param1 = ArticlesParams(
          keyword: 'keyword1',
          from: DateTime.now().subtract(const Duration(days: 1)),
          to: DateTime.now(),
          sortBy: ArticleSortBy.publishedAt,
          page: page);

      var param2 = ArticlesParams(
          keyword: 'keyword2',
          from: DateTime.now().subtract(const Duration(days: 1)),
          to: DateTime.now(),
          sortBy: ArticleSortBy.publishedAt,
          page: page);

      // Mock repo behavior
      when(mockRepo.articles(any)).thenAnswer((iv) {
        var param = iv.positionalArguments[0] as ArticlesParams;
        if (param.keyword == 'keyword1') {
          return Future.value(keyword1Articles);
        } else if (param.keyword == 'keyword2') {
          return Future.value(keyword2Articles);
        } else {
          throw Exception('no match keyword');
        }
      });

      final result = await useCase(keywords, page);

      // Assert expected results
      expect(result.length, keywords.length);
      expect(result[0], keyword1Articles);
      expect(result[1], keyword2Articles);
    });

    test('handles empty results from some keywords', () async {
      // Sample articles
      final keyword1Articles = [Article(title: 'Article 1 for Keyword 1')];

      // Mock repo behavior
      when(mockRepo.articles(any)).thenAnswer((invocation) {
        final params = invocation.positionalArguments[0] as ArticlesParams;
        if (params.keyword == 'keyword1') {
          return Future.value(keyword1Articles);
        } else if (params.keyword == 'keyword2') {
          return Future.value([]); // Empty results
        } else {
          fail('Unexpected keyword in repo call');
        }
      });

      final keywords = ['keyword1', 'keyword2'];
      const page = 1;

      final result = await useCase(keywords, page);

      // Assert expected results (even with empty results)
      expect(result.length, keywords.length);
      expect(result[0], keyword1Articles);
      expect(result[1], []); // Empty list for keyword2
    });

    test('throws original error if all results are empty and no data fetched',
        () async {
      final error = Exception('Test error');

      // Mock repo behavior to throw error
      when(mockRepo.articles(any)).thenThrow(error);
      expect(() => useCase(['keywords'], 1), throwsException);
    });
  });
}
