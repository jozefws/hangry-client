import 'package:flutter/material.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({super.key, required this.child, required this.onNext});

  final Widget child;
  final void Function() onNext;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: FractionalOffset.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30, right: 30),
            child: MaterialButton(
                onPressed: onNext, child: const Text("Next", style: TextStyle(fontSize: 20))),
          ),
        ),
        child
      ],
    );
  }
}
