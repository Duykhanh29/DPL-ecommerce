import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LangText {
  BuildContext? context;

  LangText({this.context});

  AppLocalizations? getLocal() {
    return AppLocalizations.of(context!);
  }
}
