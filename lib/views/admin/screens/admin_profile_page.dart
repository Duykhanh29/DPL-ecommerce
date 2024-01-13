import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/repositories/user_repo.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/address_view_model.dart';
import 'package:dpl_ecommerce/view_model/auth_view_model.dart';
// import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/address_screen.dart';
import 'package:dpl_ecommerce/views/consumer/screens/change_language_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/favorite_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/profile_setting_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/user_list_voucher.dart';
import 'package:dpl_ecommerce/views/consumer/screens/wishlist_page.dart';
import 'package:dpl_ecommerce/views/general_views/login_screen.dart';
import 'package:dpl_ecommerce/views/seller/screens/address_seller_screen.dart';
import 'package:dpl_ecommerce/views/seller/screens/seller_setting_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdminProfilePage extends StatelessWidget {
  AdminProfilePage({Key? key})
      : super(
          key: key,
        );
  UserRepo userRepo = UserRepo();
  onPressLogout(context, AuthViewModel authProvider) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: EdgeInsets.only(
                  top: 16.h, left: 2.w, right: 2.w, bottom: 12.h),
              content: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  AppLocalizations.of(context)!.are_you_sure_to_logout,
                  maxLines: 3,
                  style: TextStyle(color: MyTheme.font_grey, fontSize: 14.sp),
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        padding: EdgeInsets.all(10.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                          /*border: Border(
                  top: BorderSide(color: MyTheme.light_grey,width: 1.0),
                )*/
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.cancel_ucf,
                            style: TextStyle(color: MyTheme.medium_grey),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        // savePref();
                        // AuthHelper().clearUserData();

                        await authProvider.signOut();
                        // Navigator.of(context, rootNavigator: true)
                        //     .pushAndRemoveUntil(
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       // return NavigationScreen();
                        //       return LoginScreen();
                        //     },
                        //   ),
                        //   (route) => true,
                        // );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        padding: EdgeInsets.all(10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                          /*border: Border(
                  top: BorderSide(color: MyTheme.light_grey,width: 1.0),
                )*/
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.confirm_ucf,
                            style: TextStyle(color: MyTheme.white),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthViewModel>(context);
    final size = MediaQuery.of(context).size;
    final user = authProvider.currentUser;
    final addressProvider = Provider.of<AddressViewModel>(context);
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
                                onTap: () async {
                                  AddressInfor? address = await userRepo
                                      .getAddressForSeller(user!.id!);
                                  addressProvider
                                      .setListAddressInfor([address!]);
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

                              // ListTile(
                              //     onTap: () {
                              //       // go to Languages page
                              //     },
                              //     leading: Icon(
                              //       Icons.star,
                              //       size: 20.h,
                              //     ),
                              //     title: Padding(
                              //       padding: EdgeInsets.only(
                              //         left: 10.w,
                              //         bottom: 3.h,
                              //       ),
                              //       child: Text(
                              //         LangText(context: context)
                              //             .getLocal()!
                              //             .rate_app,
                              //         style: CustomTextStyles.labelLargeGray600,
                              //       ),
                              //     ),
                              //     trailing: SizedBox(
                              //       width: size.width * 0.08,
                              //       height: size.width * 0.08,
                              //       child: InkWell(
                              //         onTap: () {
                              //           // go to Languages page
                              //         },
                              //         child: Center(
                              //           child: Icon(
                              //             Icons.navigate_next,
                              //             size: 20.h,
                              //           ),
                              //         ),
                              //       ),
                              //     )),
                              // Divider(
                              //   height: 5.h,
                              // ),
                              ListTile(
                                  onTap: () async {
                                    // await authProvider.signOut();
                                    await onPressLogout(context, authProvider);
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
                                      onTap: () {},
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
          border: Border.all(color: MyTheme.accent_color, width: 0.7)),
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
