import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hangryclient/provider/session_provider.dart';
import 'package:hangryclient/view/create.dart';
import 'package:hangryclient/model/place.dart';
import 'package:hangryclient/view/home.dart';
import 'package:hangryclient/view/in_out.dart';
import 'package:hangryclient/view/food_categories_page.dart';
import 'package:hangryclient/view/price_page.dart';
import 'package:hangryclient/view/restaurant_choice.dart';
import 'package:hangryclient/view/waiting_page.dart';
import 'package:hangryclient/view/join.dart';
import 'package:provider/provider.dart';

class FlowParent extends StatefulWidget {
  const FlowParent({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FlowParentState();
}

enum UserType { host, guest }

class _FlowParentState extends State<FlowParent> {
  UserType? type;

  final PageController _controller = PageController(initialPage: 0, keepPage: false);
  List<Widget> children = [];

  void goToNextPage() {
    _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);

    setState(() {});
  }

  void goToLastPage() {
    _controller.animateToPage(_controller.page!.toInt() - 1,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    setState(() {
      children.removeLast();
    });
  }

  @override
  void initState() {
    super.initState();
    children = [
      Home(
        onNext: (next) {
          if (next != null) children.add(next);
          goToNextPage();
        },
        onBack: () => goToLastPage(),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionProvider>(
        builder: (context, session, child) => Scaffold(
              appBar: AppBar(
                title: session.code != null ? Text("Join with ${session.code}") : null,
                leading: children.length == 1
                    ? null
                    : InkWell(
                        onTap: goToLastPage,
                        child: Icon(
                          CupertinoIcons.back,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
              ),
              body: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                children: children,
              ),
            ));
  }
}
