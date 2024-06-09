import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/data/repository.dart';

// Provider for creating a LatestCompaniesArticlesUseCase instance
final latestArticleUsecaseProvider = Provider(
    (ref) => LatestCompaniesArticlesUseCase(ref.watch(dataRepositoryProvider)));

class LatestCompaniesArticlesUseCase {
  DataRespository repo;
  LatestCompaniesArticlesUseCase(this.repo);
  Future<List<Article>> call(List<String> keywords, int page) {
    return repo.latestArticles(keywords, page);
  }
}
