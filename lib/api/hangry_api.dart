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
    final response = await client.post(Uri.http("${dotenv.get("url")}$code/join"),
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
    final response = await client
        .get(Uri.http("${dotenv.get("url")}$code/choices"), headers: {"Authorization": uuid});

    if (response.statusCode != 200) {
      return null;
    }

    return json.decode(response.body)["choices"];
  }
}
