import 'package:dpl_ecommerce/models/language.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:flutter/cupertino.dart';

class LanguageViewModel extends ChangeNotifier {
  List<Language> list = [
    Language(
        id: "languageID01",
        image: ImageData.vietnamFlag,
        is_default: true,
        name: "Vietnamese"),
    Language(
        id: "languageID02",
        image: ImageData.ukFlag,
        is_default: false,
        name: "english"),
  ];
  Language currentLanguage = Language(
      id: "languageID01",
      image: ImageData.vietnamFlag,
      is_default: true,
      name: "Vietnamese");
  void changeLanguage(int index) {
    currentLanguage = list[index];
    notifyListeners();
  }
}
