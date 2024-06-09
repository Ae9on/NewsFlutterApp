import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/data/models/article.dart';

final localDataRepositoryProvider = Provider<LocalDataRepository>((ref) {
  return LocalDataRepositoryImp();
});

abstract class LocalDataRepository {
  Future addArticles(List<Article> data);
  Future<List<Article>> fetchArticles();
  Future clearCache();
}

class LocalDataRepositoryImp implements LocalDataRepository {
  @override
  Future addArticles(List<Article> data) async {
    var box = await Hive.openBox('latest_articles');
    return box.addAll(data);
  }

  @override
  Future clearCache() async {
    var box = await Hive.openBox('latest_articles');
    return box.clear();
  }

  @override
  Future<List<Article>> fetchArticles() async {
    var box = await Hive.openBox('latest_articles');
    return box.values.cast<Article>().toList();
  }
}
