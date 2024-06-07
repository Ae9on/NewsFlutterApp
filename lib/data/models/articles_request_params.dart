import 'package:newsapp/data/models/article.dart';

class ArticlesParams {
  String? keyword;
  ArticleSortBy? sortBy;
  DateTime? from;
  DateTime? to;
  String? language;
  int? page;
  int? pageSize;

  ArticlesParams({
    required this.keyword,
    this.sortBy = ArticleSortBy.publishedAt,
    this.language = 'en',
    this.page = 1,
    this.pageSize = 20,
    this.from,
    this.to,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["q"] = keyword;
    data["from"] = from?.toIso8601String().split('T').first;
    data["to"] = to?.toIso8601String().split('T').first;
    data["page"] = page;
    data["pageSize"] = pageSize;
    data["language"] = language;
    data["sortBy"] = sortBy?.name;
    data['apiKey'] = 'f1a159e96d5e4117b87411b14bc2007f';
    return data;
  }
}
