import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/models/voucher_for_user.dart';
import 'package:dpl_ecommerce/repositories/voucher_for_user_repo.dart';
import 'package:dpl_ecommerce/repositories/voucher_repo.dart';
import 'package:dpl_ecommerce/utils/common/common_methods.dart';
import 'package:dpl_ecommerce/view_model/consumer/voucher_for_user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/voucher_widgets/user_voucher_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListVoucher extends StatelessWidget {
  UserListVoucher({super.key});
  List<Voucher> listActualVoucher = [];
  List<Voucher> listVoucher = VoucherRepo().list;
  void getListVoucher(VoucherForUser voucher) {
    for (var element in voucher.vouchers!) {
      if (CommondMethods.getVoucherFromID(listVoucher, element) != null) {
        Voucher voucher =
            CommondMethods.getVoucherFromID(listVoucher, element)!;
        listActualVoucher.add(voucher);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final voucherForUsreProvider =
        Provider.of<VoucherForUserViewModel>(context);
    getListVoucher(voucherForUsreProvider.voucherForUser);

    return Scaffold(
      appBar: AppBar(
        leading: CustomArrayBackWidget(),
        title: Text("My vouchers"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                  bottom: 10, right: 20, left: 20, top: 10),
              child: UserVoucherItem(voucher: listActualVoucher[index]),
            );
          },
          itemCount: listActualVoucher.length,
        ),
      ),
    );
  }
}
