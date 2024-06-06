import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/data/repository.dart';
import 'package:newsapp/notifier/article_viewmodel.dart';
import 'package:newsapp/notifier/base.dart';
import 'package:newsapp/usecase/articles_usecase.dart';

final articlesNotifier =
    NotifierProvider<ArticlesNotifier, Response<List<ArticleViewModel>>>(
        () => ArticlesNotifier());

class ArticlesNotifier extends Notifier<Response<List<ArticleViewModel>>> {
  late LatestCompaniesArticlesUseCase useCase;

  var keywords = <String>[];
  List<ArticleViewModel> data = [];
  int page = 1;

  fetch(List<String> keywords) async {
    if (keywords.isNotEmpty) {
      this.keywords = keywords;
    }
    state = Response.progress();
    useCase.call(keywords).then((value) {
      state = Response.success(
          data: value
              .expand((element) => element
                  .map((article) => ArticleViewModel(
                      article: article,
                      category: keywords[value.indexOf(element)]))
                  .toList())
              .toList());
    }).catchError((e) {
      state = Response.error();
    });
  }

  @override
  Response<List<ArticleViewModel>> build() {
    useCase = ref.read(latestArticleUsecaseProvider);
    fetch(['Microsoft', 'Apple', 'Google', 'Tesla']);
    return Response.progress();
  }
}
