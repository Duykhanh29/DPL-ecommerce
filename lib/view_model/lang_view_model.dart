import 'package:dpl_ecommerce/app_config.dart';
import 'package:dpl_ecommerce/models/language.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  Locale? _locale;
  Language? language;
  Locale get locale {
    return _locale = Locale(AppConfig.defaultLanguage, '');
  }

  void setLocale(String code) {
    _locale = Locale(code, '');
    notifyListeners();
  }

  List<Language> list = [
    Language(
        id: "languageID01",
        image: ImageData.vietnamFlag,
        is_default: true,
        name: "Vietnamese",
        code: "vi"),
    Language(
        id: "languageID02",
        image: ImageData.ukFlag,
        is_default: false,
        name: "english",
        code: "en"),
  ];
}
