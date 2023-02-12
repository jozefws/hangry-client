import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';

class Place {
  Place({
    required this.id,
    required this.name,
    required this.description,
    required this.photos,
    required this.healthRating,
    required this.googleRating,
    required this.location,
    required this.match,
    required this.wheelchairAccessible,
    required this.priceRange,
    required this.types,
  });

  final String id;
  final String name;
  final String? description;
  final List<String>? photos;
  double? match;
  final String? healthRating;
  final double? googleRating;
  final List<String> types;
  final Tuple2<double, double>? location;
  final bool? wheelchairAccessible;
  final String? priceRange;

  factory Place.fromJson(Map<String, dynamic> json) {
    final list = json['photos'] as List;
    // list.forEach((element) => print(element.runtimeType));

    final List<String> _photos = [];
    list.forEach((element) => _photos.add(element.toString()));

    final typeList = json['types'] as List;

    final List<String> _types = [];
    typeList.forEach((element) => _types.add(element.toString()));

    return Place(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        photos: _photos,
        // photos: [],
        healthRating: json['healthRating'],
        googleRating: json['rating'],
        // location: Tuple2(json['location'][0], json['location'][1]),
        // location: Tuple2(json['location'][0], json['location'][1]),
        types: _types,
        location: null,
        wheelchairAccessible: json['wheelchair'],
        match: null,
        priceRange: json['priceRange']);
  }
}
