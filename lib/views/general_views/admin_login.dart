import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/helpers/toast_helper.dart';
import 'package:dpl_ecommerce/helpers/validators.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/auth_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class AdminLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdminLoginScreen();
}

class _AdminLoginScreen extends State<AdminLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  bool isVissible = true;

  // void goToSignUpScreen() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => SignUpScreen()),
  //   );
  // }
  onPressedLogin(AuthViewModel authViewModel, BuildContext context) async {
    var email = emailController.text.toString();
    var password = passwordController.text.toString();

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
        email: email, password: password, context: context);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // title: ,
        leading: Container(
          width: 35.h,
          height: 35.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: MyTheme.accent_color,
            ),
          ),
        ),
        centerTitle: true,
      ),
      //  CustomAppBar(
      //   backgroundColor: MyTheme.background,
      //   title: ,
      //   context: context,
      //   centerTitle: true,
      // ).show(),
      body: Padding(
          padding: EdgeInsets.all(16.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
              ),
              Text(LangText(context: context).getLocal()!.welcome_admin_ucf,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: 20.h,
              ),
              Text(
                LangText(context: context).getLocal()!.login_as_admin,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: MyTheme.accent_color),
              ),
              SizedBox(
                height: 50.h,
              ),

              Padding(padding: EdgeInsets.only(top: 32.h)),
              TextFormField(
                controller: emailController,
                focusNode: emailFocusNode,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.always,
                validator: (input) {
                  if (input!.isEmpty || Validators.isValidEmail1(input)) {
                    return null;
                  } else {
                    return LangText(context: context).getLocal()!.invalid_email;
                  }
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.h),
                  labelText: "Email",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.redAccent, width: 1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.redAccent, width: 1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 16.h)),
              TextFormField(
                obscureText: isVissible,
                controller: passwordController,
                focusNode: passwordFocusNode,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isVissible = !isVissible;
                        });
                      },
                      icon: Icon(isVissible
                          ? Icons.visibility_sharp
                          : Icons.visibility_off_sharp)),
                  contentPadding: EdgeInsets.all(8.h),
                  labelText:
                      LangText(context: context).getLocal()!.password_ucf,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 32.h)),
              GestureDetector(
                onTap: () async {
                  if (emailController.text.toString().trim().isNotEmpty &&
                      passwordController.text.toString().trim().isNotEmpty) {
                    String email = emailController.text.toString().trim();
                    String password = passwordController.text.toString().trim();
                    if (!Validators.isValidEmail1(email)) {
                      ToastHelper.showDialog(
                          LangText(context: context)
                              .getLocal()!
                              .please_enter_the_correct_email_format,
                          gravity: ToastGravity.CENTER);
                      //  Fluttertoast.showToast(
                      //     msg: ,
                      //     toastLength: Toast.LENGTH_SHORT,
                      //     gravity: ToastGravity.CENTER,
                      //     timeInSecForIosWeb: 1,
                      //     backgroundColor: Colors.black45,
                      //     textColor: Colors.white,
                      //     fontSize: 12.0);
                    } else {
                      // authViewModel.login(
                      //     email: email,
                      //     password: password,
                      //     isCheckAdmin:
                      //         authViewModel.rolesType == RolesType.admin);
                      await onPressedLogin(authProvider, context);
                    }
                  } else {
                    ToastHelper.showDialog(
                        LangText(context: context).getLocal()!.add_full_infor,
                        gravity: ToastGravity.CENTER);
                  }
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: MyTheme.accent_color,
                        borderRadius: BorderRadius.circular(10.r)),
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Center(
                      child: Text(
                        LangText(context: context).getLocal()!.login_ucf,
                        style: TextStyle(color: MyTheme.white, fontSize: 14.sp),
                      ),
                    )),
              )

              // const Padding(padding: EdgeInsets.only(top: 8)),
              // GestureDetector(
              //   onTap: () {
              //     print('Dang nhập');
              //     goToSignUpScreen();
              //   },
              //   child: authViewModel.rolesType != RolesType.admin
              //       ? const Text(
              //           'Chưa có tài khoản? Đăng ký',
              //           style:
              //               TextStyle(color: Colors.blueAccent, fontSize: 12),
              //         )
              //       : const SizedBox(),
              // )
            ],
          )),
    );
  }
}
