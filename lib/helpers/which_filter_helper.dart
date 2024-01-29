import 'package:dpl_ecommerce/models/order_shop.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/views/consumer/screens/search_page.dart';
import 'package:flutter/material.dart';

class WhichFilterHelper {
  static String translateWhichHelper(BuildContext context, WhichFilter value) {
    switch (value) {
      case WhichFilter.product:
        return LangText(context: context).getLocal()!.product_ucf;
      case WhichFilter.shop:
        return LangText(context: context).getLocal()!.shop_ucf;
    }
  }
}
