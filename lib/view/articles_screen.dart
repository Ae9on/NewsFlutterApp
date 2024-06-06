import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/notifier/articles_notifier.dart';
import 'package:newsapp/view/article_datail_screen.dart';
import 'package:newsapp/view/article_item.dart';

class ArticlesScreen extends ConsumerWidget {
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(articlesNotifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'NewsFeed',
            style: TextStyle(
                color: Colors.deepPurple, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: (state.isSuccess())
          ? ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: state.data?.length ?? 0,
              separatorBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Container(
                    height: .4,
                    color: Colors.black38,
                  ),
                );
              },
              itemBuilder: (ctx, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticleDetailScreen(
                              data: state.data![index].article),
                        ),
                      );
                    },
                    child: ArticleItem(data: state.data![index]));
              })
          : (state.isProgress())
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(),
    );
  }
}
