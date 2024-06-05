import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/data/repository.dart';

final articleUsecaseProvider =
    Provider((ref) => ArticlesUseCase(ref.watch(dataRepositoryProvider)));

class ArticlesUseCase {
  DataRespository repo;
  ArticlesUseCase(this.repo);
  Future<List<Article>> call(
      List<String> keywords, DateTime from, ArticleSortBy sortBy) {
    return repo.articles(keywords, from, sortBy);
  }
}
