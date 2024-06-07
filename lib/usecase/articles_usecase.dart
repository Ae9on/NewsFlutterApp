import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/data/models/articles_request_params.dart';
import 'package:newsapp/data/repository.dart';

final latestArticleUsecaseProvider = Provider(
    (ref) => LatestCompaniesArticlesUseCase(ref.watch(dataRepositoryProvider)));

class LatestCompaniesArticlesUseCase {
  DataRespository repo;
  LatestCompaniesArticlesUseCase(this.repo);
  Future<List<List<Article>>> call(List<String> keywords, int page) {
    List<List<Article>> fdata = List.generate(keywords.length, (index) => []);
    var reqs = keywords
        .map((kw) => repo
                .articles(ArticlesParams(
                    keyword: kw,
                    from: DateTime.now().subtract(const Duration(days: 1)),
                    to: DateTime.now(),
                    sortBy: ArticleSortBy.publishedAt,
                    page: page))
                .then((value) {
              fdata[keywords.indexOf(kw)] = value;
            }).catchError((e) {
              fdata[keywords.indexOf(kw)] = [];
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
