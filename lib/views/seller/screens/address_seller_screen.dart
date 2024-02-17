import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/customs/custom_elevate_button.dart';
import 'package:dpl_ecommerce/customs/custom_icon_button.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_outline_button.dart';
import 'package:dpl_ecommerce/data_sources/firestore_data_source/user_firestore_data.dart';
import 'package:dpl_ecommerce/helpers/shimmer_helper.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/repositories/user_repo.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/add_address.dart';
import 'package:dpl_ecommerce/views/consumer/screens/address_edit.dart';
import 'package:dpl_ecommerce/views/consumer/screens/checkout_page.dart';
import 'package:dpl_ecommerce/views/seller/screens/edit_address_seller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddressSellerScreen extends StatefulWidget {
  AddressSellerScreen({Key? key}) : super(key: key);
  @override
  _AddresslistItemWidgetState createState() => _AddresslistItemWidgetState();
}

class _AddresslistItemWidgetState extends State<AddressSellerScreen> {
  UserRepo userRepo = UserRepo();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context, listen: false);
    final currentUser = userProvider.userModel;
    final addressInfo = currentUser!.userInfor!.sellerInfor!.contactAddress!;
    // final listAddress = currentUser!.userInfor!.consumerInfor == null
    //     ? []
    //     : currentUser.userInfor!.consumerInfor!.addressInfors;
    return Scaffold(
      appBar: CustomAppBar(
              title: LangText(context: context).getLocal()!.address_ucf,
              centerTitle: true,
              context: context)
          .show(),
      // AppBar(
      //   backgroundColor: Colors.blue,
      //   title: Text(
      //     LangText(context: context).getLocal()!.address_ucf,
      //     textAlign: TextAlign.center,
      //   ),
      //   centerTitle: true,

      //   //leading: Icon(Icons.menu),
      // ),
      body: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ShimmerHelper().buildBasicShimmer(
                height: MediaQuery.of(context).size.height * 0.12,
                width: MediaQuery.of(context).size.width * 0.9);
          } else {
            if (snapshot.data != null) {
              final address = snapshot.data;
              return GestureDetector(
                onTap: () {
                  // userProvider.initilizeAddress(address);
                },
                child: Container(
                  padding: EdgeInsets.all(5.h),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 21.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                address!.name ??
                                    LangText(context: context)
                                        .getLocal()!
                                        .shop_address,
                                style: theme.textTheme.titleSmall,
                              ),
                              SizedBox(height: 19.h),
                              Container(
                                width: 264.h,
                                margin: EdgeInsets.only(right: 30.h),
                                child: Text(
                                  '${address.city}',
                                  style: theme.textTheme.bodySmall,
                                  maxLines: 2,
                                ),
                              ),
                              SizedBox(height: 14.h),
                              Text(
                                '${address.district}',
                                style: theme.textTheme.bodySmall,
                              ),
                              SizedBox(height: 18.h),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditAddressSeller(addressInfor: address),
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 40.h,
                            decoration: BoxDecoration(
                                //color: Colors.white,
                                border: Border.all(
                                  color: Color.fromARGB(35, 0, 0, 0),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                                child: Text(
                              LangText(context: context).getLocal()!.edit_ucf,
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.black54),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: Text(LangText(context: context)
                    .getLocal()!
                    .no_data_is_available),
              );
            }
          }
        },
        stream: userRepo.getAddressInfoForSeller(currentUser!.id!),
      ),
    );
  }
}
