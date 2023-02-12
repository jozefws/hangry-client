import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hangryclient/view/create.dart';
import 'package:hangryclient/view/food_categories_page.dart';
import 'package:hangryclient/view/join.dart';

class Home extends StatelessWidget {
  Home({super.key, required this.onNext, required this.onBack});
  void Function(Widget? next) onNext;
  void Function() onBack;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 180,
            margin: const EdgeInsets.all(40),
            child: Image.asset("images/Logo.png"),
          ),
          const SizedBox(height: 40),
          Container(
            margin: const EdgeInsets.all(10),
            child: Text("Welcome to Hangry!",
                textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Text("Do you want to start a group or join one",
                textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge),
          ),
          const SizedBox(height: 40),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    child: FloatingActionButton.extended(
                      onPressed: () => onNext(JoinSession(
                        imagePath: "",
                        onNext: (next) => onNext(next),
                        onBack: onBack,
                      )),
                      label: const Text(
                        "Join",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    child: FloatingActionButton.extended(
                      onPressed: () => onNext(CreateSession(
                        imagePath: "",
                        onNext: (next) => onNext(next),
                        onBack: onBack,
                      )),
                      label: const Text(
                        "Create",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ]),
          SizedBox(
            height: 80,
          )
        ],
      ),
    );
  }
}
