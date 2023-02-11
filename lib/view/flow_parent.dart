import 'package:flutter/material.dart';
import 'package:hangryclient/model/place.dart';
import 'package:hangryclient/view/home.dart';
import 'package:hangryclient/view/in_out.dart';
import 'package:hangryclient/view/food_categories_page.dart';
import 'package:hangryclient/view/price_page.dart';
import 'package:hangryclient/view/restaurant_choice.dart';
import 'package:hangryclient/view/waiting_page.dart';

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
        onNext: () => goToNextPage(),
        onBack: () => goToLastPage(),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: _controller.positions.isEmpty ? false : _controller.page! != 0,
      ),
      body: PageView(
        controller: _controller,
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          Home(
            onNext: () => goToNextPage(),
            onBack: () {},
          ),
          ModeSelector(
            onNext: () => goToNextPage(),
            onBack: () => goToLastPage(),
          ),
          FoodCategoriesPage(
            onNext: () => goToNextPage(),
            onBack: () => goToLastPage(),
          ),
          PricePage(
            onNext: () => goToNextPage(),
            onBack: () => goToLastPage(),
          ),
          const WaitingPage(),
          RestaurantChoicePage(choices: [
            const Place(
                id: "dlsfjsldkfj",
                name: "Restaurant 1",
                description: "This is a very good restaurant",
                photo: ""),
            const Place(
                id: "dlsfjsldkfj",
                name: "Restaurant 2",
                description: "This is a very good restaurant",
                photo: ""),
          ])
        ],
      ),
    );
  }
}
