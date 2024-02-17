import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/models/verification_form.dart';
import 'package:dpl_ecommerce/repositories/shop_repo.dart';
import 'package:dpl_ecommerce/repositories/user_repo.dart';
import 'package:dpl_ecommerce/repositories/verification_form_repo.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopDetails extends StatefulWidget {
  String shopID;
  String sellerID;
  ShopDetails({super.key, required this.shopID, required this.sellerID});

  @override
  State<ShopDetails> createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  VerificationForm? verificationForm;

  bool isLoading = true;
  Shop? shop;
  UserModel? seller;
  VerificationFormRepo verificationFormRepo = VerificationFormRepo();
  ShopRepo shopRepo = ShopRepo();
  UserRepo userRepo = UserRepo();
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    shop = await shopRepo.getShopByID(widget.shopID);
    verificationForm =
        await verificationFormRepo.getVerificationFormByID(widget.shopID);
    seller = await userRepo.getUserByID(widget.sellerID);
    isLoading = false;
    // if (mounted) {
    setState(() {});
    // }
  }

  void reset() {
    isLoading = true;
    // if (mounted) {
    setState(() {});
    // }
  }

  Future<void> onRefresh() async {
    reset();
    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
              title:
                  LangText(context: context).getLocal()!.information_detail_ucf,
              context: context,
              centerTitle: true)
          .show(),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 5.h),
                child: SingleChildScrollView(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LangText(context: context)
                            .getLocal()!
                            .information_seller_ucf,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      // SizedBox(height: 18.h),

                      Row(
                        children: [
                          Text(
                            LangText(context: context).getLocal()!.shop_name,
                            style: TextStyle(
                              fontSize: 18.sp,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            shop != null ? shop!.name! : "...",
                            style: TextStyle(
                              fontSize: 18.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Divider(
                        height: 2.w,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text(
                            LangText(context: context)
                                .getLocal()!
                                .phone_number_ucf,
                            style: TextStyle(
                              fontSize: 18.sp,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            shop != null ? shop!.contactPhone! : "...",
                            style: TextStyle(
                              fontSize: 18.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Divider(
                        height: 2.w,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 18.sp,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            verificationForm != null
                                ? verificationForm!.email!
                                : "...",
                            style: TextStyle(
                              fontSize: 18.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Divider(
                        height: 2.w,
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        // height: 80.h,
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: Center(
                          child: Row(
                            children: [
                              Text(
                                LangText(context: context)
                                    .getLocal()!
                                    .address_ucf,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                // height: 80.h,
                                width: 240.w,
                                // decoration: BoxDecoration(color: MyTheme.red),
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 5.w),
                                child: Text(
                                  verificationForm != null
                                      ? '${verificationForm!.contactAddress?.district!.name} - ${verificationForm!.contactAddress?.city!.name}'
                                      : "...",
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                  maxLines: 3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Divider(
                        height: 2.w,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        LangText(context: context).getLocal()!.legal_info,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 18.h),

                      SizedBox(height: 18.h),
                      Text(
                        LangText(context: context).getLocal()!.license_no_ucf,
                        style: TextStyle(
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(height: 18.h),
                      // Center(
                      //   child: Container(
                      //     child: Image.network(
                      //       'https://picsum.photos/250?image=9',
                      //     ),
                      //   ),
                      // ),
                      Text(
                        verificationForm != null
                            ? '${verificationForm!.licenseNo}'
                            : "...",
                        style: TextStyle(
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(height: 18.h),
                      Text(
                        LangText(context: context).getLocal()!.tax_paper_ucf,
                        style: TextStyle(
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Center(
                        child: verificationForm != null
                            ? CachedNetworkImage(
                                imageUrl: verificationForm!.taxPaper!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height: 140.h,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.2, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    image:
                                        DecorationImage(image: imageProvider),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  height: 140.h,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: Center(
                                    child: Icon(
                                      Icons.error_outline_rounded,
                                      color: MyTheme.red,
                                      size: 40,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => Image.asset(
                                  ImageData.placeHolder,
                                  height: 140.h,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                ),
                              )
                            : Image.asset(
                                ImageData.placeHolder,
                                height: 140.h,
                                width: MediaQuery.of(context).size.width * 0.9,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: isLoading
          ? const SizedBox()
          : !seller!.userInfor!.sellerInfor!.isVerified!
              ? Padding(
                  padding: EdgeInsets.all(10.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 30.w,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                        ),
                        child: IconButton(
                            iconSize: 40,
                            color: Colors.red,
                            icon: Icon(Icons.close),
                            onPressed: () {
                              // unConfirm(verification);
                              Navigator.pop(context);
                            }

                            //cancelVerificationForm(VerificationForm),
                            ),
                      ),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                        ),
                        child: IconButton(
                            color: Colors.green,
                            iconSize: 40,
                            icon: Icon(Icons.check),
                            onPressed: () async {
                              // onConfirm(verification);
                              await verificationFormRepo
                                  .confirmSellerRequest(verificationForm!);
                              Navigator.pop(context);
                            }
                            // confirmVerificationForm(VerificationForm),
                            ),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
    );
  }
}
