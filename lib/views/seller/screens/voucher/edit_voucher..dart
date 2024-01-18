import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/repositories/voucher_repo.dart';
import 'package:dpl_ecommerce/utils/common/common_methods.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/seller/shop_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/admin/screens/voucher/voucher_admin.dart';
import 'package:dpl_ecommerce/views/seller/screens/voucher/voucher_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EditVoucher extends StatefulWidget {
  final Voucher voucher;
  // final Function(Voucher) onVoucherUpdated;

  EditVoucher({
    required this.voucher,
    // required this.onVoucherUpdated,
    // required List vouchers
  });

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<EditVoucher> {
  //TextEditingController _availableQuantityController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  TextEditingController discountValue = TextEditingController();
  VoucherRepo voucherRepo = VoucherRepo();
  ProductRepo productRepo =
      ProductRepo(); // String tempShopID = "PkHVNq0E1ZnTUyRnqG4O";
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    _nameController.text = widget.voucher.name.toString();
    startDate = widget.voucher.releasedDate;
    expDate = widget.voucher.expDate;

    if (widget.voucher.productID != null) {
      // dropdownValue = "Product";
      selectedProduct =
          await productRepo.getProductByID(widget.voucher.productID!);
      // CommondMethods.getProductByID(list!, widget.voucher.productID!);
    } else {
      // dropdownValue = "Shop";
    }
    if (widget.voucher.discountAmount != null) {
      discountAmount = widget.voucher.discountAmount;
      discountValue.text = discountAmount.toString();
      // discountType = "Amount";
    } else {
      discountPercent = widget.voucher.discountPercent;
      discountValue.text = discountPercent.toString();
      // discountType = "Percent";
    }
    setState(() {});
  }

  // String? dropdownValue;
  String? discountType;
  int? discountAmount;
  int? discountPercent;
  Timestamp? startDate;
  Timestamp? expDate;
// DateTimeRange dataRange = DateTimeRange(
//     start: DateTime.now(),
//     end: DateTime.now().add(const Duration(days: 30)),
//   );

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // String? dropdownValue = "Product";
  // String dropdownValue1 = "Percent";
  bool isDefaultAddress = false;

  Product? selectedProduct;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    final shopProvider = Provider.of<ShopViewModel>(context);
    final user = userProvider.currentUser;
    final shop = shopProvider.shop;
    //final start = dataRange.start;
    //final end = dataRange.end;
    ;
    String typeValue;
    String discountTypeValue;
    // if (dropdownValue == "Product") {
    //   typeValue = LangText(context: context).getLocal()!.product_ucf;
    // } else {
    //   typeValue = LangText(context: context).getLocal()!.shop_ucf;
    // }
    if (discountType == "Percent") {
      discountTypeValue = LangText(context: context).getLocal()!.discount_ucf;
    } else {
      discountTypeValue = LangText(context: context).getLocal()!.percent;
    }

    return Scaffold(
      appBar: CustomAppBar(
              centerTitle: true,
              context: context,
              title: LangText(context: context).getLocal()!.edit_voucher)
          .show(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LangText(context: context).getLocal()!.voucher_name),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    filled: true,
                    hoverColor: Color.fromARGB(110, 218, 218, 218),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return LangText(context: context)
                          .getLocal()!
                          .please_enter_number;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _nameController;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(LangText(context: context).getLocal()!.product_ucf),
                // DropdownButton(
                //   value: typeValue ?? "",
                //   onChanged: ((String? newvalue) {
                //     setState(() {
                //       // dropdownValue = newvalue!;
                //     });
                //   }),
                //   items: [
                //     DropdownMenuItem(
                //       value: typeValue ?? "",
                //       child: Text(typeValue ?? ""),
                //     ),
                //   ],
                //   isExpanded: true,
                // ),
                // if (dropdownValue == "Product")
                //   Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: <Widget>[
                //       Text(LangText(context: context)
                //           .getLocal()!
                //           .select_category),
                selectedProduct != null
                    ? DropdownButton<Product>(
                        value: selectedProduct,
                        isExpanded: true,
                        items: [
                          DropdownMenuItem<Product>(
                            value: selectedProduct,
                            child: Text(selectedProduct != null
                                ? selectedProduct!.name!
                                : ""),
                          )
                        ],
                        onChanged: (newValue) {
                          setState(() {
                            // selectedProduct = newValue!;
                            // Reset selected product when category changes
                          });
                        },
                      )
                    : Container(),
                //       // Hiển thị danh sách sản phẩm ở đây
                //       // Ví dụ: ListView.builder(...)
                //     ],
                //   ),
                // Hiển thị dòng "hello" khi chọn "Shop"
                // if (dropdownValue == "Shop") Text("hello"),

                DropdownButton(
                  value: discountTypeValue,
                  onChanged: ((String? newvalue) {
                    setState(() {
                      //dropdownValue1 = newvalue!;
                    });
                  }),
                  items: [
                    DropdownMenuItem(
                      value: discountTypeValue,
                      child: Text(discountTypeValue),
                    ),
                  ],
                  isExpanded: true,
                ),
                //if (dropdownValue1 == "Percent")

                TextFormField(
                  controller: discountValue,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return LangText(context: context)
                          .getLocal()!
                          .please_enter_number;
                    }
                    if (discountPercent != null) {
                      if (int.tryParse(value) == null ||
                          int.parse(value) <= 0 ||
                          int.parse(value) >= 100) {
                        return LangText(context: context)
                            .getLocal()!
                            .please_enter_number_range_one_to_hundred;
                      }
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(LangText(context: context)
                            .getLocal()!
                            .release_date)),
                    SizedBox(
                      width: 12.w,
                    ),
                    Expanded(
                        child: Text(
                            LangText(context: context).getLocal()!.exp_date)),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                MyTheme.accent_color)),
                        onPressed: pickDateRange,
                        child: Text(startDate != null
                            ? '${startDate!.toDate().day}/${startDate!.toDate().month}/${startDate!.toDate().year}'
                            : "..."),
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                MyTheme.accent_color)),
                        onPressed: pickDateRange,
                        child: Text(expDate != null
                            ? '${expDate!.toDate().day}/${expDate!.toDate().month}/${expDate!.toDate().year}'
                            : "..."),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 40.h,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
        margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 25.h),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(MyTheme.accent_color)),
          onPressed: () async {
            await _updateVoucher(shop!);
          },
          child: Text(
            LangText(context: context).getLocal()!.update_voucher,
            style: TextStyle(fontSize: 18.sp),
          ),
        ),
      ),
    );
  }

  Future<void> _updateVoucher(Shop shop) async {
    String name = _nameController.text;
    // String expDate1 = expDate.toString();
    // String releasedDate = startDate.toString();
    int? newDiscountAmount;
    int? newDiscountPercent;

    if (name.isNotEmpty || discountValue.text.isNotEmpty) {
      print("vallue discount: ${discountValue.text}");
      if (widget.voucher.discountAmount != null) {
        newDiscountAmount = int.parse(discountValue.text);
      } else {
        newDiscountPercent = int.parse(discountValue.text);
      }
      Voucher updatedVoucher = Voucher(
        id: widget.voucher.id,
        name: name,
        expDate: expDate,
        releasedDate: startDate,
        discountAmount: newDiscountAmount,
        discountPercent: newDiscountPercent,
        productID: selectedProduct != null ? selectedProduct!.id! : null,
        shopID: shop.id,
      );

      // widget.onVoucherUpdated(updatedVoucher);j
      await voucherRepo.editVoucher(
          id: widget.voucher.id!, voucher: updatedVoucher);
      // ignore: use_build_context_synchronously
      Navigator.pop(
        context,
        MaterialPageRoute(
            builder: (context) => VoucherApp(
                // shopID: shop.id!,
                )),
      );
      // Close the EditProductScreen after updating
    }
  }

  Future pickDateRange() async {
    final dateRange =
        DateTimeRange(start: startDate!.toDate(), end: expDate!.toDate());
    DateTimeRange? newDataRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    setState(() {
      expDate = Timestamp.fromDate(newDataRange!.end);
      startDate = Timestamp.fromDate(newDataRange.start);
    });
    if (newDataRange == null) return;

    //setState(() => dataRange = newDataRange);
  }
}
