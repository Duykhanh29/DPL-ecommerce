import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/views/seller/screens/voucher/add_coupon.dart';
import 'package:dpl_ecommerce/views/seller/screens/voucher/display_coupon.dart';
import 'package:flutter/material.dart';

class VoucherApp extends StatefulWidget {
  const VoucherApp({super.key});

  @override
  State<VoucherApp> createState() => __VoucherAppState();
}

class __VoucherAppState extends State<VoucherApp> {
  List<Voucher> vouchers = [
    // Voucher(
    //   id: DateTime.now().millisecondsSinceEpoch.toString(),
    //   name: 'Voucher 1',

    // ),

    // Add more products if needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Voucher'),
      ),
      body: DisplayCoupon(
        vouchers: vouchers,
        onVoucherDeleted: _deleteVoucher,
        onVoucherUpdated: _updateVoucher,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddVocherScreen(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToAddVocherScreen(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCoupon(
          vouchers: vouchers,
          onVoucherAdded: _addVoucher,
        ),
      ),
    );
  }

  void _addVoucher(Voucher newVoucher) {
    setState(() {
      vouchers.add(newVoucher);
    });
  }

  void _updateVoucher(Voucher updatedVoucher) {
    setState(() {
      int index =
          vouchers.indexWhere((voucher) => voucher.id == updatedVoucher.id);
      if (index != -1) {
        vouchers[index] = updatedVoucher;
      }
    });
  }

  void _deleteVoucher(String voucherId) {
    setState(() {
      vouchers.removeWhere((voucher) => voucher.id == voucherId);
    });
  }
}
