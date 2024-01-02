import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/auth_view_model.dart';
// import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/address_screen.dart';
import 'package:dpl_ecommerce/views/consumer/screens/change_language_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/favorite_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/profile_setting_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/user_list_voucher.dart';
import 'package:dpl_ecommerce/views/consumer/screens/wishlist_page.dart';
import 'package:dpl_ecommerce/views/seller/screens/address_seller_screen.dart';
import 'package:dpl_ecommerce/views/seller/screens/seller_setting_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SellerProfilePage extends StatelessWidget {
  const SellerProfilePage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthViewModel>(context);
    final size = MediaQuery.of(context).size;
    final user = authProvider.currentUser;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 61.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 1.w),
                    child: Column(
                      children: [
                        _buildAvatarRow(context),
                        SizedBox(height: 58.h),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              // color: Colors.green[100],
                              border:
                                  Border.all(color: Colors.black, width: 0.3)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // SizedBox(height: 24),
                              ListTile(
                                onTap: () {
                                  // go to address page
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddressSellerScreen(),
                                  ));
                                },
                                leading: Icon(
                                  Icons.location_on,
                                  size: 20.h,
                                ),
                                title: Padding(
                                  padding: EdgeInsets.only(
                                    left: 10.w,
                                    bottom: 3.h,
                                  ),
                                  child: Text(
                                    LangText(context: context)
                                        .getLocal()!
                                        .address_ucf,
                                    style: CustomTextStyles.labelLargeGray600,
                                  ),
                                ),
                                trailing: SizedBox(
                                  width: size.width * 0.08,
                                  height: size.width * 0.08,
                                  child: InkWell(
                                    onTap: () {
                                      // go to address page
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            AddressSellerScreen(),
                                      ));
                                    },
                                    child: Center(
                                      child: Icon(
                                        Icons.navigate_next,
                                        size: 20.h,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Divider(
                                height: 5.h,
                              ),
                              ListTile(
                                  onTap: () {
                                    // go to Languages page
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return LanguagePage();
                                      },
                                    ));
                                  },
                                  leading: Icon(
                                    Icons.language,
                                    size: 20.h,
                                  ),
                                  title: Padding(
                                    padding: EdgeInsets.only(
                                      left: 10.w,
                                      bottom: 3.h,
                                    ),
                                    child: Text(
                                      LangText(context: context)
                                          .getLocal()!
                                          .language_ucf,
                                      style: CustomTextStyles.labelLargeGray600,
                                    ),
                                  ),
                                  trailing: SizedBox(
                                    width: size.width * 0.08,
                                    height: size.width * 0.08,
                                    child: InkWell(
                                      onTap: () {
                                        // go to Languages page
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) {
                                            return LanguagePage();
                                          },
                                        ));
                                      },
                                      child: Center(
                                        child: Icon(
                                          Icons.navigate_next,
                                          size: 20.h,
                                        ),
                                      ),
                                    ),
                                  )),
                              Divider(
                                height: 5.h,
                              ),

                              ListTile(
                                  onTap: () {
                                    // go to Languages page
                                  },
                                  leading: Icon(
                                    Icons.star,
                                    size: 20.h,
                                  ),
                                  title: Padding(
                                    padding: EdgeInsets.only(
                                      left: 10.w,
                                      bottom: 3.h,
                                    ),
                                    child: Text(
                                      LangText(context: context)
                                          .getLocal()!
                                          .rate_app,
                                      style: CustomTextStyles.labelLargeGray600,
                                    ),
                                  ),
                                  trailing: SizedBox(
                                    width: size.width * 0.08,
                                    height: size.width * 0.08,
                                    child: InkWell(
                                      onTap: () {
                                        // go to Languages page
                                      },
                                      child: Center(
                                        child: Icon(
                                          Icons.navigate_next,
                                          size: 20.h,
                                        ),
                                      ),
                                    ),
                                  )),
                              Divider(
                                height: 5.h,
                              ),
                              ListTile(
                                  onTap: () async {
                                    // go to Languages page
                                    await authProvider.signOut();
                                  },
                                  leading: Icon(
                                    Icons.logout_rounded,
                                    color: Colors.redAccent,
                                    size: 20.h,
                                  ),
                                  title: Padding(
                                    padding: EdgeInsets.only(
                                      left: 10.w,
                                      bottom: 3.h,
                                    ),
                                    child: Text(
                                      LangText(context: context)
                                          .getLocal()!
                                          .logout_ucf,
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.redAccent),
                                    ),
                                  ),
                                  trailing: SizedBox(
                                    width: size.width * 0.08,
                                    height: size.width * 0.08,
                                    child: InkWell(
                                      onTap: () {
                                        // go to Languages page
                                      },
                                      child: Center(
                                        child: Icon(Icons.navigate_next,
                                            size: 20.h,
                                            color: Colors.redAccent),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAvatarRow(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.h),
          border: Border.all(color: Colors.black, width: 0.2)),
      // padding: EdgeInsets.only(
      //   left: 5.w,
      //   right: 5.w,
      // ),
      margin: EdgeInsets.only(
        left: 15.w,
        right: 15.w,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ListTile(
          onTap: () {
            // go to profile setting
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                userProvider.initialize();
                return ProfileSettingSellerScreen();
              },
            ));
          },
          leading: Consumer<AuthViewModel>(
            builder: (context, value, child) {
              return value.userModel!.avatar != null
                  ? CircleAvatar(
                      radius: 40.r,
                      backgroundImage: NetworkImage(value.userModel!.avatar!),
                    )
                  : CircleAvatar(
                      radius: 40.r,
                      backgroundImage: AssetImage(ImageData.circelAvatar),
                    );
            },
          ),
          title: Consumer<UserViewModel>(
            builder: (context, value, child) {
              return Text(
                value.userModel!.firstName!,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
              );
            },
          ),
          subtitle: Consumer<UserViewModel>(
            builder: (context, value, child) {
              return Text(
                value.userModel!.email!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w200),
              );
            },
          ),
        ),
      ),
    );
  }
}
