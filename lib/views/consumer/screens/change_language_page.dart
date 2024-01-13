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
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePage extends StatefulWidget {
  LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  int currentIndex = 0;

  Future<void> fetchData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? laguageCode = preferences.getString('app_language');
    if (laguageCode == null || laguageCode == 'en') {
      currentIndex = 0;
    } else {
      currentIndex = 1;
    }
    setState(() {});
  }

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
                  currentIndex: currentIndex);
            },
            itemCount: listLanguage.length,
          )),
    );
  }
}

class LanguageItem extends StatelessWidget {
  LanguageItem(
      {super.key,
      required this.language,
      required this.index,
      required this.currentIndex});
  Language language;
  int index;
  int currentIndex;
  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context);
    final languageProvider = Provider.of<LanguageViewModel>(context);
    return ListTile(
      onTap: () async {
        languageProvider.changeLanguage(index);
        await locale.setLocale(language.code!);
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
          return currentIndex == index
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
