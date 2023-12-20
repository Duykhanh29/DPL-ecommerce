import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/views/consumer/screens/address_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeAddress extends StatefulWidget {
  const ChangeAddress({super.key});

  @override
  State<ChangeAddress> createState() => __ChangeAddressState();
}

class __ChangeAddressState extends State<ChangeAddress> {
  AddressInfor? selectedAdresss;

  final List<AddressInfor> address = [
    AddressInfor(
        city: "Ha noi",
        country: "Ha noi",
        number: "0213456789",
        ward: "Tan trieu",
        id: "98",
        name: "Tran Tai",
        district: "Thanh Tri"),
    AddressInfor(
        city: "Ha noi",
        country: "Ha noi",
        number: "0213456789",
        ward: "Tan trieu",
        id: "98",
        name: "Tran Tai",
        district: "Thanh Tri"),
    AddressInfor(
        city: "Ha noi",
        country: "Ha noi",
        number: "0213456789",
        ward: "Tan trieu",
        id: "98",
        name: "Tran Tai",
        district: "Thanh Tri"),
    AddressInfor(
        city: "Ha noi",
        country: "Ha noi",
        number: "0213456789",
        ward: "Tan trieu",
        id: "98",
        name: "Tran Tai",
        district: "Thanh Tri"),
    AddressInfor(
        city: "Ha noi",
        country: "Ha noi",
        number: "0213456789",
        ward: "Tan trieu",
        id: "98",
        name: "Tran Tai",
        district: "Thanh Tri"),
    AddressInfor(
        city: "Ha noi",
        country: "Ha noi",
        number: "0213456789",
        ward: "Tan trieu",
        id: "98",
        name: "Tran Tai",
        district: "Thanh Tri"),
    AddressInfor(
        city: "Ha noi",
        country: "Ha noi",
        number: "0213456789",
        ward: "Tan trieu",
        id: "98",
        name: "Tran Tai",
        district: "Thanh Tri"),
    AddressInfor(
        city: "Ha noi",
        country: "Ha noi",
        number: "0213456789",
        ward: "Tan trieu",
        id: "98",
        name: "Tran Tai",
        district: "Thanh Tri"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address'),
      ),
      //body: ChangeAddress(),
      body: ListView.builder(
        itemCount: address.length,
        itemBuilder: (context, index) {
          final op = address[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text("Your address",
                //     style: TextStyle(
                //       fontSize: 18.sp,
                //       //fontFamily = FontFamily(Font(R.font.svn - gilroy)),
                //       fontWeight: FontWeight.w500,
                //       color: const Color(0xFF000000),
                //     )),
                // SizedBox(
                //   height: 14.h,
                // ),
                Container(
                    height: 121.h,
                    width: 383.w,
                    decoration: BoxDecoration(
                        color: const Color(0xFFF3F3F3),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Radio<AddressInfor>(
                              value: op,
                              groupValue: selectedAdresss,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedAdresss = newValue!;
                                });
                              }),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                      address![index].name! +
                                          " | " +
                                          address![index].number!,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF000000),
                                      )),
                                  SizedBox(
                                    width: 70.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Navigator.of(context)
                                      //     .push(MaterialPageRoute(
                                      //   builder: (context) => AddressForm(),
                                      // ));
                                    },
                                    child: Text("Edit",
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
                              Text(address![index].city!,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF777777),
                                  )),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                  address![index].district! +
                                      " - " +
                                      address![index].ward!,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF777777),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}
