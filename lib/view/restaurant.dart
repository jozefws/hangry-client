import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hangryclient/helpers.dart';
import 'package:hangryclient/model/place.dart';
import 'package:tuple/tuple.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hangryclient/model/place.dart';

class RestaurantCard extends StatelessWidget {
  // const RestaurantCard({super.key, required this.place});
  const RestaurantCard({super.key, required this.place, required this.onSelect});

  final Place place;
  final void Function() onSelect;

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
            onTap: onSelect,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Ink.image(
                      image: Image.memory(base64Decode(place.photos![0])).image,
                      fit: BoxFit.cover,
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      place.name,
                    ),
                    Text(place.description ?? "")
                  ])),
            ])));
  }
}

class RestaurantResultCard extends StatelessWidget {
  // const RestaurantCard({super.key, required this.place});
  RestaurantResultCard({super.key, required this.onSelect, required this.place});

  final void Function() onSelect;
  final Place place;
  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
            onTap: onSelect,
            child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: Ink.image(
                          image: Image.memory(base64Decode(place.photos![0])).image,
                          fit: BoxFit.cover,
                        ),
                      )),
                  Stack(children: [
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Wrap(children: [
                              Text(
                                place.name,
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              Text("(${place.types[0].capitalize()})")
                            ]),
                            Text(
                              place.match! > 1.0
                                  ? "100% Match"
                                  : "${(place.match! * 100).toInt()}% Match",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            )
                          ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(child: Text(place.description ?? "")),
                                Text("${place.googleRating} Stars")
                              ])
                        ]))),
                  ])
                ])));
  }
}
