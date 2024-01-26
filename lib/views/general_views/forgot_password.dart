// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/helpers/toast_helper.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

class PasswordForget extends StatefulWidget {
  @override
  _PasswordForgetState createState() => _PasswordForgetState();
}

class _PasswordForgetState extends State<PasswordForget> {
  String _send_code_by = "email"; //phone or email
  String initialCountry = 'US';
  PhoneNumber phoneCode = PhoneNumber(isoCode: 'US');
  String? _phone = "";

  //controllers
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    //on Splash Screen hide statusbar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    //before going to other screen show statusbar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  onPressSendCode(AuthViewModel authViewModel, BuildContext context) async {
    var email = _emailController.text.toString();

    if (_send_code_by == 'email' && email == "") {
      ToastHelper.showDialog(AppLocalizations.of(context)!.enter_email,
          gravity: ToastGravity.CENTER);

      return;
    } else if (_send_code_by == 'phone' && _phone == "") {
      ToastHelper.showDialog(AppLocalizations.of(context)!.enter_phone_number,
          gravity: ToastGravity.CENTER);

      return;
    }
    await authViewModel.sendPasswordReset(email, context);
    Future.delayed(const Duration(seconds: 5)).whenComplete(() {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _screen_height = MediaQuery.of(context).size.height;
    final _screen_width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: CustomArrayBackWidget(),
          elevation: 0,
          backgroundColor: MyTheme.white,
        ),
        body: buildBody(_screen_width, context));
  }

  Column buildBody(double _screen_width, BuildContext context) {
    final authProvider = Provider.of<AuthViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20.h,
        ),
        Center(
          child: Container(
            decoration:
                BoxDecoration(border: Border.all(color: MyTheme.accent_color)),
            child: Image.asset(
              ImageData.appLogo,
              height: 80.h,
              width: 80.h,
            ),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        Center(
          child: Text(
            AppLocalizations.of(context)!.forget_password_ucf,
            style: TextStyle(
                fontSize: 20.sp,
                color: MyTheme.accent_color,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: Text(
                  _send_code_by == "email"
                      ? AppLocalizations.of(context)!.email_ucf
                      : AppLocalizations.of(context)!.phone_ucf,
                  style: TextStyle(
                      color: MyTheme.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 50.h,
                      child: TextField(
                          controller: _emailController,
                          autofocus: false,
                          decoration: InputDecoration(
                              hintText: "example@example.com",
                              filled: true,
                              fillColor: MyTheme.white,
                              hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: MyTheme.textfield_grey),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: MyTheme.borderColor, width: 0.2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.r),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: MyTheme.accent_color, width: 0.5),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.r),
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 5.h))),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                  onTap: () async {
                    await onPressSendCode(authProvider, context);
                  },
                  child: Center(
                    child: Container(
                      height: 50.h,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: MyTheme.accent_color_2),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.send_code,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
