import 'package:flutter/cupertino.dart';
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
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              description!,
              style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 32,
            ),
            Visibility(
              visible: action != null,
              child: GestureDetector(
                  onTap: onRetry,
                  child: Text(
                    action ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.deepPurple),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
