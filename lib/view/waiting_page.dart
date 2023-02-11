import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WaitingPage extends StatelessWidget {
  const WaitingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: SvgPicture.asset(
                      "images/undraw_wait_in_line.svg",
                      height: 200,
                    )),
                const Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator()),
                const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      "Waiting on your friends",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    )),
                const Text(
                  "Give them a minute...",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 200,
                )
              ],
            )));
  }
}
