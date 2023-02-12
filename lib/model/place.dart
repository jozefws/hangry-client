import 'package:tuple/tuple.dart';

class Place {
  const Place({
      required this.id,
      required this.name,
      required this.description,
      required this.photos,
      required this.healthRating,
      required this.googleRating,
      required this.location,
      required this.wheelchairAccessible,
      required this.priceRange,
      required this.matchScore
  });

  final String id;
  final String name;
  final String description;
  final List<String> photos;
  final String healthRating;
  final String googleRating;
  final Tuple2<double, double> location;
  final bool wheelchairAccessible;
  final String priceRange;
  final double matchScore;

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        photos: json['photo'],
        healthRating: json['healthRating'],
        googleRating: json['googleRating'],
        location: Tuple2(json['location'][0], json['location'][1]),
        wheelchairAccessible: json['wheelchairAccessible'],
        priceRange: json['priceRange'],
        matchScore: json['matchScore']
    );
  }
}
