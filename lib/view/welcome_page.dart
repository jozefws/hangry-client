import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Expanded(
            child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: () => {}, child: const Text("Eat Out")),
        Text("or"),
        ElevatedButton(onPressed: () => {}, child: const Text("Order In"))
      ],
    )));
  }
}
