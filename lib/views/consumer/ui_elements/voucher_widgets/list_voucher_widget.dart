import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/voucher_widgets/voucher_item_widget.dart';
import 'package:flutter/material.dart';

class ListVoucherWidget extends StatelessWidget {
  ListVoucherWidget({super.key, required this.list});
  List<Voucher> list;
  @override
  Widget build(BuildContext context) {
    return _buildShopVoucher(context, list);
  }

  Widget _buildShopVoucher(BuildContext context, List<Voucher> list) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 16.h),
      padding: EdgeInsets.symmetric(vertical: 5),
      height: MediaQuery.of(context).size.height * 0.12,
      width: double.infinity,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return VoucherItem(voucher: list[index]);
        },
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
      ),
    );
  }
}
