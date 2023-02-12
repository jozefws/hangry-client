import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hangryclient/model/place.dart';
import 'package:tuple/tuple.dart';

class RestaurantCard extends StatelessWidget {
  // const RestaurantCard({super.key, required this.place});
  RestaurantCard({super.key, required this.onSelect});

  final Place place;
  final void Function() onSelect;
  final Place place = Place(id: "A", name: "A", description: "A", photos: [""], healthRating: "A", googleRating: "A", location: Tuple2(0,0), wheelchairAccessible: true, priceRange: '0', matchScore: 0);
  
  @override
  Widget build(BuildContext context) {
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
                          image: Image.memory(base64Decode(place.photos[0])).image,
                          fit: BoxFit.cover,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(
                          place.name,
                        ),
                        Text(place.description)
                      ])),
                ]
                )
            )
        )
    );
  }
}
