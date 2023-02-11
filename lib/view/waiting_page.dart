import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WaitingPage extends StatefulWidget {
  const WaitingPage({super.key});

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: SvgPicture.asset(
              "images/undraw_wait_in_line.svg",
              height: 140,
            )),
        const Padding(
            padding: EdgeInsets.all(20), child: CircularProgressIndicator()),
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
          height: 40,
        ),
        Container(height: 100, child: SelfieDisplayGen()),
        const SizedBox(
          height: 80,
        )
      ],
    ));
  }
}

ListView SelfieDisplayGen() {
  List<Widget> list = [];
  for (var i in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) {
    list.add(
      Container(
        margin: const EdgeInsets.all(10),
        child: const CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage("images/Logo.png"),
        ),
      ),
    );
  }
  return ListView(
    scrollDirection: Axis.horizontal,
    children: list,
  );
}
