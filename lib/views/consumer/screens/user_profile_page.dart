import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/view_model/auth_view_model.dart';
// import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/address_screen.dart';
import 'package:dpl_ecommerce/views/consumer/screens/change_language_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/favorite_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/profile_setting_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/user_list_voucher.dart';
import 'package:dpl_ecommerce/views/consumer/screens/wishlist_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key})
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
                    padding: EdgeInsets.only(left: 1),
                    child: Column(
                      children: [
                        _buildAvatarRow(context),
                        SizedBox(height: 58),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 23),
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
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
                                    builder: (context) => AddressScreen(),
                                  ));
                                },
                                leading: Icon(Icons.location_on),
                                title: Padding(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                    bottom: 3,
                                  ),
                                  child: Text(
                                    "address",
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
                                        builder: (context) => AddressScreen(),
                                      ));
                                    },
                                    child: Center(
                                      child: Icon(Icons.navigate_next),
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 5,
                              ),
                              ListTile(
                                  onTap: () {
                                    // go to vouchers page
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => UserListVoucher(),
                                    ));
                                  },
                                  leading: Icon(Icons.card_giftcard_rounded),
                                  title: Padding(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      bottom: 3,
                                    ),
                                    child: Text(
                                      "My Vouchers",
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
                                        child: Icon(Icons.navigate_next),
                                      ),
                                    ),
                                  )),

                              const Divider(
                                height: 5,
                              ),
                              ListTile(
                                  onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              WishlistPage(uid: user!.id!),
                                        ),
                                      ),
                                  leading: Icon(Icons.favorite_outline),
                                  title: Padding(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      bottom: 3,
                                    ),
                                    child: Text(
                                      "Wishlist",
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
                                        child: Icon(Icons.navigate_next),
                                      ),
                                    ),
                                  )),
                              const Divider(
                                height: 5,
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
                                  leading: Icon(Icons.language),
                                  title: Padding(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      bottom: 3,
                                    ),
                                    child: Text(
                                      "Languages",
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
                                        child: Icon(Icons.navigate_next),
                                      ),
                                    ),
                                  )),
                              const Divider(
                                height: 5,
                              ),
                              ListTile(
                                  onTap: () {
                                    // go to raking page
                                  },
                                  leading: SvgPicture.asset(
                                    "assets/images/ranking-star-solid.svg",
                                    height: 30,
                                    width: 30,
                                  ),
                                  title: Padding(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      bottom: 3,
                                    ),
                                    child: Text(
                                      "Award point & raking",
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
                                        child: Icon(Icons.navigate_next),
                                      ),
                                    ),
                                  )),
                              const Divider(
                                height: 5,
                              ),
                              ListTile(
                                  onTap: () {
                                    // go to Languages page
                                  },
                                  leading: Icon(Icons.star),
                                  title: Padding(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      bottom: 3,
                                    ),
                                    child: Text(
                                      "Rate app",
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
                                        child: Icon(Icons.navigate_next),
                                      ),
                                    ),
                                  )),
                              const Divider(
                                height: 5,
                              ),
                              ListTile(
                                  onTap: () async {
                                    // go to Languages page
                                    await authProvider.signOut();
                                  },
                                  leading: Icon(
                                    Icons.logout_rounded,
                                    color: Colors.redAccent,
                                  ),
                                  title: Padding(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      bottom: 3,
                                    ),
                                    child: Text(
                                      "Log out",
                                      style: TextStyle(
                                          fontSize: 15,
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
                                            color: Colors.redAccent),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
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
      padding: EdgeInsets.only(
        left: 10.w,
        right: 10.w,
      ),
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
              return CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(value.userModel!.avatar!),
              );
            },
          ),
          title: Consumer<UserViewModel>(
            builder: (context, value, child) {
              return Text(
                value.userModel!.firstName!,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              );
            },
          ),
          subtitle: Consumer<UserViewModel>(
            builder: (context, value, child) {
              return Text(
                value.userModel!.email!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),
              );
            },
          ),
        ),
      ),
    );
  }
}
