import 'package:flutter/cupertino.dart';

class LangConfig {
  static const langList = ['vi', 'en'];
  List<Locale> localList = [];
  List<Locale> supportedLocales() {
    langList.forEach((lang) {
      var local = Locale(lang, '');
      localList.add(local);
    });

    return localList;
  }
}
