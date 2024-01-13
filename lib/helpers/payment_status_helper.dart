import 'package:dpl_ecommerce/models/order_shop.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:flutter/material.dart';

class PaymentStatusHelper {
  static String translatePaymentStatus(
      BuildContext context, PaymentStatus status) {
    switch (status) {
      case PaymentStatus.paid:
        return LangText(context: context).getLocal()!.paid;
      case PaymentStatus.unpaid:
        return LangText(context: context).getLocal()!.unpaid;
    }
  }
}
