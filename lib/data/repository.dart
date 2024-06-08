import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/data/api.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/data/models/articles_request_params.dart';

// Provider for creating a DataRespository instance
final dataRepositoryProvider = Provider<DataRespository>((ref) {
  final api = ref.watch(apiProvider);
  return DataRespositoryImp(api);
});

// Abstract class defining the contract for data repository
abstract class DataRespository {
  Future<List<Article>> articles(ArticlesParams params);
}

class DataRespositoryImp implements DataRespository {
  late NewsApi api;

  DataRespositoryImp(this.api);

  @override
  Future<List<Article>> articles(ArticlesParams params) =>
      api.articles(params).then((value) => value
          .where((element) => element.title != '[Removed]')
          .toList()); // Filter out articles with title "[Removed]" (optional logic)
}
