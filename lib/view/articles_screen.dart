import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/notifier/articles_notifier.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:timeago/timeago.dart' as timeago;

class ArticlesScreen extends ConsumerWidget {
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(articlesNotifier);
    return Scaffold(
      body: (state.isSuccess())
          ? ListView.separated(
              itemCount: state.data?.length ?? 0,
              separatorBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      right: 12, left: 12, top: 16, bottom: 16),
                  child: Container(
                    height: .4,
                    color: Colors.black38,
                  ),
                );
              },
              itemBuilder: (ctx, index) {
                var data = state.data![index];
                return Padding(
                  padding: const EdgeInsets.only(right: 12.0, left: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: FadeInImage.assetNetwork(
                              image: data.urlToImage ?? '',
                              imageErrorBuilder: (ctx, _, e) {
                                return Image.asset(
                                  'assets/placeholder.png',
                                  fit: BoxFit.cover,
                                );
                              },
                              placeholder: 'assets/placeholder.png',
                              fit: BoxFit.cover,
                            )),
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
                                Text(
                                    timeago.format(
                                        DateTime.parse(data.publishedAt ?? '')),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black45,
                                        fontSize: 13)),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              data.title ?? '',
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              })
          : (state.isProgress())
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(),
    );
  }
}
