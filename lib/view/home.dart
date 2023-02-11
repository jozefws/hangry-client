import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatelessWidget {
  Home({super.key, required this.onNext, required this.onBack});
  void Function() onNext;
  void Function() onBack;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
          Container(
            height: 200,
            margin: const EdgeInsets.all(30),
            child: Image.asset("images/Logo.png"),
          ),
          const SizedBox(height: 40),
          Container(
            margin: const EdgeInsets.all(10),
            child: Text("Welcome to Hangry!",
                textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pushNamed(context, '/join');
                    },
                    label: const Text(
                      "Join",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pushNamed(context, '/create');
                    },
                    label: const Text(
                      "Create",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]));
  }
}
