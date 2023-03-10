import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hangryclient/provider/session_provider.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';

class WaitingPage extends StatefulWidget {
  const WaitingPage({super.key});

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SessionProvider>(
        builder: (context, session, child) => Center(
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
                Container(height: 100, child: SelfieDisplayGen()),
                const SizedBox(
                  height: 40,
                ),
                if (session.admin)
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
                const SizedBox(
                  height: 80,
                )
              ],
            )));
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
