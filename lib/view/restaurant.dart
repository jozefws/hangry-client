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
    return Expanded(
        child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: InkWell(
                onTap: onSelect,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(
                          place.name,
                        ),
                        Text(place.description ?? "")
                      ])),
                ]))));
  }
}
