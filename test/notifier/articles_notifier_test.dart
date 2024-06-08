import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/exceptions.dart';
import 'package:newsapp/notifier/viewmodels/article_viewmodel.dart';
import 'package:newsapp/notifier/articles_notifier.dart';
import 'package:newsapp/notifier/base.dart';
import 'package:newsapp/usecase/latest_news_usecase.dart';

import 'articles_notifier_test.mocks.dart';

@GenerateMocks([LatestCompaniesArticlesUseCase])
void main() {
  group('ArticlesNotifier', () {
    late MockLatestCompaniesArticlesUseCase mockUseCase;
    late ArticlesNotifier notifier;

    setUp(() {
      mockUseCase = MockLatestCompaniesArticlesUseCase();
      notifier = ArticlesNotifier(useCase: mockUseCase);
    });

    test('initial state is empty', () {
      expect(notifier.state, Response.empty());
    });

    test('fetches articles with keywords and updates state on success',
        () async {
      // Sample articles and view models
      final articles = [Article(title: 'Article 1')];
      final viewModels = [
        ArticleViewModel(article: articles[0], category: 'keyword1')
      ];

      // Mock use case behavior
      when(mockUseCase(any, any)).thenAnswer((_) => Future.value([articles]));

      final keywords = ['keyword1'];
      await notifier.fetch(keywords: keywords);

      // Verify state updates
      expect(notifier.state.isSuccess(), true);
      expect(notifier.isLoading, false);
      expect(notifier.keywords, keywords); // Keywords should be set
      expect(notifier.page, 2); // Page should be incremented
    });

    test('fetches articles with empty keywords and sets state to empty',
        () async {
      notifier.keywords = [];
      await notifier.fetch();

      expect(notifier.state.isEmpty(), true);
      expect(notifier.isLoading, false);
      expect(notifier.data, []); // Data should be empty
    });

    test('handles use case error and sets error state', () async {
      // Mock use case error
      when(mockUseCase.call(any, any))
          .thenAnswer((_) => Future.error(Exception('Specific error')));

      final keywords = ['keyword1'];
      await notifier.fetch(keywords: keywords);

      expect(notifier.state.isError(), true);
      expect(notifier.state.mesage, equals('Something went wrong!'));
      expect(notifier.isLoading, false);
    });

    test(
        'handles FailureException from use case and sets specific error message',
        () async {
      // Mock use case error
      when(mockUseCase.call(any, any)).thenAnswer(
          (_) => Future.error(FailureException(massage: 'Specific error')));

      final keywords = ['keyword1'];
      await notifier.fetch(keywords: keywords);

      expect(notifier.state.isError(), true);
      expect(notifier.state.mesage, 'Specific error');
      expect(notifier.isLoading, false);
    });
  });
}
