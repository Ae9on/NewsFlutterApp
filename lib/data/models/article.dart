import 'package:hive/hive.dart';

part 'article.g.dart';

enum ArticleSortBy {
  publishedAt("publishedAt");

  final String name;
  const ArticleSortBy(this.name);
}

@HiveType(typeId: 0)
class Article {
  @HiveField(0)
  Source? source;
  @HiveField(1)
  String? author;
  @HiveField(2)
  String? title;
  @HiveField(3)
  String? description;
  @HiveField(4)
  String? url;
  @HiveField(5)
  String? urlToImage;
  @HiveField(6)
  DateTime? publishedAt;
  @HiveField(7)
  String? content;
  @HiveField(8)
  String? keyword;

  Article(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content,
      this.keyword});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: json["source"] != null ? Source.fromJson(json["source"]) : null,
      author: json["author"],
      title: json["title"],
      description: json["description"],
      url: json["url"],
      urlToImage: json["urlToImage"],
      publishedAt: json["publishedAt"] == null
          ? null
          : DateTime.parse(json["publishedAt"]),
      content: json["content"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (source != null) {
      data["source"] = source?.toJson();
    }
    data["author"] = author;
    data["title"] = title;
    data["description"] = description;
    data["url"] = url;
    data["urlToImage"] = urlToImage;
    data["publishedAt"] = publishedAt;
    data["content"] = content;
    data["keyword"] = keyword;
    return data;
  }
}

@HiveType(typeId: 1)
class Source {
  @HiveField(0)
  dynamic id;
  @HiveField(1)
  String? name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    if (json["name"] is String) {
      name = json["name"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}
