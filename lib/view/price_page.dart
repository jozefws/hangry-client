import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PricePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PricePageState();
}

class _PricePageState extends State<PricePage> {
  double bottom = 10.0;
  double top = 30.0;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Align(
        alignment: FractionalOffset.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40, right: 40),
          child: MaterialButton(
              onPressed: () {}, child: const Text("Next", style: TextStyle(fontSize: 18))),
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
                    "Great! Now, how much do you want to spend?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: SvgPicture.asset("images/undraw_invoice.svg", width: 300)),
                  const SizedBox(
                    height: 40,
                  ),
                  RangeSlider(
                    values: RangeValues(bottom, top),
                    onChanged: (value) => setState(() {
                      bottom = value.start;
                      top = value.end;
                    }),
                    min: 1,
                    max: 50,
                    divisions: 5,
                    labels:
                        RangeLabels("£${bottom.toInt()}", top == 50 ? "£50+" : "£${top.toInt()}"),
                  )
                ],
              )))
    ]);
  }
}
