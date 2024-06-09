import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/data/local/local_repository.dart';
import 'package:newsapp/data/remote/api.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/data/models/articles_request_params.dart';

final dataRepositoryProvider = Provider<DataRespository>((ref) {
  final api = ref.watch(apiProvider);
  final local = ref.watch(localDataRepositoryProvider);
  return DataRespositoryImp(api, local);
});

abstract class DataRespository {
  Future<List<Article>> articles(ArticlesParams params);
  Future<List<Article>> latestArticles(List<String> keywords, int page);
}

class DataRespositoryImp implements DataRespository {
  late NewsApi api;
  late LocalDataRepository local;

  DataRespositoryImp(this.api, this.local);

  @override
  // This method fetches articles using the injected NewsApi and filters out articles with a title of "[Removed]".
  Future<List<Article>> articles(ArticlesParams params) =>
      api.articles(params).then((value) =>
          value.where((element) => element.title != '[Removed]').toList());

  @override
  Future<List<Article>> latestArticles(List<String> keywords, int page) {
    // This method fetches articles for multiple keywords and combines the results.
    // Initialize an empty list to store fetched articles for each keyword.
    List<List<Article>> fdata = List.generate(keywords.length, (index) => []);
    // Create a list of Futures, one for each keyword, fetching articles using articles method.
    var reqs = keywords
        .map((kw) => articles(ArticlesParams(
                    keyword: kw,
                    from: DateTime.now().subtract(const Duration(days: 1)),
                    to: DateTime.now(),
                    sortBy: ArticleSortBy.publishedAt,
                    page: page))
                .then((value) {
              // Update the corresponding index in fdata with the fetched articles for the keyword.
              fdata[keywords.indexOf(kw)] = value;
            }))
        .toList();
    // Wait for all futures to complete using Future.wait.
    return Future.wait(reqs).then((value) async {
      var list = fdata.expand((element) => element).toList();
      //Handle cache management and error scenarios based on the page number.
      if (page == 1) {
        //Clear the local cache if it's the first page.
        await local.clearCache();
      }
      //Add the fetched articles to the local cache.
      await local.addArticles(list);
      return list;
    }).catchError((e) async {
      //If no articles are fetched from the API and it's the first page, try fetching from cache.
      if (fdata.expand((element) => element).isEmpty) {
        var chacheData = await local.fetchArticles();
        if (chacheData.isEmpty || page > 1) {
          throw e;
        }
        return chacheData;
      } else {
        return fdata.expand((element) => element).toList();
      }
    });
  }
}
