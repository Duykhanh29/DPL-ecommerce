import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/repositories/voucher_repo.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/seller/shop_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/seller/screens/voucher/voucher_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddCoupon extends StatefulWidget {
  // final List<Voucher> vouchers;
  // final Function(Voucher) onVoucherAdded;
  String shopID;
  AddCoupon({
    required this.shopID,
  });
  @override
  State<AddCoupon> createState() => __AddCouponState();
}

class __AddCouponState extends State<AddCoupon> {
  // DateTimeRange dateRange = DateTimeRange(
  //   start: DateTime.now(),
  //   end: DateTime.now().add(const Duration(days: 30)),
  // );

  TextEditingController _nameController = TextEditingController();
  TextEditingController _percentController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // int? discountAmount;
  // int? discountPercent;
  Timestamp? startDate = Timestamp.fromDate(DateTime.now());
  Timestamp? expDate =
      Timestamp.fromDate(DateTime.now().add(const Duration(days: 2)));
  String? dropdownValue;
  String? discountType;
  Product? selectedProduct;
  List<Product>? listProductOfShop;
  ProductRepo productRepo = ProductRepo();
  VoucherRepo voucherRepo = VoucherRepo();
  // String tempShopID = "PkHVNq0E1ZnTUyRnqG4O";
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    listProductOfShop = await productRepo.getListProductByShopID(widget.shopID);
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    final shopProvider = Provider.of<ShopViewModel>(context);
    final user = userProvider.currentUser;
    final shop = shopProvider.shop;
    if (discountType == null) {
      discountType = "Percent";
    }
    if (dropdownValue == null) {
      dropdownValue = "Product";
    }

    return Scaffold(
      appBar: CustomAppBar(
              centerTitle: true,
              context: context,
              title: LangText(context: context).getLocal()!.add_vouvher)
          .show(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  LangText(context: context).getLocal()!.voucher_ucf,
                  style: TextStyle(fontSize: 20.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                DropdownButtonFormField(
                  borderRadius: BorderRadius.circular(10.r),
                  //dropdownColor: Colors.grey,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  value: dropdownValue,
                  onChanged: ((String? newvalue) {
                    setState(() {
                      dropdownValue = newvalue!;
                    });
                  }),
                  items: [
                    DropdownMenuItem(
                      value: "Product",
                      child: Text(
                          LangText(context: context).getLocal()!.for_product),
                    ),
                    DropdownMenuItem(
                      value: "Shop",
                      child:
                          Text(LangText(context: context).getLocal()!.for_shop),
                    ),
                  ],
                  isExpanded: true,
                ),
                //     Text(
                //   'You selected: $dropdownValue',
                //   style: TextStyle(fontSize: 20),
                // ),
                if (dropdownValue == "Product")
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        LangText(context: context)
                            .getLocal()!
                            .select_product_ucf,
                        style: TextStyle(fontSize: 20.sp),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      isLoading
                          ? DropdownButtonFormField(
                              items: [],
                              onChanged: (value) {},
                            )
                          : DropdownButtonFormField<Product>(
                              borderRadius: BorderRadius.circular(10),
                              //dropdownColor: Colors.grey,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 15.w),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              value: selectedProduct,
                              isExpanded: true,
                              items: listProductOfShop!.map((Product p) {
                                return DropdownMenuItem<Product>(
                                  value: p,
                                  child: Text(p.name!),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedProduct = newValue!;
                                  // Reset selected product when category changes
                                });
                              },
                            ),
                      // Hiển thị danh sách sản phẩm ở đây
                      // Ví dụ: ListView.builder(...)
                    ],
                  ),
                // Hiển thị dòng "hello" khi chọn "Shop"
                if (dropdownValue == "Shop") Text(""),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  LangText(context: context).getLocal()!.name_ucf,
                  style: TextStyle(fontSize: 20.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
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
                          .please_enter_name;
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
                Text(
                  LangText(context: context).getLocal()!.discount_ucf,
                  style: TextStyle(fontSize: 20.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),

                DropdownButtonFormField(
                  borderRadius: BorderRadius.circular(10),
                  //dropdownColor: Colors.grey,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  value: discountType,
                  onChanged: ((String? newvalue) {
                    setState(() {
                      discountType = newvalue!;
                    });
                  }),
                  items: [
                    DropdownMenuItem(
                      value: "Percent",
                      child:
                          Text(LangText(context: context).getLocal()!.percent),
                    ),
                    DropdownMenuItem(
                      value: "Amount",
                      child:
                          Text(LangText(context: context).getLocal()!.amount),
                    ),
                  ],
                  isExpanded: true,
                ),
                SizedBox(
                  height: 10.h,
                ),
                if (discountType == "Percent") ...{
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LangText(context: context).getLocal()!.number_ucf,
                        style: TextStyle(fontSize: 20.sp),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        controller: _percentController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.h, horizontal: 10.w),
                          filled: true,
                          hoverColor: Color.fromARGB(110, 218, 218, 218),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide.none),
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LangText(context: context)
                                .getLocal()!
                                .please_enter_number;
                          }
                          if (int.tryParse(value) == null ||
                              int.parse(value) <= 0 ||
                              int.parse(value) >= 100) {
                            return LangText(context: context)
                                .getLocal()!
                                .please_enter_positive_integer;
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                },

                if (discountType == "Amount") ...{
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LangText(context: context).getLocal()!.number_ucf,
                        style: TextStyle(fontSize: 20.sp),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _amountController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.w),
                          filled: true,
                          hoverColor: Color.fromARGB(110, 218, 218, 218),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide.none),
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LangText(context: context)
                                .getLocal()!
                                .please_enter_number;
                          }
                          if (int.tryParse(value) == null ||
                              int.parse(value) <= 0) {
                            return LangText(context: context)
                                .getLocal()!
                                .please_enter_number_greater_than_zero;
                          }
                          if (selectedProduct != null) {
                            if (int.tryParse(value)! >=
                                selectedProduct!.price!) {
                              return LangText(context: context)
                                  .getLocal()!
                                  .please_enter_number_less_than_real_price;
                            }
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                },

                // _buidck(name: "Discount Amount", hintname: "Discount Amount", namevalue: "Discount Amount", namctr: TextEditingController()),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      LangText(context: context).getLocal()!.release_date,
                      style: TextStyle(fontSize: 20.sp),
                    )),
                    SizedBox(
                      width: 12.w,
                    ),
                    Expanded(
                        child: Text(
                      LangText(context: context).getLocal()!.exp_date,
                      style: TextStyle(fontSize: 20.sp),
                    )),
                  ],
                ),
                SizedBox(
                  height: 10.h,
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
                        child: Text(
                            '${startDate!.toDate().day}/${startDate!.toDate().month}/${startDate!.toDate().year}'),
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
                        child: Text(
                            '${expDate!.toDate().day}/${expDate!.toDate().month}/${expDate!.toDate().year}'),
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
        margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 25.h),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(MyTheme.accent_color)),
          onPressed: () async {
            // if (_formKey.currentState!.validate()) {
            //   // If the form is valid, perform your action
            //   // e.g., submit the form or perform some other logic
            //   // You can access the validated text using _controller.text
            //   Voucher v;
            //   // if(dropdownValue=="product"){
            //   //    v=Voucher(productID: selectedProduct!=null ? selectedProduct!.id!:null,expDate: expDate,discountAmount: );
            //   // }
            // }
            await _addVoucher(context, shop!.id!);
          },
          child: Text(
            LangText(context: context).getLocal()!.send_ucf,
            style: TextStyle(fontSize: 18.sp),
          ),
        ),
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDataRange = await showDateRangePicker(
      context: context,
      initialDateRange:
          DateTimeRange(start: startDate!.toDate(), end: expDate!.toDate()),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (newDataRange == null) return;

    setState(() {
      expDate = Timestamp.fromDate(newDataRange.end);
      startDate = Timestamp.fromDate(newDataRange.start);
    });
  }

  Future<void> _addVoucher(BuildContext context, String shopId) async {
    String name = _nameController.text;
    String? shopID;
    String? productID;
    int? discountPercent;
    int? discountAmount;
    if (dropdownValue == LangText(context: context).getLocal()!.product_ucf) {
      productID = selectedProduct!.id;
    }
    // else {
    //   shopID = shopId;
    // }

    if (discountType == "Percent") {
      discountPercent = int.parse(_percentController.text);
    } else {
      discountAmount = int.parse(_amountController.text);
    }

    if (name.isNotEmpty) {
      if (discountType == LangText(context: context).getLocal()!.percent &&
          _percentController.text.isNotEmpty) {
        Voucher newVoucher = Voucher(
          name: name,
          discountAmount: discountAmount,
          discountPercent: discountPercent,
          expDate: expDate,
          productID: productID,
          releasedDate: startDate,
          shopID: shopId,
        );
        await voucherRepo.addVoucher(newVoucher);
        // widget.onVoucherAdded(newVoucher);
      } else if (discountType !=
              LangText(context: context).getLocal()!.percent &&
          _amountController.text.isNotEmpty) {
        Voucher newVoucher = Voucher(
          name: name,
          discountAmount: discountAmount,
          discountPercent: discountPercent,
          expDate: expDate,
          productID: productID,
          releasedDate: startDate,
          shopID: shopId,
        );
        // widget.onVoucherAdded(newVoucher);
        await voucherRepo.addVoucher(newVoucher);
      }

      // Clear text fields and image path
      _nameController.clear();
      //_priceController.clear();

      Navigator.pop(
        context,
      );
    }
  }
}
