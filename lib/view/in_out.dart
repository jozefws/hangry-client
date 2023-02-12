import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ModeSelector extends StatelessWidget {
  ModeSelector({super.key, required this.onNext, required this.onBack});
  void Function() onNext;
  void Function() onBack;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: Text("Do you want to order or eat in?",
                textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 250,
                height: 120,
                margin: const EdgeInsets.all(10),
                child: Expanded(
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pushNamed(context, '/order');
                    },
                    label: const Text(
                      "Order",
                      style: TextStyle(fontSize: 20),
                    ),
                    icon: SvgPicture.asset("images/orderIn.svg", width: 120),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 250,
                height: 120,
                margin: const EdgeInsets.all(10),
                child: Expanded(
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pushNamed(context, '/eatIn');
                    },
                    label: const Text(
                      "Eat Out",
                      style: TextStyle(fontSize: 20),
                    ),
                    icon: SvgPicture.asset("images/eatOut.svg", width: 100),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 70),
        ]));
  }
}
