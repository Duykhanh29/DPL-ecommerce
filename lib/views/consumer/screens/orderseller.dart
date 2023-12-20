import 'package:dpl_ecommerce/models/deliver_service.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/repositories/deliver_service_repo.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/views/consumer/screens/change_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderSellerState extends StatefulWidget {
  OrderSellerState({super.key});
  final List<Product>? products = ProductRepo().list;
  @override
  State<OrderSellerState> createState() => __OrderSellerStateState();
}

class __OrderSellerStateState extends State<OrderSellerState> {
  final List<Product>? products = ProductRepo().list;
  String shipType = "Cash";
  DeliverService? selectedService;
  List<DeliverService>? list = DeliverServiceRepo().listDeliverService;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment confirmation'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _builditem(context),
                  _buildvoucher(context),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            const Divider(
              height: 2,
              color: Color(0xFFD8D9DB),
            ),
            _buildadress(context),
            SizedBox(
              height: 10.h,
            ),
            const Divider(
              height: 2,
              color: Color(0xFFD8D9DB),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Select Service:',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  DropdownButtonFormField<DeliverService>(
                    borderRadius: BorderRadius.circular(10),
                    //dropdownColor: Colors.grey,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    value: selectedService,
                    isExpanded: true,
                    items: list!.map((DeliverService d) {
                      return DropdownMenuItem<DeliverService>(
                        value: d,
                        child: Text(d.name!),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedService = newValue!;
                        // Reset selected product when category changes
                      });
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Text("Transport fee",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF000000),
                          )),
                      const Spacer(),
                      Text("---",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF000000),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Text("Total price",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF000000),
                          )),
                      const Spacer(),
                      Text("1000000000",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF000000),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: 384.h,
                    height: 50.h,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: ElevatedButton(
                        child: Text(
                          "Order",
                          style:
                              TextStyle(fontSize: 18.sp, color: Colors.white),
                        ),
                        onPressed: () {}),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _builditem(BuildContext context) {
  final List<Product>? products = ProductRepo().list;
  return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: products!.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(
                    products![index]!.images![0],
                    height: 120.h,
                    width: 110.w,
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(products![index].name!,
                        style: const TextStyle(
                          fontSize: 19,
                          //fontFamily = FontFamily(Font(R.font.svn - gilroy)),
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF000000),
                        )),
                    SizedBox(
                      height: 43.h,
                    ),
                    Text(products![index].price.toString(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          //fontFamily = FontFamily(Font(R.font.svn - gilroy)),
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFEE4D2C),
                        )),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text("Quantity ${products![index].availableQuantity}",
                        style: TextStyle(
                          fontSize: 16.sp,
                          //fontFamily = FontFamily(Font(R.font.svn - gilroy)),
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF000000),
                        ))
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            const Divider(
              height: 1,
              color: Color(0xFFD8D9DB),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        );
      });
}

Widget _buildvoucher(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Ship code",
          style: TextStyle(
            fontSize: 18.sp,
            //fontFamily = FontFamily(Font(R.font.svn - gilroy)),
            fontWeight: FontWeight.w500,
            color: const Color(0xFF000000),
          )),
      SizedBox(
        height: 14.h,
      ),
      Container(
          height: 42.h,
          width: 383.w,
          decoration: BoxDecoration(
              color: const Color(0xFFF3F3F3),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(13, 12, 252, 12),
            child: Text("BLACKFRIDAY50",
                style: TextStyle(
                  fontSize: 16.sp,
                  //fontFamily = FontFamily(Font(R.font.svn - gilroy)),
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF000000),
                )),
          ))
    ],
  );
}

Widget _buildadress(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Your address",
            style: TextStyle(
              fontSize: 18.sp,
              //fontFamily = FontFamily(Font(R.font.svn - gilroy)),
              fontWeight: FontWeight.w500,
              color: const Color(0xFF000000),
            )),
        SizedBox(
          height: 14.h,
        ),
        Container(
            height: 121.h,
            width: 383.w,
            decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(13, 12, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Tran Trung",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF000000),
                          )),
                      SizedBox(
                        width: 170.w,
                      ),
                      GestureDetector(
                        onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChangeAddress(),
                      ));
                    },
                        child: Text("Change",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFEE4D2C),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text("0966 123 456",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF777777),
                      )),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text("Ha Noi",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF777777),
                      )),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text("Van Diem - Thuong Tin",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF777777),
                      )),
                ],
              ),
            ))
      ],
    ),
  );
}
