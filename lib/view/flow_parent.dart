import 'package:flutter/material.dart';
import 'package:hangryclient/view/home.dart';
import 'package:hangryclient/view/in_out.dart';

class FlowParent extends StatefulWidget {
  const FlowParent({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FlowParentState();
}

enum UserType { host, guest }

class _FlowParentState extends State<FlowParent> {
  UserType? type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [Home(), ModeSelector()],
      ),
    );
  }
}
