import 'dart:convert';

import 'package:tuple/tuple.dart';

class Place {
  const Place(
      {required this.id,
      required this.name,
      required this.description,
      required this.photos,
      required this.healthRating,
      required this.googleRating,
      required this.location,
      required this.match,
      required this.wheelchairAccessible,
      required this.priceRange});

  final String id;
  final String name;
  final String? description;
  final List<String>? photos;
  final double? match;
  final String? healthRating;
  final String? googleRating;
  final Tuple2<double, double>? location;
  final bool? wheelchairAccessible;
  final String? priceRange;

  factory Place.fromJson(Map<String, dynamic> json) {
    final list = json['photos'] as List;
    // list.forEach((element) => print(element.runtimeType));

    final List<String> _photos = [];
    list.forEach((element) => _photos.add(element.toString()));

    return Place(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        photos: _photos,
        healthRating: json['healthRating'],
        googleRating: json['googleRating'],
        // location: Tuple2(json['location'][0], json['location'][1]),
        location: null,
        wheelchairAccessible: json['wheelchair'],
        match: json['match'],
        priceRange: json['priceRange']);
  }
}
