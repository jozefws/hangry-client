import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hangryclient/model/place.dart';
import 'package:hangryclient/view/food_categories_page.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';

class HangryApi {
  final client = http.Client();

  Future<bool?> postPreferences(
    List<Category> categories,
    bool vegetarian,
    bool alcohol,
    bool wheelchair,
    double minPrice,
    double maxPrice,
    String uuid,
    String code,
  ) async {
    print("UUID: $uuid");
    print(jsonEncode({
      "categories": categories.map((e) => e.toPrettyString().toUpperCase()).toList(),
      "vegetarian": vegetarian,
      "alcohol": alcohol,
      "wheelchair": wheelchair,
      "minPrice": minPrice.toInt(),
      "maxPrice": maxPrice.toInt(),
    }));
    final response = await client.post(Uri.http("${dotenv.get("url")}", "$code/preferences"),
        headers: {"Authorization": uuid, HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode({
          "categories": categories.map((e) => e.toPrettyString().toUpperCase()).toList(),
          "vegetarian": vegetarian,
          "alcohol": alcohol,
          "wheelchair": wheelchair,
          "minPrice": minPrice.toInt(),
          "maxPrice": maxPrice.toInt(),
        }));

    print(response.statusCode);
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }

  Future<List<Place>?> getChoices(String uuid, String code) async {
    final response = await client.get(Uri.http("${dotenv.get("url")}", "$code/choices"),
        headers: {"Authorization": uuid, HttpHeaders.contentTypeHeader: "application/json"});

    print(response.statusCode);
    // print(jsonDecode(response.body));
    if (response.statusCode != 200) {
      return null;
    }
    print(response.body);
    print((jsonDecode(response.body)["choices"] as List).toString());
    final places =
        (jsonDecode(response.body)["choices"] as List).map((e) => Place.fromJson(e)).toList();
    print(places);
    return places;
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  Future<bool?> postChoice(String uuid, String code, String placeId) async {
    final response = await client.post(Uri.http("${dotenv.get("url")}", "$code/choice"),
        headers: {
          HttpHeaders.authorizationHeader: uuid,
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: json.encode({"choice": placeId}));

    if (response.statusCode != 200) {
      return false;
    }

    return true;
  }

  Future<String?> createLobby(String type, double lat, double lng, int radius) async {
    final response = await client.post(Uri.http("${dotenv.get("url")}", "create"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: json.encode({
          "type": type,
          "location": {
            "lat": lat,
            "lng": lng,
          },
          "radius": radius
        }));

    print("Created lobby with status: ${response.statusCode}");
    if (response.statusCode != 200) {
      return null;
    }

    return json.decode(response.body)["code"];
  }

  Future<List<dynamic>?> joinLobby(String code, String photo) async {
    final response = await client.post(Uri.http("${dotenv.get("url")}", "$code/join"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: json.encode({"photo": photo}));

    print("Joined lobby with status: ${response.statusCode}");
    if (response.statusCode != 200) {
      return null;
    }

    final body = json.decode(response.body);

    print("Reponse: $body");
    return [body["admin"], body["token"]];
  }

  Future<bool?> start(String code, String uuid) async {
    final response = await client.put(Uri.http("${dotenv.get("url")}", "$code/start"),
        headers: {HttpHeaders.authorizationHeader: uuid});

    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }

  Future<bool?> end(String code, String uuid) async {
    final response = await client.post(Uri.http("${dotenv.get("url")}$code/end"),
        headers: {HttpHeaders.authorizationHeader: uuid});

    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }

  Future<List<Place>?> getResults(String code, String uuid) async {
    final response = await client.post(Uri.http("${dotenv.get("url")}$code/results"),
        headers: {HttpHeaders.authorizationHeader: uuid});

    if (response.statusCode != 200) {
      return null;
    }
    return ((jsonDecode(response.body)["choices"]) as List).map((e) => Place.fromJson(e)).toList();
  }
}
