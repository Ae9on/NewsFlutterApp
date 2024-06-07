import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/data/api.dart';
import 'package:newsapp/notifier/article_viewmodel.dart';
import 'package:newsapp/notifier/base.dart';
import 'package:newsapp/usecase/articles_usecase.dart';

final articlesNotifier =
    StateNotifierProvider<ArticlesNotifier, Response<List<ArticleViewModel>>>(
        (ref) =>
            ArticlesNotifier(useCase: ref.watch(latestArticleUsecaseProvider)));

class ArticlesNotifier extends StateNotifier<Response<List<ArticleViewModel>>> {
  LatestCompaniesArticlesUseCase useCase;

  ArticlesNotifier({required this.useCase}) : super(Response.empty());

  var keywords = <String>[];
  List<ArticleViewModel> data = [];
  int page = 1;
  bool isLoading = false;

  fetch({List<String> keywords = const []}) async {
    state = Response.progress();
    isLoading = true;
    if (keywords.isNotEmpty) {
      this.keywords = keywords;
      page = 1;
      data.clear();
    }
    if (this.keywords.isEmpty) {
      state = Response.empty();
      return;
    }
    useCase.call(this.keywords, page).then((value) {
      page++;
      data.addAll(value
          .expand((element) => (element.isEmpty)
              ? <ArticleViewModel>[]
              : element
                  .map((article) => ArticleViewModel(
                      article: article,
                      category: this.keywords[value.indexOf(element)]))
                  .toList())
          .toList());
      state = Response.success(data: data);
      isLoading = false;
    }).catchError((e) {
      isLoading = false;
      if (e is FailureException) {
        state = Response.error(msg: e.massage);
        return;
      }
      state = Response.error(msg: 'Something went wrong!');
    });
  }
}
