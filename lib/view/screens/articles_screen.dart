import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/notifier/articles_notifier.dart';
import 'package:newsapp/view/screens/article_datail_screen.dart';
import 'package:newsapp/view/article_item.dart';
import 'package:newsapp/view/common/state_view.dart';

class ArticlesScreen extends HookConsumerWidget {
  const ArticlesScreen({super.key});

  static const keyWords = ['Microsoft'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(articlesNotifier);
    var notifier = ref.watch(articlesNotifier.notifier);

    var scrollController = useScrollController();

    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.hasClients) {
          if (scrollController.position.maxScrollExtent ==
                  scrollController.offset &&
              !notifier.isLoading) {
            notifier.fetch();
          }
        }
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifier.fetch(keywords: keyWords);
      });
      return null;
    }, [scrollController]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'NewsFeed',
            style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.w600,
                fontSize: 24),
          ),
        ),
      ),
      body: (state.isSuccess() || notifier.page > 1)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.separated(
                      controller: scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: notifier.data.length,
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
                                      data: notifier.data[index]),
                                ),
                              );
                            },
                            child: ArticleItem(data: notifier.data[index]));
                      }),
                ),
                if (state.isProgress()) const LinearProgressIndicator()
              ],
            )
          : (state.isProgress())
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : (state.isError())
                  ? StateView.error(
                      action: 'Try again',
                      image: 'assets/error_placeholder.png',
                      description: state.mesage,
                      onRetry: () {
                        notifier.fetch(keywords: keyWords);
                      },
                    )
                  : Container(),
    );
  }
}
