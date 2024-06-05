import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/data/api.dart';
import 'package:newsapp/data/models/article.dart';

final dataRepositoryProvider = Provider<DataRespository>((ref) {
  final api = ref.watch(apiProvider);
  return DataRespositoryImp(api);
});

abstract class DataRespository {
  Future<List<Article>> articles(
      List<String> keywords, DateTime from, ArticleSortBy sortBy);
}

class DataRespositoryImp implements DataRespository {
  late NewsApi api;

  DataRespositoryImp(this.api);

  @override
  Future<List<Article>> articles(
          List<String> keywords, DateTime from, ArticleSortBy sortBy) =>
      api
          .articles(keywords.join(' OR '),
              from.toIso8601String().split('T').first, sortBy.name)
          .then((value) =>
              value.where((element) => element.title != '[Removed]').toList());
}
