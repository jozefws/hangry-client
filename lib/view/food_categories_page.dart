import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hangryclient/helpers.dart';
import 'package:hangryclient/view/page_view_item.dart';

class FoodCategoriesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FoodCategoriesPageState();
}

enum Category {
  chinese,
  italian,
  indian,
  greek,
  japanese,
  french,
  caribbean,
  thai,
  spanish,
  mexican,
  pub,
  tapas,
}

enum Restrictions { vegetarian, alcohol }

extension ToString on Category {
  String toPrettyString() {
    return toString().split('.').last.capitalize();
  }
}

extension RestrictionToString on Restrictions {
  String toPrettyString() {
    return toString().split('.').last.capitalize();
  }
}

class _FoodCategoriesPageState extends State<FoodCategoriesPage> {
  List<Category> choices = [];
  List<Restrictions> restrictions = [];

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Align(
        alignment: FractionalOffset.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40, right: 40),
          child: MaterialButton(
              onPressed: choices.length > 1 ? () {} : null,
              child: const Text("Next", style: TextStyle(fontSize: 18))),
        ),
      ),
      Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Let's get started! What could you go for?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: SvgPicture.asset("images/undraw_hamburger.svg", width: 250)),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0,
                    runSpacing: 4,
                    children: Category.values
                        .map((e) => ChoiceChip(
                            label: Text(e.toPrettyString(), style: const TextStyle(fontSize: 16)),
                            selected: choices.contains(e),
                            onSelected: (value) {
                              setState(() => value ? choices.add(e) : choices.remove(e));
                            }))
                        .toList(),
                  ),
                  AnimatedOpacity(
                      opacity: choices.length > 1 ? 0.0 : 0.8,
                      duration: const Duration(milliseconds: 300),
                      child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("Select at least 2 categories"))),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0,
                    runSpacing: 4,
                    children: Restrictions.values
                        .map((e) => ChoiceChip(
                            label: Text(e.toPrettyString(), style: const TextStyle(fontSize: 16)),
                            selected: restrictions.contains(e),
                            onSelected: (value) {
                              setState(() => value ? restrictions.add(e) : restrictions.remove(e));
                            }))
                        .toList(),
                  )
                ],
              )))
    ]);
  }
}
