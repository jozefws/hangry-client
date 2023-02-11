class Place {
  const Place(
      {required this.id, required this.name, required this.description, required this.photo});

  final String id;
  final String name;
  final String description;
  final String photo;

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
        id: json['id'], name: json['name'], description: json['description'], photo: json['photo']);
  }
}
