import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/data/repository.dart';

final latestArticleUsecaseProvider = Provider(
    (ref) => LatestCompaniesArticlesUseCase(ref.watch(dataRepositoryProvider)));

class LatestCompaniesArticlesUseCase {
  DataRespository repo;
  LatestCompaniesArticlesUseCase(this.repo);
  Future<List<List<Article>>> call(List<String> keywords) {
    var fromParam = DateTime.now().subtract(const Duration(days: 1));
    var toParam = DateTime.now();
    var sortParam = ArticleSortBy.publishedAt;
    List<List<Article>> fdata = List.generate(keywords.length, (index) => []);
    var reqs = keywords
        .map((kw) =>
            repo.articles(kw, fromParam, toParam, sortParam).then((value) {
              fdata[keywords.indexOf(kw)] = value;
            }))
        .toList();
    return Future.wait(reqs).then((value) {
      return fdata;
    }).catchError((e) {
      if (fdata.isEmpty) {
        throw e;
      } else {
        return fdata;
      }
    });
  }
}
