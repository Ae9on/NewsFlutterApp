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
        title: const Center(
          child: Text(
            'Continue Reading',
            style: TextStyle(
                color: Colors.deepPurple, fontWeight: FontWeight.w500),
          ),
        ),
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
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(
                height: 8,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: ArticleCover(uri: data.urlToImage ?? ''),
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
