import 'package:dpl_ecommerce/models/ordering_product.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:flutter/material.dart';

class DeliveryStatusHelper {
  static String translateDeliveryStatus(
      BuildContext context, DeliverStatus status) {
    switch (status) {
      case DeliverStatus.processing:
        return LangText(context: context).getLocal()!.processing;
      case DeliverStatus.confirmed:
        return LangText(context: context).getLocal()!.confirmed_ucf;
      case DeliverStatus.delivering:
        return LangText(context: context).getLocal()!.delivering;
      case DeliverStatus.delivered:
        return LangText(context: context).getLocal()!.delivered_ucf;
      default:
        return status.toString();
    }
  }
}
