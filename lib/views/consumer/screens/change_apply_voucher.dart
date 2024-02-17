import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/helpers/date_helper.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/consumer/voucher_for_user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ChangeApplyVoucher extends StatefulWidget {
  const ChangeApplyVoucher({super.key});

  @override
  State<ChangeApplyVoucher> createState() => _ChangeApplyVoucherState();
}

class _ChangeApplyVoucherState extends State<ChangeApplyVoucher> {
  @override
  Widget build(BuildContext context) {
    final voucherForUserProvider =
        Provider.of<VoucherForUserViewModel>(context);
    final listVouhcerOfAdmin = voucherForUserProvider.listVoucherOfAdmin;
    final selectedVoucher = voucherForUserProvider.selectedVoucher;
    print("selectedVoucher:ID: ${selectedVoucher!.id!}");
    return Scaffold(
      appBar: CustomAppBar(
              centerTitle: true,
              context: context,
              title: LangText(context: context)
                  .getLocal()!
                  .change_voucher_for_apply)
          .show(),
      //body: ChangeAddress(),
      body: ListView.builder(
        itemCount: listVouhcerOfAdmin.length,
        itemBuilder: (context, index) {
          final op = listVouhcerOfAdmin[index];
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
                    // height: 121.h,
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
                          Radio<Voucher>(
                            value: op,
                            groupValue: op.id == selectedVoucher.id ? op : null,
                            onChanged: (newValue) {
                              print("new value :${newValue}");
                              voucherForUserProvider
                                  .changeSelectedVoucher(newValue!);
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
                              Text(listVouhcerOfAdmin[index].name!,
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF000000),
                                  )),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                  listVouhcerOfAdmin[index].discountAmount !=
                                          null
                                      ? "${LangText(context: context).getLocal()!.discount_ucf} ${listVouhcerOfAdmin[index].discountAmount!} VND"
                                      : "${LangText(context: context).getLocal()!.discount_ucf} ${listVouhcerOfAdmin[index].discountPercent!} %",
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: MyTheme.red,
                                  )),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                  "${LangText(context: context).getLocal()!.release_date}: ${DateHelper.convertCommonDateTime(listVouhcerOfAdmin[index].releasedDate!)}",
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF777777),
                                  )),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                  "${LangText(context: context).getLocal()!.exp_date}: ${DateHelper.convertCommonDateTime(listVouhcerOfAdmin[index].expDate!)}",
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
