import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/notifier/article_viewmodel.dart';
import 'package:newsapp/notifier/articles_notifier.dart';
import 'package:newsapp/view/article_cover.dart';

class ArticleDetailScreen extends ConsumerWidget {
  ArticleDetailScreen({super.key, required this.data});
  ArticleViewModel data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(articlesNotifier);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: const Icon(
          Icons.arrow_back_rounded,
          size: 32,
          color: Colors.deepPurple,
        ),
        backgroundColor: Colors.white,
        title: Text(
          '${data.category}\'s Article',
          style: const TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w600,
              fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.article.title ?? '',
                textAlign: TextAlign.start,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 21),
              ),
              const SizedBox(
                height: 12,
              ),
              Hero(
                  tag: data,
                  child: ArticleCover(uri: data.article.urlToImage ?? '')),
              const SizedBox(
                height: 8,
              ),
              if (data.article.author != null)
                Row(
                  children: [
                    const Text('Written by ',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black45,
                            fontSize: 15)),
                    Text(data.article.author!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.deepPurple,
                            fontSize: 15)),
                  ],
                ),
              const SizedBox(
                height: 2,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Published at ',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black45,
                              fontSize: 15)),
                      Text(data.article.source?.name ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.deepPurple,
                              fontSize: 15)),
                      const SizedBox(
                        width: 2,
                      ),
                      const Expanded(child: SizedBox()),
                      Text(
                          DateFormat.yMMMMd().format(data.article.publishedAt!),
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black45,
                              fontSize: 13)),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                data.article.content ?? '',
                textAlign: TextAlign.start,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
