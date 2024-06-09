import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/data/remote/api.dart';
import 'package:newsapp/exceptions.dart';
import 'package:newsapp/notifier/base.dart';
import 'package:newsapp/usecase/latest_news_usecase.dart';

// Provider for creating an ArticlesNotifier instance
final articlesNotifier =
    StateNotifierProvider<ArticlesNotifier, Response<List<Article>>>((ref) =>
        ArticlesNotifier(useCase: ref.watch(latestArticleUsecaseProvider)));

class ArticlesNotifier extends StateNotifier<Response<List<Article>>> {
  LatestCompaniesArticlesUseCase useCase;

  ArticlesNotifier({required this.useCase}) : super(Response.empty());

  // State variables to track data and loading state
  List<String> keywords = []; // List of keywords to fetch articles for
  List<Article> data = []; // List to store fetched articles
  int page = 1; // Current page number for pagination
  bool isLoading = false; // Flag to indicate if data is being fetched

  /// Fetches articles for the provided keywords or uses existing keywords if none provided.
  ///
  /// This method takes an optional `keywords` parameter. If provided, it updates the internal
  /// keyword list, resets page number, and clears fetched data. It then fetches articles for
  /// the new keywords. If no keywords are provided, it does nothing.
  /// The method uses the `useCase` to fetch articles and populates the `data` list with
  /// `Article` objects. It updates the state based on success, error, or loading status.
  fetch({List<String> keywords = const []}) async {
    state = Response.progress();
    // Update keywords and page if new keywords provided
    if (keywords.isNotEmpty) {
      this.keywords = keywords;
      page = 1;
      data.clear();
    }
    // Check if there are any keywords to fetch articles for
    if (this.keywords.isEmpty) {
      // No keywords, update state to empty and return
      state = Response.empty();
      return;
    }
    isLoading = true;
    useCase.call(this.keywords, page).then((value) {
      page++;
      // Process fetched articles and convert them to ArticleViewModel objects
      data.addAll(value);
      state = Response.success(data: data);
      isLoading = false;
    }).catchError((e) {
      isLoading = false;
      if (e is FailureException) {
        // Update state with specific error message from FailureException
        state = Response.error(msg: e.massage);
        return;
      }
      // Update state with generic error message for other exceptions
      state = Response.error(msg: 'Something went wrong!');
    });
  }
}
