import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/utils/common/common_methods.dart';
import 'package:dpl_ecommerce/views/seller/screens/voucher/voucher_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditVoucher extends StatefulWidget {
  final Voucher voucher;
  final Function(Voucher) onVoucherUpdated;

  EditVoucher(
      {required this.voucher,
      required this.onVoucherUpdated,
      required List vouchers});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<EditVoucher> {
  //TextEditingController _availableQuantityController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController discountValue = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    _nameController.text = widget.voucher.name.toString();
    startDate = widget.voucher.releasedDate;
    expDate = widget.voucher.expDate;

    if (widget.voucher.productID != null) {
      dropdownValue = "Product";
      selectedProduct =
          CommondMethods.getProductByID(list!, widget.voucher.productID!);
    } else {
      dropdownValue = "Shop";
    }
    if (widget.voucher.discountAmount != null) {
      discountAmount = widget.voucher.discountAmount;
      discountValue.text = discountAmount.toString();
      discountType = "Amount";
    } else {
      discountPercent = widget.voucher.discountPercent;
      discountValue.text = discountPercent.toString();
      discountType = "Percent";
    }
    setState(() {});
  }

  String? dropdownValue;
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
  List<Product>? list = ProductRepo().list;

  @override
  Widget build(BuildContext context) {
    //final start = dataRange.start;
    //final end = dataRange.end;
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Voucher'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Voucher name"),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    filled: true,
                    hoverColor: Color.fromARGB(110, 218, 218, 218),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product number';
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
                Text("Voucher"),
                DropdownButton(
                  value: dropdownValue ?? "",
                  onChanged: ((String? newvalue) {
                    setState(() {
                      // dropdownValue = newvalue!;
                    });
                  }),
                  items: [
                    DropdownMenuItem(
                      child: Text(dropdownValue ?? ""),
                      value: dropdownValue ?? "",
                    ),
                  ],
                  isExpanded: true,
                ),
                if (dropdownValue == "Product")
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Select Category:'),
                      DropdownButton<Product>(
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
                      ),
                      // Hiển thị danh sách sản phẩm ở đây
                      // Ví dụ: ListView.builder(...)
                    ],
                  ),
                // Hiển thị dòng "hello" khi chọn "Shop"
                // if (dropdownValue == "Shop") Text("hello"),

                DropdownButton(
                  value: discountType ?? "",
                  onChanged: ((String? newvalue) {
                    setState(() {
                      //dropdownValue1 = newvalue!;
                    });
                  }),
                  items: [
                    DropdownMenuItem(
                      child: Text(discountType ?? ""),
                      value: discountType ?? "",
                    ),
                  ],
                  isExpanded: true,
                ),
                //if (dropdownValue1 == "Percent")

                TextFormField(
                  controller: discountValue,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (discountPercent != null) {
                      if (int.tryParse(value) == null ||
                          int.parse(value) <= 0 ||
                          int.parse(value) >= 100) {
                        return 'Please enter a number from 1 to 100';
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
                    Expanded(child: Text("Released Date")),
                    SizedBox(
                      width: 12.w,
                    ),
                    Expanded(child: Text("Exp Date")),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: pickDateRange,
                        child: Text(startDate != null
                            ? '${startDate!.toDate().day}/${startDate!.toDate().month}/${startDate!.toDate().year}'
                            : "waiting"),
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: pickDateRange,
                        child: Text(expDate != null
                            ? '${expDate!.toDate().day}/${expDate!.toDate().month}/${expDate!.toDate().year}'
                            : "waiting"),
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
          onPressed: () {
            _updateVoucher();
          },
          child: Text(
            'Update Voucher',
            style: TextStyle(fontSize: 18.sp),
          ),
        ),
      ),
    );
  }

  void _updateVoucher() {
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
        shopID: "shopID",
      );

      widget.onVoucherUpdated(updatedVoucher);

      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => VoucherApp()),
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
