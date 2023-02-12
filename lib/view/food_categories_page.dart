import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hangryclient/helpers.dart';
import 'package:hangryclient/provider/session_provider.dart';
import 'package:hangryclient/view/price_page.dart';
import 'package:provider/provider.dart';

class FoodCategoriesPage extends StatefulWidget {
  const FoodCategoriesPage({super.key, required this.onNext, required this.onBack});
  final void Function(Widget?) onNext;
  final void Function() onBack;
  @override
  State<StatefulWidget> createState() => _FoodCategoriesPageState();
}

enum Category {
  chinese,
  italian,
  indian,
  greek,
  pub,
  french,
  caribbean,
  thai,
  spanish,
  mexican,
  japanese,
  tapas,
  halal,
}

enum Restrictions { vegetarian, alcohol, wheelchair }

extension ToString on Category {
  String toPrettyString() {
    return toString().split('.').last.capitalize();
  }
}

extension RestrictionToString on Restrictions {
  String toPrettyString() {
    if (this == Restrictions.wheelchair) {
      return "Wheelchair Accessible";
    }
    return toString().split('.').last.capitalize();
  }
}

class _FoodCategoriesPageState extends State<FoodCategoriesPage> {
  List<Category> choices = [];
  List<Restrictions> restrictions = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionProvider>(
        builder: (context, session, child) => Stack(children: [
              Align(
                alignment: FractionalOffset.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40, right: 40),
                  child: MaterialButton(
                      onPressed: choices.length > 1
                          ? () {
                              session.setCategories(choices, restrictions);
                              widget.onNext(PricePage(
                                  onNext: (next) => widget.onNext(next), onBack: widget.onBack));
                            }
                          : null,
                      child: const Text("Next", style: TextStyle(fontSize: 18))),
                ),
              ),
              Center(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                              child: SvgPicture.asset("images/undraw_hamburger.svg", width: 220)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: Category.values
                                .take(3)
                                .map((e) => Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4),
                                    child: ChoiceChip(
                                        label: Text(e.toPrettyString(),
                                            style: const TextStyle(fontSize: 16)),
                                        selected: choices.contains(e),
                                        onSelected: (value) {
                                          setState(
                                              () => value ? choices.add(e) : choices.remove(e));
                                        })))
                                .toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: Category.values
                                .sublist(3)
                                .take(3)
                                .map((e) => Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4),
                                    child: ChoiceChip(
                                        label: Text(e.toPrettyString(),
                                            style: const TextStyle(fontSize: 16)),
                                        selected: choices.contains(e),
                                        onSelected: (value) {
                                          setState(
                                              () => value ? choices.add(e) : choices.remove(e));
                                        })))
                                .toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: Category.values
                                .sublist(6)
                                .take(3)
                                .map((e) => Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4),
                                    child: ChoiceChip(
                                        label: Text(e.toPrettyString(),
                                            style: const TextStyle(fontSize: 16)),
                                        selected: choices.contains(e),
                                        onSelected: (value) {
                                          setState(
                                              () => value ? choices.add(e) : choices.remove(e));
                                        })))
                                .toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: Category.values
                                .sublist(9)
                                .take(3)
                                .map((e) => Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4),
                                    child: ChoiceChip(
                                        label: Text(e.toPrettyString(),
                                            style: const TextStyle(fontSize: 16)),
                                        selected: choices.contains(e),
                                        onSelected: (value) {
                                          setState(
                                              () => value ? choices.add(e) : choices.remove(e));
                                        })))
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: Restrictions.values
                                .take(2)
                                .map((e) => Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4),
                                    child: ChoiceChip(
                                        label: Text(e.toPrettyString(),
                                            style: const TextStyle(fontSize: 16)),
                                        selected: restrictions.contains(e),
                                        onSelected: (value) {
                                          setState(() =>
                                              value ? restrictions.add(e) : restrictions.remove(e));
                                        })))
                                .toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: Restrictions.values
                                .sublist(2)
                                .map((e) => ChoiceChip(
                                    label: Text(e.toPrettyString(),
                                        style: const TextStyle(fontSize: 16)),
                                    selected: restrictions.contains(e),
                                    onSelected: (value) {
                                      setState(() =>
                                          value ? restrictions.add(e) : restrictions.remove(e));
                                    }))
                                .toList(),
                          ),
                          SizedBox(
                            height: 100,
                          )
                        ],
                      )))
            ]));
  }
}
