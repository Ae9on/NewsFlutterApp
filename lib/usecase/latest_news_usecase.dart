import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/data/models/articles_request_params.dart';
import 'package:newsapp/data/repository.dart';

// Provider for creating a LatestCompaniesArticlesUseCase instance
final latestArticleUsecaseProvider = Provider(
    (ref) => LatestCompaniesArticlesUseCase(ref.watch(dataRepositoryProvider)));

class LatestCompaniesArticlesUseCase {
  DataRespository repo;
  LatestCompaniesArticlesUseCase(this.repo);
  Future<List<List<Article>>> call(List<String> keywords, int page) {
    /// Fetches latest articles for a list of keywords and page number.
    ///
    /// This method takes a list of keywords and a page number as input.
    /// It then performs the following steps:
    ///   1. Creates an empty list `fdata` to store fetched articles for each keyword.
    ///   2. Creates a list of `Future` objects using `map`. Each future fetches articles
    ///      for a specific keyword using the DataRespository.
    ///   3. Uses `Future.wait` to wait for all futures to complete.
    ///   4. Populates `fdata` with the fetched articles based on their corresponding keyword.
    ///   5. Catches any errors during the process.
    ///     - If no articles are fetched for any keyword (empty `fdata`), the error is re-thrown.
    ///     - Otherwise, the original `fdata` with potentially partially filled data is returned.

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
            }))
        .toList();
    // Wait for all futures to complete and return the populated fdata
    return Future.wait(reqs).then((value) {
      return fdata;
    }).catchError((e) {
      if (fdata.expand((element) => element).isEmpty) {
        // If no articles fetched for any keyword, re-throw the error
        throw e;
      } else {
        // Otherwise, return partially filled fdata (handle potential partial data)
        return fdata;
      }
    });
  }
}
