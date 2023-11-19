import 'package:dpl_ecommerce/models/language.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';

class LanguageRepo {
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
}
