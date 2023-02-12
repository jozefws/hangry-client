import 'package:flutter/material.dart';

/// The toggle button
class TogglerButton extends StatefulWidget {
  // Props
  final List<String> items;
  final Function() toggleStateFunction;
  final num state;
  final Color backgroundColour;
  final Color selectedColour;
  final Color textColour;
  final num height;
  final num width;

  const TogglerButton(
      {Key? key,
      required this.items,
      required this.toggleStateFunction,
      required this.state,
      this.backgroundColour = const Color(0x44000000),
      this.selectedColour = const Color(0x77000000),
      this.textColour = Colors.white,
      this.height = 40,
      this.width = 0})
      : super(key: key);

  @override
  _TogglerButtonState createState() => _TogglerButtonState();
}

class _TogglerButtonState extends State<TogglerButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
          customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          onTap: widget.toggleStateFunction,
          child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: widget.backgroundColour,
                borderRadius: const BorderRadius.all(Radius.circular(100)),
              ),
              height: widget.height.toDouble(),
              width: widget.width == 0
                  ? MediaQuery.of(context).size.width.toDouble()
                  : widget.width.toDouble(),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedAlign(
                    alignment: Alignment(2 * widget.state / (widget.items.length - 1) - 1, 0),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.fastOutSlowIn,
                    child: Container(
                      height: 40,
                      width:
                          (widget.width == 0 ? MediaQuery.of(context).size.width : widget.width) /
                              widget.items.length,
                      decoration: BoxDecoration(
                          color: widget.selectedColour,
                          borderRadius: const BorderRadius.all(Radius.circular(100))),
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    Text(widget.items[0],
                        style: TextStyle(
                            color: widget.state == 0
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onPrimaryContainer)),
                    Text(widget.items[1],
                        style: TextStyle(
                            color: widget.state == 1
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onPrimaryContainer)),
                  ])
                  // widget.items
                  //     .map((e) => Text(e, style: TextStyle(color: widget.textColour)))
                  //     .toList()),
                ],
              ))),
    );
  }
}
