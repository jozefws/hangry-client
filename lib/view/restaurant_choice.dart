import 'package:flutter/material.dart';
import 'package:hangryclient/view/restaurant.dart';

class RestaurantChoicePage extends StatelessWidget {
  const RestaurantChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 100),
        child: Column(
          children: [
            const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Which would you prefer?",
                  style: TextStyle(fontSize: 20),
                )),
            RestaurantCard(
              onSelect: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            RestaurantCard(
              onSelect: () {},
            ),
          ],
        ));
  }
}
