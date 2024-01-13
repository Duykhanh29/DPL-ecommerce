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
import 'package:dpl_ecommerce/views/consumer/screens/ranking_screen.dart';
import 'package:dpl_ecommerce/views/consumer/screens/user_list_voucher.dart';
import 'package:dpl_ecommerce/views/consumer/screens/voucher_screen.dart';
import 'package:dpl_ecommerce/views/consumer/screens/wishlist_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({Key? key})
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
                        Navigator.pop(_);
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
                        Navigator.pop(_);
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
    final addressProvider = Provider.of<AddressViewModel>(context);
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
                        // SizedBox(
                        //   height: 10.h,
                        // ),
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
                                  AddressInfor? addressInfor = await userRepo
                                      .getDefaultAddress(user!.id!);
                                  addressProvider
                                      .setDefaultAddress(addressInfor!);
                                  addressProvider
                                      .setOrderingAddress(addressInfor);
                                  List<AddressInfor>? list = await userRepo
                                      .getListAddressInfor(user!.id!);
                                  addressProvider.setListAddressInfor(list!);
                                  // go to address page
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddressScreen(),
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
                                    onTap: () async {
                                      AddressInfor? addressInfor =
                                          await userRepo
                                              .getDefaultAddress(user!.id!);
                                      addressProvider
                                          .setDefaultAddress(addressInfor!);
                                      addressProvider
                                          .setOrderingAddress(addressInfor);
                                      List<AddressInfor>? list = await userRepo
                                          .getListAddressInfor(user!.id!);

                                      addressProvider
                                          .setListAddressInfor(list!);
                                      // go to address page
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => AddressScreen(),
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
                                    // go to vouchers page
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => UserListVoucher(),
                                    ));
                                  },
                                  leading: Icon(
                                    Icons.card_giftcard_rounded,
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
                                          .my_vouchers,
                                      style: CustomTextStyles.labelLargeGray600,
                                    ),
                                  ),
                                  trailing: SizedBox(
                                    width: size.width * 0.08,
                                    height: size.width * 0.08,
                                    child: InkWell(
                                      onTap: () {
                                        // go to voucher page
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              UserListVoucher(),
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
                                  onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              WishlistPage(uid: user!.id!),
                                        ),
                                      ),
                                  leading: Icon(
                                    Icons.favorite_outline,
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
                                          .my_wishlist_ucf,
                                      style: CustomTextStyles.labelLargeGray600,
                                    ),
                                  ),
                                  trailing: SizedBox(
                                    width: size.width * 0.08,
                                    height: size.width * 0.08,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                WishlistPage(uid: user!.id!),
                                          ),
                                        );
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
                              const Divider(
                                height: 5,
                              ),
                              ListTile(
                                  onTap: () {
                                    // go to raking page
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => RankUser(),
                                    ));
                                  },
                                  leading: SvgPicture.asset(
                                    "assets/images/ranking-star-solid.svg",
                                    height: 30,
                                    width: 30,
                                  ),
                                  title: Padding(
                                    padding: EdgeInsets.only(
                                      left: 10.w,
                                      bottom: 3.h,
                                    ),
                                    child: Text(
                                      LangText(context: context)
                                          .getLocal()!
                                          .award_point_and_raking,
                                      style: CustomTextStyles.labelLargeGray600,
                                    ),
                                  ),
                                  trailing: SizedBox(
                                    width: size.width * 0.08,
                                    height: size.width * 0.08,
                                    child: InkWell(
                                      onTap: () {
                                        // go to raking page
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => RankUser(),
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
                                  onTap: () {},
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
                                        //
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
                                          color: const Color.fromARGB(
                                              255, 61, 52, 52)),
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
      //   left: 10.w,
      //   right: 10.w,
      //   bottom: 5.h,
      //   top: 5.h,
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
                return ProfileSettingScreen();
              },
            ));
          },
          leading: Consumer<UserViewModel>(
            builder: (context, value, child) {
              return value.userModel!.avatar != null
                  ? CircleAvatar(
                      radius: 40.r,
                      backgroundImage: NetworkImage(value.userModel!.avatar!),
                    )
                  : CircleAvatar(
                      radius: 40.r,
                      backgroundImage: AssetImage(ImageData.circelAvatar));
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
