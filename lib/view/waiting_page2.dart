import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hangryclient/api/hangry_api.dart';
import 'package:hangryclient/provider/session_provider.dart';
import 'package:hangryclient/view/restaurant_choice.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';

class WaitingPage2 extends StatefulWidget {
  const WaitingPage2({super.key, required this.onNext});
  final void Function(Widget?) onNext;

  @override
  State<WaitingPage2> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage2> {
  Timer? timer;
  bool ready = false;

  @override
  initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 2), (Timer t) => checkInfo());
  }

  Future<void> checkInfo() async {}

  @override
  dispose() {
    timer?.cancel();
    super.dispose();
  }

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
          height: 40,
        ),
        SizedBox(height: 100, child: SelfieDisplayGen()),
        const SizedBox(
          height: 40,
        ),
        Consumer<SessionProvider>(
            builder: (context, session, child) => FloatingActionButton.extended(
                onPressed: () async {
                  await HangryApi().start(session.code!, session.uuid!);
                  widget.onNext(RestaurantChoicePage(
                    uuid: session.uuid!,
                    code: session.code!,
                    onNext: (p0) => widget.onNext(p0),
                  ));
                },
                label: const Text("Begin choosing"),
                icon: const Icon(Icons.arrow_forward))),
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
