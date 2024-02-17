import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/address_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ChangeAddress extends StatefulWidget {
  const ChangeAddress({super.key});

  @override
  State<ChangeAddress> createState() => __ChangeAddressState();
}

class __ChangeAddressState extends State<ChangeAddress> {
  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressViewModel>(context);
    final listAddress = addressProvider.listAddress;
    final orderingAddress = addressProvider.orderingAddress;
    print("orderingAddress:ID: ${orderingAddress!.id}");
    return Scaffold(
      appBar: CustomAppBar(
              centerTitle: true,
              context: context,
              title: LangText(context: context).getLocal()!.change_address)
          .show(),
      //body: ChangeAddress(),
      body: ListView.builder(
        itemCount: listAddress.length,
        itemBuilder: (context, index) {
          final op = listAddress[index];
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
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
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
                            groupValue: op.id == orderingAddress.id ? op : null,
                            onChanged: (newValue) {
                              print("new value :${newValue}");
                              addressProvider.setOrderingAddress(newValue!);
                              // setState(() {
                              //   orderingAddress = newValue!;
                              // });
                              Navigator.of(context).pop();
                            },
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                  "${listAddress[index].name!} | ${listAddress[index].number!}",
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF000000),
                                  )),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(listAddress[index].city!.name!,
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF777777),
                                  )),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(listAddress[index].district!.name!,
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF777777),
                                  )),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(listAddress[index].ward!.name!,
                                  maxLines: 3,
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
