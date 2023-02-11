import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hangryclient/model/place.dart';
import 'package:hangryclient/view/food_categories_page.dart';
import 'package:http/http.dart' as http;

class HangryApi {
  final client = http.Client();

  Future<String?> postPreferences(
    List<Category> categories,
    bool vegetarian,
    bool alcohol,
    double minPrice,
    double maxPrice,
    String uuid,
    String code,
  ) async {
    final response = await client.post(Uri.http("${dotenv.get("url")}$code/preferences"),
        body: json.encode({
          "code": code,
          "categories": categories.map((e) => e.toPrettyString()),
          "vegetarian": vegetarian,
          "alcohol": alcohol,
          "minPrice": minPrice.toInt(),
          "maxPrice": maxPrice.toInt(),
        }));

    if (response.statusCode != 200) {
      return null;
    }

    return json.decode(response.body)["token"];
  }

  Future<List<Place>?> getChoices(String uuid, String code) async {
    final response = await client.get(Uri.http("${dotenv.get("url")}$code/choices"),
        headers: {HttpHeaders.authorizationHeader: uuid});

    if (response.statusCode != 200) {
      return null;
    }

    return json.decode(response.body)["choices"];
  }

  Future<bool?> postChoice(String uuid, String code, String placeId) async {
    final response = await client.post(Uri.http("${dotenv.get("url")}$code/choice"),
        headers: {HttpHeaders.authorizationHeader: uuid}, body: json.encode({"choice": placeId}));

    if (response.statusCode != 200) {
      return false;
    }

    return true;
  }

  Future<String?> createLobby(String type, double lat, double lng, int radius) async {
    final response = await client.post(Uri.http("${dotenv.get("url")}create"),
        body: json.encode({
          "type": type,
          "location": {
            "lat": lat,
            "lng": lng,
          },
          "radius": radius
        }));

    if (response.statusCode != 200) {
      return null;
    }

    return json.decode(response.body)["code"];
  }

  Future<List<dynamic>?> joinLobby(String code, String photo) async {
    final response = await client.post(Uri.http("${dotenv.get("url")}$code/join"),
        body: json.encode({"photo": photo}));

    if (response.statusCode != 200) {
      return null;
    }

    final body = json.decode(response.body);
    return [body["admin"], body["token"]];
  }

  Future<bool?> start(String code, String uuid) async {
    final response = await client.put(Uri.http("${dotenv.get("url")}$code/start"),
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
