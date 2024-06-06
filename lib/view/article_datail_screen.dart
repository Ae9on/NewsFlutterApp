import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/notifier/articles_notifier.dart';
import 'package:newsapp/view/article_cover.dart';
import 'package:newsapp/view/article_item.dart';

class ArticleDetailScreen extends ConsumerWidget {
  ArticleDetailScreen({super.key, required this.data});
  Article data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(articlesNotifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title ?? '',
                textAlign: TextAlign.start,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const SizedBox(
                height: 4,
              ),
              if (data.author != null)
                Row(
                  children: [
                    const Text('Written by ',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black45,
                            fontSize: 14)),
                    Text(data.author!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.deepPurple,
                            fontSize: 14)),
                  ],
                ),
              const SizedBox(
                height: 8,
              ),
              Hero(tag: data, child: ArticleCover(uri: data.urlToImage ?? '')),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 6.0, left: 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(data.source?.name ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black45,
                                fontSize: 14)),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(data.publishedAt ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black45,
                                fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                data.content ?? '',
                textAlign: TextAlign.start,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
