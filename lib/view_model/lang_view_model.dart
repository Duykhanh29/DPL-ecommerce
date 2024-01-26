import 'package:dpl_ecommerce/app_config.dart';
import 'package:dpl_ecommerce/models/language.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider with ChangeNotifier {
  Locale? _locale;
  Language? language;
  Locale get locale {
    if (_prefs == null) {
      return _locale = Locale(AppConfig.defaultLanguage, '');
    }
    String savedLanguage =
        _prefs!.getString('app_language') ?? AppConfig.defaultLanguage;

    return _locale = Locale(savedLanguage, '');
  }

  SharedPreferences? _prefs;

  LocaleProvider() {
    _loadPrefs();
  }
  void _loadPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    notifyListeners();
  }

  Future<void> setLocale(String code) async {
    await _prefs!.setString('app_language', code);
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
        name: "English",
        code: "en"),
  ];
}
