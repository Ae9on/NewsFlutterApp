import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/notifier/articles_notifier.dart';
import 'package:newsapp/view/common/logo_view.dart';
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
    var theme = Theme.of(context);

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
        title: const Center(
          child: LogoView(),
        ),
      ),
      body: (state.isSuccess() || notifier.page > 1)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 16.0, left: 16, top: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recent Articles',
                                style: theme.textTheme.headlineMedium
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                              Text(
                                'Latest tech news from yesterday to now',
                                style: theme.textTheme.labelLarge
                                    ?.copyWith(fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(
                                top: 16, bottom: 32, left: 8, right: 8),
                            itemCount: notifier.data.length,
                            separatorBuilder: (ctx, index) {
                              // return const Padding(
                              //   padding: EdgeInsets.only(top: 16, bottom: 16),
                              //   child: Divider(height: 1, thickness: 1),
                              // );
                              return const SizedBox(
                                height: 12,
                              );
                            },
                            itemBuilder: (ctx, index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ArticleDetailScreen(
                                                data: notifier.data[index]),
                                      ),
                                    );
                                  },
                                  child:
                                      ArticleItem(data: notifier.data[index]));
                            }),
                      ],
                    ),
                  ),
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
