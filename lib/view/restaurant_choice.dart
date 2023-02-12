import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hangryclient/api/hangry_api.dart';
import 'package:hangryclient/helpers.dart';
import 'package:hangryclient/model/place.dart';
import 'package:hangryclient/provider/session_provider.dart';
import 'package:hangryclient/view/restaurant.dart';
import 'package:provider/provider.dart';

class RestaurantChoicePage extends StatefulWidget {
  const RestaurantChoicePage({super.key, required this.choices});

  final List<Place> choices;

  @override
  createState() => _RestaurantChoicePageState();
}

class _RestaurantChoicePageState extends State<RestaurantChoicePage> {
  List<Place>? choices;

  @override
  initState() {
    super.initState();
    choices = widget.choices;
  }

  submitChoice(String uuid, String code, String placeId) async {
    final api = HangryApi();
    api.postChoice(uuid, code, placeId);
    setState(() {
      choices = null;
    });
    print("Cleared: $choices");
    final newChoices = await api.getChoices(uuid, code);
    setState(() {
      choices = newChoices;
    });
  }

  @override
  Widget build(BuildContext context) {
    return choices == null
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
                          place: Place(
                              id: "dsfsdflkdsj",
                              name: "Restaurant 1",
                              description: "THis is an imaginary restaurant",
                              photo: TEST_PLACE.photo),
                          onSelect: () async => await submitChoice(
                              session.getUUID(), session.getCode(), choices![0].id),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RestaurantCard(
                          place: Place(
                              id: "dsfsdflkdsj",
                              name: "Restaurant 2",
                              description: "THis is an imaginary restaurant",
                              photo: TEST_PLACE.photo),
                          onSelect: () =>
                              submitChoice(session.getUUID(), session.getCode(), choices![1].id),
                        ),
                      ],
                    )));
  }
}
