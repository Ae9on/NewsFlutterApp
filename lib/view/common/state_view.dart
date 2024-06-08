import 'package:flutter/material.dart';

enum StateType {
  NOTFOUND,
  ERROR,
}

class StateView extends StatelessWidget {
  StateType type;
  String? title;
  String? description;
  VoidCallback? onRetry;
  String? action;
  String? image;

  StateView.notFound(
      {super.key,
      this.title,
      this.description,
      this.onRetry,
      this.action,
      this.image})
      : type = StateType.NOTFOUND;

  StateView.error(
      {super.key,
      this.title = 'Oops!',
      this.description = 'Something went wrong',
      this.onRetry,
      this.image,
      this.action})
      : type = StateType.ERROR;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (type == StateType.ERROR)
                ? SizedBox(
                    height: 200,
                    child: Image.asset(image ?? 'assets/error_placeholder.png'))
                : SizedBox(
                    height: 200,
                    child:
                        Image.asset(image ?? 'assets/error_placeholder.png')),
            const SizedBox(
              height: 12,
            ),
            Text(
              title!,
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              description!,
              style: theme.textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 32,
            ),
            Visibility(
              visible: action != null,
              child: GestureDetector(
                  onTap: onRetry,
                  child: Container(
                    padding: const EdgeInsets.only(
                        right: 22, left: 22, top: 8, bottom: 8),
                    decoration: const BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.all(Radius.circular(32))),
                    child: Text(
                      action ?? '',
                      textAlign: TextAlign.start,
                      style: theme.textTheme.labelLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
