import 'package:flutter/material.dart';
import 'package:hangryclient/view/welcome_page.dart';

class ModeSelectPage extends StatefulWidget {
  const ModeSelectPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ModeSelectPageState();
}

enum UserType { host, guest }

class _ModeSelectPageState extends State<ModeSelectPage> {
  UserType? type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [WelcomePage()],
      ),
    );
  }
}
