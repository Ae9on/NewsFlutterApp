import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/data/repository.dart';
import 'package:newsapp/notifier/base.dart';

final articlesNotifier =
    NotifierProvider<ArticlesNotifier, Response<List<Article>>>(
        () => ArticlesNotifier());

class ArticlesNotifier extends Notifier<Response<List<Article>>> {
  late DataRespository respository;

  fetch() async {
    state = Response.progress();
    respository.articles(
        ['Microsoft', 'Apple', 'Google', 'Tesla'],
        DateTime.now().subtract(const Duration(days: 1)),
        DateTime.now(),
        ArticleSortBy.publishedAt).then((value) {
      state = Response.success(data: value);
    }).catchError((e) {
      state = Response.error();
    });
  }

  @override
  Response<List<Article>> build() {
    respository = ref.read(dataRepositoryProvider);
    fetch();
    return Response.progress();
  }
}
