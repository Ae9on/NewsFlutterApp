import 'package:flutter/material.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/view/article_cover.dart';
import 'package:timeago/timeago.dart' as timeago;

class ArticleItem extends StatelessWidget {
  const ArticleItem({
    super.key,
    required this.data,
  });

  final Article data;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
              tag: data,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ArticleCover(uri: data.urlToImage ?? ''),
              )),
          Padding(
            padding:
                const EdgeInsets.only(right: 12, left: 12, bottom: 12, top: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title ?? '',
                  maxLines: 3,
                  textAlign: TextAlign.start,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(data.source?.name ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                            fontSize: 12)),
                    const SizedBox(
                      height: 12,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8),
                        child: VerticalDivider(
                          width: 1,
                          thickness: 1.6,
                        ),
                      ),
                    ),
                    Text(timeago.format(data.publishedAt!),
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                            fontSize: 12)),
                    const Expanded(child: SizedBox()),
                    Text(
                      '#${data.keyword}',
                      textAlign: TextAlign.start,
                      style: theme.textTheme.labelMedium?.copyWith(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
