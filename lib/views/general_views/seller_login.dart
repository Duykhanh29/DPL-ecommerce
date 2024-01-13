import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:math';

import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/helpers/toast_helper.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/view_model/auth_view_model.dart';
import 'package:dpl_ecommerce/views/general_views/register_seller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SellerLogin extends StatefulWidget {
  @override
  _SellerLoginState createState() => _SellerLoginState();
}

class _SellerLoginState extends State<SellerLogin> {
  // String _login_by = "email"; //phone or email
  String initialCountry = 'US';

  // PhoneNumber phoneCode = PhoneNumber(isoCode: 'US', dialCode: "+1");
  var countries_code = <String?>[];

  //controllers

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isNotVissiblePass = true;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    //before going to other screen show statusbar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  onPressedLogin(AuthViewModel authViewModel, BuildContext context) async {
    var email = _emailController.text.toString();
    var password = _passwordController.text.toString();

    if (email.length > 0 && email.length < 6) {
      ToastHelper.showDialog(AppLocalizations.of(context)!.enter_email,
          gravity: ToastGravity.BOTTOM, duration: Toast.LENGTH_SHORT);

      return;
    } else if (password.length < 8 && password.length > 0) {
      ToastHelper.showDialog(AppLocalizations.of(context)!.enter_password,
          gravity: ToastGravity.BOTTOM, duration: Toast.LENGTH_SHORT);

      return;
    } else if (email == "" && password == "") {
      ToastHelper.showDialog(
          "${AppLocalizations.of(context)!.enter_email}, ${AppLocalizations.of(context)!.enter_password}",
          gravity: ToastGravity.BOTTOM,
          duration: Toast.LENGTH_SHORT);
      return;
    }
    await authViewModel.signInWithEmailAndPass(
        email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    final _screen_height = MediaQuery.of(context).size.height;
    final _screen_width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   leading: IconButton(
      //       onPressed: () {
      //         Navigator.of(context).pop();
      //       },
      //       icon: const Icon(
      //         Icons.arrow_back,
      //         color: MyTheme.black,
      //       )),
      // ),
      body: Padding(
        padding: EdgeInsets.all(5.h),
        child: buildBody(context, _screen_width),
      ),
    );
  }

  Widget buildBody(BuildContext context, double _screen_width) {
    final authProvider = Provider.of<AuthViewModel>(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: DeviceInfo(context).height! * 0.05,
            // ),
            SizedBox(
              height: 45.h,
            ),
            Center(
              child: SizedBox(
                height: 100.h,
                width: 100.h,
                child: Image.asset(ImageData.appLogo),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Text(
                  AppLocalizations.of(context)!.login_ucf,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: MyTheme.accent_color),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            SizedBox(
              width: _screen_width * (3 / 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 4.0),
                  //   child: Text(
                  //     _login_by == "email"
                  //         ? AppLocalizations.of(context)!.email_ucf
                  //         : AppLocalizations.of(context)!.login_screen_phone,
                  //     style: TextStyle(
                  //         color: MyTheme.accent_color, fontWeight: FontWeight.w600),
                  //   ),
                  // ),
                  SizedBox(
                    height: 10.h,
                  ),
                  // if (_login_by == "email")
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 50.h,
                          child: TextField(
                            controller: _emailController,
                            autofocus: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyTheme.borderColor),
                                ),
                                hintText:
                                    AppLocalizations.of(context)!.email_ucf,
                                filled: true,
                                fillColor: Color(0x33C4C4C4),
                                hintStyle: TextStyle(
                                  fontSize: 12.sp,
                                  color: Color(0x80000000),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: MyTheme.noColor, width: 0.2),
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MyTheme.accent_color, width: 0.5),
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16.w)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 50.h,
                          child: TextField(
                              controller: _passwordController,
                              autofocus: false,
                              obscureText: isNotVissiblePass,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isNotVissiblePass =
                                              !isNotVissiblePass;
                                        });
                                      },
                                      icon: Icon(isNotVissiblePass
                                          ? Icons.visibility_off
                                          : Icons.visibility)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    // borderSide: BorderSide(color: MyTheme.accent_color, width: 0.5),
                                  ),
                                  hintText: AppLocalizations.of(context)!
                                      .password_ucf,
                                  filled: true,
                                  fillColor: Color(0x33C4C4C4),
                                  hintStyle: TextStyle(
                                      fontSize: 12.sp,
                                      color: Color(0x80000000)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: MyTheme.noColor, width: 0.2),
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: MyTheme.accent_color,
                                        width: 0.5),
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16.w))),
                        ),
                        SizedBox(
                          height: 10.r,
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) {
                            //   return PasswordForget();
                            // }));
                          },
                          child: Text(
                            AppLocalizations.of(context)!
                                .login_screen_forgot_password,
                            style: TextStyle(
                                color: MyTheme.accent_color,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.none),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.h),
                    child: Container(
                      height: 45.h,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: MyTheme.textfield_grey, width: 1),
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.h))),
                      child: GestureDetector(
                        onTap: () async {
                          onPressedLogin(authProvider, context);
                        },
                        child: Container(
                          height: 50.h,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: MyTheme.accent_color),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.login_screen_log_in,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20.h,
                  ),

                  SizedBox(
                      height: 45.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .do_not_have_an_account,
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w500),
                          ),
                          // const SizedBox(
                          //   width: 5,
                          // ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Registration(),
                                ));
                              },
                              child: Text(
                                AppLocalizations.of(context)!
                                    .login_screen_sign_up,
                                style: TextStyle(
                                    color: MyTheme.accent_color,
                                    fontWeight: FontWeight.w700),
                              ))
                        ],
                      )),
                ],
              ),
            )
          ],
        ),
        Positioned(
          child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: MyTheme.black,
              )),
          top: 10.h,
          left: 10.h,
        ),
      ],
    );
  }
}
