import 'package:flutter/material.dart';

class SessionProvider extends ChangeNotifier {
  String? uuid;
  String? code;

  SessionProvider();

  setUUID(String _uuid) {
    uuid = _uuid;
    notifyListeners();
  }

  String getUUID() {
    return uuid!;
  }

  setCode(String _code) {
    code = _code;
    notifyListeners();
  }

  String getCode() {
    return code!;
  }
}
