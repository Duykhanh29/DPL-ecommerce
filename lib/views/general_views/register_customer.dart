import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/data_sources/third_party_source/address_repository.dart';
import 'package:dpl_ecommerce/helpers/toast_helper.dart';
import 'package:dpl_ecommerce/models/city.dart';
import 'package:dpl_ecommerce/models/district.dart';
import 'package:dpl_ecommerce/models/ward.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/auth_view_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterCustomer extends StatefulWidget {
  @override
  _RegisterCustomerState createState() => _RegisterCustomerState();
}

class _RegisterCustomerState extends State<RegisterCustomer> {
  String _login_by = "email"; //phone or email
  PhoneNumber phoneCode = PhoneNumber(isoCode: 'VN', dialCode: "+84");
  late BuildContext loadingContext;
  var countries_code = <String>[];

  //controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  bool isChecked = false;

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();
  FocusNode confirmPassFocusNode = FocusNode();

  ScrollController _mainScrollController = ScrollController();

  bool isPassVissiable = true;
  bool isConfirmPassVissiable = true;
  onPressReg(AuthViewModel authViewModel, BuildContext context) async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPassController.text.trim();

    if (confirmPassword == "") {
      ToastHelper.showDialog(
          LangText(context: context).getLocal()!.add_full_infor,
          gravity: ToastGravity.BOTTOM);
      return;
    }
    if (password == "") {
      ToastHelper.showDialog(
          LangText(context: context).getLocal()!.add_full_infor,
          gravity: ToastGravity.BOTTOM);
      return;
    }

    if (name == "") {
      ToastHelper.showDialog(
          LangText(context: context).getLocal()!.add_full_infor,
          gravity: ToastGravity.BOTTOM);
      return;
    }
    if (email == "") {
      ToastHelper.showDialog(
          LangText(context: context).getLocal()!.add_full_infor,
          gravity: ToastGravity.BOTTOM);
      return;
    }

    if (passwordController.text != confirmPassController.text) {
      ToastHelper.showDialog(
          LangText(context: context).getLocal()!.passwords_do_not_match,
          gravity: ToastGravity.BOTTOM);
      return;
    }
    if (passwordController.text.length < 6) {
      ToastHelper.showDialog(
          LangText(context: context)
              .getLocal()!
              .password_must_contain_at_least_6_characters,
          gravity: ToastGravity.BOTTOM);
      return;
    }
    // loading();
    await authViewModel.registerUserByEmailAndPass(
      context: context,
      email: email,
      password: password,
      name: name,
    );
    // var response = await AuthRepository().getRegResponse(
    //     name: name,
    //     email: email,
    //     password: password,
    //     confirmPassword: confirmPassword,
    //     shopName: shopName,
    //     city: city,
    //     district: district,
    //     ward: ward!);
    // Navigator.pop(loadingContext);
    // if (response.result!) {
    //   ToastComponent.showDialog(response.message);
    //   Navigator.pop(context);
    // } else {
    //   if (context.mounted) {
    //     DialogBox.warningShow(context, response.message);
    //   }
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.addListener(_onNameChanged);
    emailController.addListener(_onEmailChange);
    confirmPassController.addListener(_onConfirmPassChange);
    passwordController.addListener(_onPassChange);
  }

  void _onNameChanged() {
    setState(() {});
  }

  void _onPassChange() {
    setState(() {});
  }

  void _onConfirmPassChange() {
    setState(() {});
  }

  void _onEmailChange() {
    setState(() {});
  }

  // void onPressRegFail() {
  //   ToastHelper.showDialog(AppLocalizations.of(context)!.accept_policy,
  //       gravity: ToastGravity.BOTTOM, duration: Toast.LENGTH_LONG);
  //   return;
  // }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthViewModel>(context);
    return Scaffold(
      // backgroundColor: MyTheme.splash_screen_color,
      body: GestureDetector(
          onTap: () {
            FocusNode nameFocusNode = FocusNode();
            FocusNode emailFocusNode = FocusNode();
            FocusNode passFocusNode = FocusNode();
            FocusNode confirmPassFocusNode = FocusNode();

            if (nameFocusNode.hasFocus) {
              setState(() {
                nameFocusNode.unfocus();
              });
            }
            if (emailFocusNode.hasFocus) {
              setState(() {
                emailFocusNode.unfocus();
              });
            }

            if (passFocusNode.hasFocus) {
              setState(() {
                passFocusNode.unfocus();
              });
            }

            if (confirmPassFocusNode.hasFocus) {
              setState(() {
                confirmPassFocusNode.unfocus();
              });
            }
          },
          child: buildBody(context)),
    );
  }

  Widget buildBody(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthViewModel>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Center(
              child: Text(
                LangText(context: context).getLocal()!.hi_welcome_to_all_lower,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: MyTheme.accent_color)),
                child: Image.asset(
                  ImageData.appLogo,
                  height: 80.h,
                  width: 80.h,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Center(
              child: Text(
                LangText(context: context).getLocal()!.register,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            spacer(height: 14.h),
            buildBasicInfo(context),
            spacer(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                      child: Text(
                          LangText(context: context).getLocal()!.password_ucf)),
                  Container(
                    // padding:
                    //     EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: MyTheme.textfield_grey),
                    height: 45.h,
                    child: TextField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(
                              255), // Giới hạn độ dài tối đa
                        ],
                        focusNode: passFocusNode,
                        onTap: () {
                          setState(() {
                            passFocusNode.requestFocus();
                          });
                        },
                        onEditingComplete: () {
                          print("Untap");
                          setState(() {
                            passFocusNode.unfocus();
                          });
                        },
                        controller: passwordController,
                        autofocus: false,
                        obscureText: isPassVissiable,
                        enableSuggestions: false,
                        autocorrect: false,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  isPassVissiable = !isPassVissiable;
                                });
                              },
                              child: Icon(isPassVissiable
                                  ? Icons.visibility_off_sharp
                                  : Icons.visibility_sharp),
                            ),
                            fillColor: const Color.fromRGBO(255, 255, 255, 0),
                            hintText: passwordController.text.isEmpty &&
                                    !passFocusNode.hasFocus
                                ? "• • • • • • • •"
                                : null,
                            hintStyle:
                                TextStyle(fontSize: 12.sp, color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: MyTheme.grey_153, width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.r),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      MyTheme.app_accent_color.withOpacity(0.5),
                                  width: 1.5),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.r),
                              ),
                            ),
                            contentPadding: EdgeInsets.only(left: 16.0.w))),
                  ),
                ],
              ),
            ),
            spacer(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                      child: Text(LangText(context: context)
                          .getLocal()!
                          .confirm_your_password)),
                  Container(
                    // padding:
                    //     EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.h),
                        color: MyTheme.textfield_grey),
                    height: 45.h,
                    child: TextField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(
                              255), // Giới hạn độ dài tối đa
                        ],
                        focusNode: confirmPassFocusNode,
                        onTap: () {
                          setState(() {
                            confirmPassFocusNode.requestFocus();
                          });
                        },
                        onEditingComplete: () {
                          print("Untap");
                          setState(() {
                            confirmPassFocusNode.unfocus();
                          });
                        },
                        controller: confirmPassController,
                        autofocus: false,
                        obscureText: isConfirmPassVissiable,
                        enableSuggestions: false,
                        autocorrect: false,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  isConfirmPassVissiable =
                                      !isConfirmPassVissiable;
                                });
                              },
                              child: Icon(isConfirmPassVissiable
                                  ? Icons.visibility_off_sharp
                                  : Icons.visibility_sharp),
                            ),
                            fillColor: const Color.fromRGBO(255, 255, 255, 0),
                            hintText: confirmPassController.text.isEmpty &&
                                    !confirmPassFocusNode.hasFocus
                                ? "• • • • • • • •"
                                : null,
                            hintStyle:
                                TextStyle(fontSize: 12.sp, color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: MyTheme.grey_153, width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.r),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      MyTheme.app_accent_color.withOpacity(0.5),
                                  width: 1.5),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.r),
                              ),
                            ),
                            contentPadding: EdgeInsets.only(left: 16.0.w))),
                  ),
                ],
              ),
            ),
            // ),
            // spacer(height: 22.h),
            // Container(
            //   // color: Colors.red,
            //   padding: EdgeInsets.all(5.h),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Container(
            //         width: 16,
            //         height: 16,
            //         padding: EdgeInsets.all(2.h),
            //         child: Checkbox(
            //           value: isChecked,
            //           onChanged: (value) {
            //             setState(() {
            //               isChecked = !isChecked;
            //             });
            //           },
            //         ),
            //       ),
            //       Container(
            //           width: MediaQuery.of(context).size.width * 0.7,
            //           padding: EdgeInsets.symmetric(horizontal: 14.w),
            //           child: RichText(
            //             text: TextSpan(children: [
            //               TextSpan(
            //                   text: LangText(context: context)
            //                       .getLocal()!
            //                       .pre_policy,
            //                   style: TextStyle(
            //                       color: Colors.black, fontSize: 12.sp)),
            //               TextSpan(
            //                 text: LangText(context: context).getLocal()!.policy,
            //                 style: TextStyle(
            //                   color: MyTheme.button_color,
            //                   fontSize: 12.sp,
            //                 ),
            //                 recognizer: TapGestureRecognizer()
            //                   ..onTap = () {
            //                     // Navigator.push(
            //                     //     context,
            //                     //     MaterialPageRoute(
            //                     //         builder: (context) =>
            //                     //             CommonWebviewScreen(
            //                     //               page_name:
            //                     //                   AppLocalizations.of(context)!
            //                     //                       .policy,
            //                     //               url:
            //                     //                   "${AppConfig.RAW_BASE_URL}/mobile-page/privacy-policy",
            //                     //             )));
            //                   },
            //               )
            //             ]),
            //           )),
            //     ],
            //   ),
            // ),
            spacer(height: 10.h),
            Padding(
              padding: EdgeInsets.only(top: 30.h),
              child: Center(
                child: Container(
                    // height: 45,
                    width: MediaQuery.of(context).size.width * 0.55,
                    padding: EdgeInsets.all(8.h),
                    decoration: BoxDecoration(
                        // border: Border.all(
                        //     color: MyTheme.app_accent_border, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(12.r))),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                MyTheme.accent_color)),
                        onPressed: () {
                          // if (isChecked) {
                          onPressReg(authProvider, context);
                          // } else {
                          // onPressRegFail();
                          // }
                        },
                        child: Text(
                          LangText(context: context).getLocal()!.register,
                          style: TextStyle(color: MyTheme.white),
                        ))),
              ),
            ),
            spacer(height: 10.h),
            Padding(
              padding: EdgeInsets.all(5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(LangText(context: context)
                        .getLocal()!
                        .already_have_an_account),
                  ),
                  spacer(height: 12.h),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          LangText(context: context).getLocal()!.login_ucf,
                          style: TextStyle(color: MyTheme.accent_color),
                        )),
                  ),
                ],
              ),
            ),
            spacer(height: 25.h),
          ],
        ),
      ),
    );
  }

  Widget inputFieldModel(
      String title, String hint, TextEditingController controller,
      {bool isPassword = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 12.sp),
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
            height: 36.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: const Color.fromRGBO(255, 255, 255, 0.5)),
            child: TextField(
                style: TextStyle(color: Colors.white),
                controller: controller,
                autofocus: false,
                obscureText: isPassword,
                decoration: InputDecoration()),
          ),
        ],
      ),
    );
  }

  Widget spacer({height = 24}) {
    return SizedBox(
      height: double.parse(height.toString()),
    );
  }

  Widget buildBasicInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.all(3.h),
                    child:
                        Text(LangText(context: context).getLocal()!.name_ucf)),
                Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: MyTheme.textfield_grey),
                  child: TextField(
                    focusNode: nameFocusNode,
                    onTap: () {
                      setState(() {
                        nameFocusNode.requestFocus();
                      });
                    },
                    onEditingComplete: () {
                      print("Untap");
                      setState(() {
                        nameFocusNode.unfocus();
                      });
                    },
                    style: const TextStyle(color: Colors.black),
                    controller: nameController,
                    autofocus: false,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(
                          255), // Giới hạn độ dài tối đa
                    ],
                    decoration: InputDecorations.buildInputDecoration_1(
                        borderColor: MyTheme.noColor,
                        hint_text: nameController.text.isEmpty &&
                                !nameFocusNode.hasFocus
                            ? "Mr. Jhon"
                            : null,
                        hintTextColor: MyTheme.black),
                  ),
                ),
              ],
            ),
          ),
          spacer(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    child:
                        Text(LangText(context: context).getLocal()!.email_ucf)),
                Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: MyTheme.textfield_grey),
                  child: TextFormField(
                    validator: (value) {
                      final bool isValid = EmailValidator.validate(value!);
                      if (!isValid) {
                        return LangText(context: context)
                            .getLocal()!
                            .please_enter_valid_email;
                      }
                    },
                    focusNode: emailFocusNode,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(
                          255), // Giới hạn độ dài tối đa
                    ],
                    onTap: () {
                      setState(() {
                        emailFocusNode.requestFocus();
                      });
                    },
                    onEditingComplete: () {
                      setState(() {
                        emailFocusNode.unfocus();
                      });
                    },
                    style: TextStyle(color: Colors.black),
                    controller: emailController,
                    autofocus: false,
                    decoration: InputDecorations.buildInputDecoration_1(
                        borderColor: MyTheme.noColor,
                        hint_text: emailController.text.isEmpty &&
                                !emailFocusNode.hasFocus
                            ? "customer@example.com"
                            : null,
                        hintTextColor: MyTheme.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // loading() {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         loadingContext = context;
  //         return AlertDialog(
  //             content: Row(
  //           children: [
  //             const CircularProgressIndicator(),
  //             SizedBox(
  //               width: 10.w,
  //             ),
  //             Text(AppLocalizations.of(context)!.please_wait_ucf),
  //           ],
  //         ));
  //       });
  // }
}
