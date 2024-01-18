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

class SellerINfor extends StatefulWidget {
  String shopID;
  String sellerID;
  SellerINfor({super.key, required this.shopID, required this.sellerID});
  @override
  State<SellerINfor> createState() => _SellerINforState();
}

class _SellerINforState extends State<SellerINfor> {
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
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            onRefresh: onRefresh,
            child: Scaffold(
              appBar: CustomAppBar(
                      title: LangText(context: context)
                          .getLocal()!
                          .information_detail_ucf,
                      context: context,
                      centerTitle: true)
                  .show(),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  seller != null
                      ? Text("Seller name: ${seller!.firstName}")
                      : Text("Seller name: ..."),
                  shop != null
                      ? Text("SHOP name: ${shop!.name}")
                      : Text("SHOP name: ..."),
                  verificationForm != null
                      ? Text("licenseNo: ${verificationForm!.licenseNo}")
                      : Text("licenseNo: ..."),
                ],
              ),
            ));
  }
}
