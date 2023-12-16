import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/models/voucher_for_user.dart';
import 'package:dpl_ecommerce/repositories/voucher_for_user_repo.dart';
import 'package:dpl_ecommerce/repositories/voucher_repo.dart';
import 'package:dpl_ecommerce/utils/common/common_methods.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/view_model/auth_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/voucher_for_user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/voucher_widgets/user_voucher_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListVoucher extends StatefulWidget {
  UserListVoucher({super.key});

  @override
  State<UserListVoucher> createState() => _UserListVoucherState();
}

class _UserListVoucherState extends State<UserListVoucher> {
  List<Voucher>? listVoucher = [];

  VoucherRepo voucherRepo = VoucherRepo();

  VoucherForUserRepo voucherForUserRepo = VoucherForUserRepo();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getListVoucher();
  }

  Future<List<Voucher>?> getListVoucher() async {
    final result = await voucherRepo.getListVoucher();
    setState(() {
      listVoucher = result;
    });
  }

  Future<void> refresh() async {
    reset();
    await getListVoucher();
  }

  void reset() {
    setState(() {
      listVoucher = [];
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    voucherRepo.dispose();
    voucherForUserRepo.dispose();
  }

  //  List<Voucher> listVoucher = VoucherRepo().list;
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    // final voucherForUsreProvider =
    //     Provider.of<VoucherForUserViewModel>(context);
    // getListVoucher(voucherForUsreProvider.voucherForUser!);

    return Scaffold(
      appBar: AppBar(
        leading: CustomArrayBackWidget(),
        title: Text("My vouchers"),
      ),
      body:
          //  RefreshIndicator(
          //   onRefresh: () async {
          //     await refresh();
          //   },
          //   child:
          Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
        child: StreamBuilder(
          stream: voucherForUserRepo
              .getVoucherForUser(authViewModel.currentUser!.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.data != null) {
                final voucherForUser = snapshot.data;
                final listVoucherForUser = CommondMethods.getListVoucherForUser(
                    voucherForUser!, listVoucher!);
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, right: 20, left: 20, top: 10),
                      child:
                          UserVoucherItem(voucher: listVoucherForUser[index]),
                    );
                  },
                  itemCount: listVoucherForUser!.length,
                );
              } else {
                return Center(
                  child: Image.asset(ImageData.imageNotFound),
                );
              }
            }
          },
        ),
      ),
      // ),
    );
  }
}
