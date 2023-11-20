import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/models/language.dart';
import 'package:dpl_ecommerce/repositories/language_repo.dart';
import 'package:dpl_ecommerce/view_model/consumer/language_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatelessWidget {
  LanguagePage({super.key});
  // List<Language> list = LanguageRepo().list;
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageViewModel>(context);
    final listLanguage = languageProvider.list;
    return Scaffold(
      appBar: AppBar(
        leading: CustomArrayBackWidget(),
      ),
      body: Padding(
          padding: EdgeInsets.all(5),
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
    final languageProvider = Provider.of<LanguageViewModel>(context);
    return ListTile(
      onTap: () {
        languageProvider.changeLanguage(index);
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
            height: 16,
            width: 16,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0), color: Colors.green),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Icon(Icons.check, color: Colors.white, size: 10),
            ),
          )
        : SizedBox();
  }
}
