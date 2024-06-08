import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/notifier/viewmodels/article_viewmodel.dart';
import 'package:newsapp/notifier/articles_notifier.dart';
import 'package:newsapp/view/article_cover.dart';
import 'package:newsapp/view/common/logo_view.dart';

class ArticleDetailScreen extends ConsumerWidget {
  ArticleDetailScreen({super.key, required this.data});
  ArticleViewModel data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(articlesNotifier);
    var theme = Theme.of(context);
    const infoTextStyle = TextStyle(
        fontWeight: FontWeight.w700, color: Colors.black54, fontSize: 15);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const LogoView(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
                tag: data,
                child: ArticleCover(
                  uri: data.article.urlToImage ?? '',
                  ratio: 1.6,
                )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.article.title ?? '',
                    textAlign: TextAlign.start,
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700, height: 1.5),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (data.article.author != null)
                    Row(
                      children: [
                        const Text('Written by ', style: infoTextStyle),
                        Text(data.article.author!,
                            style: infoTextStyle.copyWith(
                                color: theme.colorScheme.primary)),
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
                          const Text('Published at ', style: infoTextStyle),
                          Text(data.article.source?.name ?? '',
                              style: infoTextStyle.copyWith(
                                  color: theme.colorScheme.primary)),
                          const SizedBox(
                            width: 2,
                          ),
                          const Expanded(child: SizedBox()),
                          Text(
                              DateFormat.yMMMMd()
                                  .format(data.article.publishedAt!),
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
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 1.68),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
