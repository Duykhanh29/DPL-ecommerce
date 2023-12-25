import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/models/language.dart';
import 'package:dpl_ecommerce/repositories/language_repo.dart';
import 'package:dpl_ecommerce/view_model/consumer/language_view_model.dart';
import 'package:dpl_ecommerce/view_model/lang_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguagePage extends StatelessWidget {
  LanguagePage({super.key});
  // List<Language> list = LanguageRepo().list;
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageViewModel>(context);
    final listLanguage = languageProvider.list;
    return Scaffold(
      appBar: CustomAppBar(
              centerTitle: true,
              context: context,
              title: AppLocalizations.of(context)!.change_language_ucf)
          .show(),
      body: Padding(
          padding: EdgeInsets.all(5.h),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return LanguageItem(
                language: listLanguage[index],
                index: index,
              );
            },
            itemCount: listLanguage.length,
          )),
    );
  }
}

class LanguageItem extends StatelessWidget {
  LanguageItem({super.key, required this.language, required this.index});
  Language language;
  int index;
  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context);
    final languageProvider = Provider.of<LanguageViewModel>(context);
    return ListTile(
      onTap: () {
        languageProvider.changeLanguage(index);
        locale.setLocale(language.code!);
      },
      leading: Container(
        height: 60.h,
        width: 60.h,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 7.h),
        child: Image.asset(language.image!),
      ),
      title: Text(language.name!),
      trailing: Consumer<LanguageViewModel>(
        builder: (context, value, child) {
          return value.currentLanguage.id == language.id
              ? buildCheckContainer(true)
              : buildCheckContainer(false);
        },
      ),
    );
  }

  Widget buildCheckContainer(bool check) {
    return check
        ? Container(
            height: 16.h,
            width: 16.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r), color: Colors.green),
            child: Padding(
              padding: EdgeInsets.all(3.h),
              child: Icon(Icons.check, color: Colors.white, size: 10.h),
            ),
          )
        : const SizedBox();
  }
}
