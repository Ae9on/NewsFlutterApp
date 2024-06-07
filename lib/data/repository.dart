import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/data/api.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/data/models/articles_request_params.dart';

final dataRepositoryProvider = Provider<DataRespository>((ref) {
  final api = ref.watch(apiProvider);
  return DataRespositoryImp(api);
});

abstract class DataRespository {
  Future<List<Article>> articles(ArticlesParams params);
}

class DataRespositoryImp implements DataRespository {
  late NewsApi api;

  DataRespositoryImp(this.api);

  @override
  Future<List<Article>> articles(ArticlesParams params) =>
      api.articles(params).then((value) =>
          value.where((element) => element.title != '[Removed]').toList());
}
