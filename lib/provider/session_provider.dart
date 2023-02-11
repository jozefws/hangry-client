import 'package:flutter/material.dart';
import 'package:hangryclient/api/hangry_api.dart';
import 'package:hangryclient/view/food_categories_page.dart';

class SessionProvider extends ChangeNotifier {
  String? uuid;
  String? code;

  List<Category> categories = [];
  List<Restrictions> restrictions = [];
  double minPrice = 10;
  double maxPrice = 30;

  bool admin = false;

  SessionProvider();

  setUUID(String _uuid, bool isAdmin) {
    uuid = _uuid;
    admin = isAdmin;
    notifyListeners();
  }

  String getUUID() {
    return uuid == null ? "TEST" : uuid!;
  }

  setCode(String _code) {
    code = _code;
    notifyListeners();
  }

  String getCode() {
    return code == null ? "TEST" : code!;
  }

  setCategories(List<Category> cats, List<Restrictions> res) {
    categories = cats;
    restrictions = res;
    notifyListeners();
  }

  setPrice(double min, double max) {
    minPrice = min;
    maxPrice = max;
    notifyListeners();
  }

  submitPreferences() {
    HangryApi().postPreferences(
      categories,
      restrictions.contains(Restrictions.vegetarian),
      restrictions.contains(Restrictions.alcohol),
      minPrice,
      maxPrice,
      getUUID(),
      getCode(),
    );
  }
}
