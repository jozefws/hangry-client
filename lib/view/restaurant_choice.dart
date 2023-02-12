import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hangryclient/api/hangry_api.dart';
import 'package:hangryclient/helpers.dart';
import 'package:hangryclient/model/place.dart';
import 'package:hangryclient/provider/session_provider.dart';
import 'package:hangryclient/view/restaurant.dart';
import 'package:hangryclient/view/waiting_page2.dart';
import 'package:provider/provider.dart';

class RestaurantChoicePage extends StatefulWidget {
  const RestaurantChoicePage(
      {super.key, required this.uuid, required this.code, required this.onNext});
  final String uuid;
  final String code;

  final void Function(Widget?) onNext;

  @override
  createState() => _RestaurantChoicePageState();
}

class _RestaurantChoicePageState extends State<RestaurantChoicePage> {
  List<Place>? choices;

  @override
  initState() {
    super.initState();
  }

  getChoices() {
    while (choices == null || choices!.isEmpty) {
      Future.delayed(const Duration(seconds: 2), () async {
        final newChoices = await HangryApi().getChoices(widget.uuid, widget.code);

        if (newChoices != null && newChoices.isNotEmpty) {
          setState(() {
            choices = newChoices;
          });
        }
      });
    }
  }

  submitChoice(String uuid, String code, String placeId) async {
    final api = HangryApi();
    api.postChoice(uuid, code, placeId);
    setState(() {
      choices = [];
    });
    final newChoices = await api.getChoices(uuid, code);
    setState(() {
      choices = newChoices;
    });
    if (choices!.isEmpty) {
      widget.onNext(WaitingPage2(onNext: Results));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: HangryApi().getChoices(widget.uuid, widget.code),
        builder: (context, snapshot) => !snapshot.hasData
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
                child: Consumer<SessionProvider>(
                    builder: (context, session, child) => Column(
                          children: [
                            const Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  "Which would you prefer?",
                                  style: TextStyle(fontSize: 20),
                                )),
                            RestaurantCard(
                              place: snapshot.data![0],
                              onSelect: () async => await submitChoice(
                                  session.getUUID(), session.getCode(), snapshot.data![0].id),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            RestaurantCard(
                              place: snapshot.data![1],
                              onSelect: () => submitChoice(
                                  session.getUUID(), session.getCode(), snapshot.data![1].id),
                            ),
                          ],
                        ))));
  }
}
