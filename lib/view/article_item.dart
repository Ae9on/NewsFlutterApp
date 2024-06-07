import 'package:flutter/material.dart';
import 'package:newsapp/notifier/article_viewmodel.dart';
import 'package:newsapp/view/article_cover.dart';
import 'package:timeago/timeago.dart' as timeago;

class ArticleItem extends StatelessWidget {
  const ArticleItem({
    super.key,
    required this.data,
  });

  final ArticleViewModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Hero(
                tag: data,
                child: ArticleCover(uri: data.article.urlToImage ?? '')),
            Positioned(
              left: 10,
              top: 10,
              child: Container(
                padding: const EdgeInsets.only(
                    right: 12, left: 12, top: 2, bottom: 2),
                decoration: const BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.all(Radius.circular(32))),
                child: Text(
                  data.category,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.6,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
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
                  Text(data.article.source?.name ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black45,
                          fontSize: 14)),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(timeago.format(data.article.publishedAt!),
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black45,
                          fontSize: 14)),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                data.article.title ?? '',
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 17.5),
              ),
              const SizedBox(
                height: 6,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
