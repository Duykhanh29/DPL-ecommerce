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

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String _login_by = "email"; //phone or email
  PhoneNumber phoneCode = PhoneNumber(isoCode: 'VN', dialCode: "+84");
  late BuildContext loadingContext;
  var countries_code = <String>[];

  //controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController shopNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _homeNumberController = TextEditingController();
  bool isChecked = false;

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode shopNameFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();
  FocusNode confirmPassFocusNode = FocusNode();

  FocusNode cityFocusNode = FocusNode();
  FocusNode districtFocusNode = FocusNode();
  FocusNode wardFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();
  FocusNode homeNumberFocusNode = FocusNode();
  ScrollController _mainScrollController = ScrollController();

  int? _default_shipping_address = 0;
  City? _selected_city;
  District? _selected_district;
  Ward? _selected_ward;

  TextEditingController _cityController = TextEditingController();
  TextEditingController _districtController = TextEditingController();
  TextEditingController _wardController = TextEditingController();

  onPressReg(AuthViewModel authViewModel, BuildContext context) async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPassController.text.trim();
    String shopName = shopNameController.text.trim();
    // String address = addressController.text.trim();
    String? homeNumber = _homeNumberController.text;
    String? country = _countryController.text;
    if (shopName == "") {
      ToastHelper.showDialog(
          LangText(context: context).getLocal()!.add_full_infor,
          gravity: ToastGravity.BOTTOM);
      return;
    }
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
    if (country == "") {
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
    if (homeNumber == "") {
      ToastHelper.showDialog(
          LangText(context: context).getLocal()!.add_full_infor,
          gravity: ToastGravity.BOTTOM);
      return;
    }
    if (_selected_city == null) {
      ToastHelper.showDialog(
          LangText(context: context).getLocal()!.add_full_infor,
          gravity: ToastGravity.BOTTOM);
      return;
    }
    if (_selected_district == null) {
      ToastHelper.showDialog(
          LangText(context: context).getLocal()!.add_full_infor,
          gravity: ToastGravity.BOTTOM);
      return;
    }
    if (_selected_ward == null) {
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

    // loading();
    await authViewModel.registerForSellerByEmaillAndPass(
        context: context,
        email: email,
        pass: password,
        firstName: name,
        city: _selected_city!,
        disctrict: _selected_district!,
        ward: _selected_ward!,
        country: country,
        number: homeNumber,
        shopName: shopName);
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

  onSelectCityDuringAdd(city) {
    if (_selected_city != null && city.id == _selected_city!.id) {
      setState(() {
        _cityController.text = city.name;
      });
      print("${_selected_city!.id}");
      print("object");
      print("${_selected_city!.name}");

      return;
    }
    setState(() {
      _selected_city = city;

      _cityController.text = city.name;
      _selected_district = null;
      _selected_ward = null;
      _districtController.text = "";
      _wardController.text = "";
    });
  }

  onSelectDistrictDuringAdd(district) {
    if (_selected_city != null &&
        _selected_district != null &&
        district.id == _selected_district!.id) {
      setState(() {
        _districtController.text = district.name;
      });
      print("${_selected_city!.id}");
      print("object");
      print("${_selected_city!.name}");

      return;
    }
    _selected_district = district;
    setState(() {
      _districtController.text = district.name;
      _selected_ward = null;
      _wardController.text = "";
    });
  }

  onSelectWardDuringAdd(ward) {
    if (_selected_city != null &&
        _selected_district != null &&
        _selected_ward != null &&
        ward.id == _selected_ward!.id) {
      setState(() {
        _wardController.text = ward.name;
      });
      print("${_selected_ward!.id}");
      print("object");
      print("${_selected_ward!.name}");

      return;
    }
    _selected_ward = ward;
    setState(() {
      _wardController.text = ward.name;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.addListener(_onNameChanged);
    shopNameController.addListener(_onShopNameChange);
    emailController.addListener(_onEmailChange);
    phoneNumberController.addListener(_onPhoneChange);
    confirmPassController.addListener(_onConfirmPassChange);
    passwordController.addListener(_onPassChange);
    _countryController.addListener(_onCountryChange);
    _cityController.addListener(_onCityChange);
    _districtController.addListener(_onDistrictChange);
    _wardController.addListener(_onWardChange);
    _homeNumberController.addListener(() {
      setState(() {});
    });
  }

  void _onCountryChange() {
    setState(() {});
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

  void _onShopNameChange() {
    setState(() {});
  }

  void _onPhoneChange() {
    setState(() {});
  }

  void _onEmailChange() {
    setState(() {});
  }

  void _onCityChange() {
    setState(() {});
  }

  void _onDistrictChange() {
    setState(() {});
  }

  void _onWardChange() {
    setState(() {});
  }

  void onPressRegFail() {
    ToastHelper.showDialog(AppLocalizations.of(context)!.accept_policy,
        gravity: ToastGravity.BOTTOM, duration: Toast.LENGTH_LONG);
    return;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthViewModel>(context);
    return Scaffold(
      // backgroundColor: MyTheme.splash_screen_color,
      body: GestureDetector(
          onTap: () {
            FocusNode nameFocusNode = FocusNode();
            FocusNode emailFocusNode = FocusNode();
            FocusNode shopNameFocusNode = FocusNode();
            FocusNode passFocusNode = FocusNode();
            FocusNode confirmPassFocusNode = FocusNode();

            FocusNode cityFocusNode = FocusNode();
            FocusNode districtFocusNode = FocusNode();
            FocusNode wardFocusNode = FocusNode();
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
            if (shopNameFocusNode.hasFocus) {
              setState(() {
                shopNameFocusNode.unfocus();
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
            if (cityFocusNode.hasFocus) {
              setState(() {
                cityFocusNode.unfocus();
              });
            }
            if (districtFocusNode.hasFocus) {
              setState(() {
                districtFocusNode.unfocus();
              });
            }
            if (wardFocusNode.hasFocus) {
              setState(() {
                wardFocusNode.unfocus();
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
            buildAddressInfo(context),
            spacer(height: 10.h),
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.all(3.h),
                      child: Text(
                          LangText(context: context).getLocal()!.password_ucf)),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: MyTheme.textfield_grey),
                    height: 40.h,
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
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecorations.buildInputDecoration_1(
                          borderColor: MyTheme.noColor,
                          hint_text: passwordController.text.isEmpty &&
                                  !passFocusNode.hasFocus
                              ? "• • • • • • • •"
                              : null,
                          hintTextColor: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            spacer(height: 10.h),
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.all(3.h),
                      child: Text(LangText(context: context)
                          .getLocal()!
                          .confirm_your_password)),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.h),
                        color: MyTheme.textfield_grey),
                    height: 40.h,
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
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecorations.buildInputDecoration_1(
                          borderColor: MyTheme.noColor,
                          hint_text: confirmPassController.text.isEmpty &&
                                  !confirmPassFocusNode.hasFocus
                              ? "• • • • • • • •"
                              : null,
                          hintTextColor: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            // ),
            spacer(height: 22.h),
            Container(
              // color: Colors.red,
              padding: EdgeInsets.all(5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    padding: EdgeInsets.all(2.h),
                    child: Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = !isChecked;
                        });
                      },
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: LangText(context: context)
                                  .getLocal()!
                                  .pre_policy,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 12.sp)),
                          TextSpan(
                            text: LangText(context: context).getLocal()!.policy,
                            style: TextStyle(
                              color: MyTheme.button_color,
                              fontSize: 12.sp,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             CommonWebviewScreen(
                                //               page_name:
                                //                   AppLocalizations.of(context)!
                                //                       .policy,
                                //               url:
                                //                   "${AppConfig.RAW_BASE_URL}/mobile-page/privacy-policy",
                                //             )));
                              },
                          )
                        ]),
                      )),
                ],
              ),
            ),
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
                        onPressed: () {
                          if (isChecked) {
                            onPressReg(authProvider, context);
                          } else {
                            onPressRegFail();
                          }
                        },
                        child: Text(
                            LangText(context: context).getLocal()!.register))),
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
                            LangText(context: context).getLocal()!.login_ucf)),
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
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(width: 1, color: MyTheme.medium_grey)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            child: Text(
              LangText(context: context).getLocal()!.personal_info_ucf,
              style: TextStyle(
                  color: MyTheme.app_accent_border,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 1,
            color: MyTheme.medium_grey,
          ),
          spacer(height: 14.h),
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
                  height: 40.h,
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
                    padding: const EdgeInsets.all(3),
                    child:
                        Text(LangText(context: context).getLocal()!.email_ucf)),
                Container(
                  height: 40.h,
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
                            ? "seller@example.com"
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
                    padding: EdgeInsets.all(3.h),
                    child:
                        Text(LangText(context: context).getLocal()!.shop_name)),
                Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: MyTheme.textfield_grey),
                  child: TextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(
                          255), // Giới hạn độ dài tối đa
                    ],
                    focusNode: shopNameFocusNode,
                    onTap: () {
                      setState(() {
                        shopNameFocusNode.requestFocus();
                      });
                    },
                    onEditingComplete: () {
                      print("Untap");
                      setState(() {
                        shopNameFocusNode.unfocus();
                      });
                    },
                    style: TextStyle(color: MyTheme.black),
                    controller: shopNameController,
                    autofocus: false,
                    decoration: InputDecorations.buildInputDecoration_1(
                        borderColor: MyTheme.noColor,
                        hint_text: shopNameController.text.isEmpty &&
                                !shopNameFocusNode.hasFocus
                            ? LangText(context: context).getLocal()!.shop_name
                            : null,
                        hintTextColor: MyTheme.black),
                  ),
                ),
              ],
            ),
          ),
          spacer(height: 10),
        ],
      ),
    );
  }

  Widget buildAddressInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(width: 1, color: MyTheme.medium_grey)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            child: Text(
              LangText(context: context).getLocal()!.address_ucf,
              style: TextStyle(
                  color: MyTheme.app_accent_border,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            child: Container(
              height: 1,
              color: MyTheme.medium_grey,
            ),
          ),
          spacer(height: 14.h),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
          //   child: TextField(
          //     inputFormatters: [
          //       LengthLimitingTextInputFormatter(255),
          //     ],
          //     focusNode: countryFocusNode,
          //     onTap: () {
          //       setState(() {
          //         countryFocusNode.requestFocus();
          //       });
          //     },
          //     onEditingComplete: () {
          //       print("Untap");
          //       setState(() {
          //         countryFocusNode.unfocus();
          //       });
          //     },
          //     onChanged: (value) {
          //       print("On change: $value");
          //     },
          //     controller: _countryController,
          //     decoration: InputDecoration(
          //         contentPadding:
          //             EdgeInsets.symmetric(vertical: 5.h, horizontal: 7.w),
          //         border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(10.r)),
          //         hintText: _countryController.text.isEmpty &&
          //                 !countryFocusNode.hasFocus
          //             ? LangText(context: context).getLocal()!.country_ucf
          //             : null),
          //   ),
          // ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            child: Container(
              height: 40.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: MyTheme.textfield_grey),
              child: TextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(
                      255), // Giới hạn độ dài tối đa
                ],
                focusNode: countryFocusNode,
                onTap: () {
                  setState(() {
                    countryFocusNode.requestFocus();
                  });
                },
                onEditingComplete: () {
                  print("Untap");
                  setState(() {
                    countryFocusNode.unfocus();
                  });
                },
                style: TextStyle(color: MyTheme.black),
                controller: _countryController,
                autofocus: false,
                decoration: InputDecorations.buildInputDecoration_1(
                    borderColor: MyTheme.noColor,
                    hint_text: _countryController.text.isEmpty &&
                            !countryFocusNode.hasFocus
                        ? LangText(context: context).getLocal()!.country_ucf
                        : null,
                    hintTextColor: MyTheme.black),
              ),
            ),
          ),

          spacer(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            child: Container(
              height: 40.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.r),
                  color: MyTheme.textfield_grey),
              child: TypeAheadField<City>(
                hideKeyboard: true,
                onSuggestionsBoxToggle: (p0) {
                  print("P0 is: $p0");
                },
                suggestionsCallback: (name) async {
                  print("Check again");
                  if (cityFocusNode.hasFocus &&
                      _cityController.text.isNotEmpty) {
                    var cityResponse = await AddressRepository()
                        .getCityList(); // blank response
                    return cityResponse;
                  }
                  if (_selected_city == null) {
                    var cityResponse = await AddressRepository()
                        .getCityList(); // blank response
                    return cityResponse;
                  }
                  var cityResponse = await AddressRepository()
                      .getCityByCode(_selected_city!.id!);
                  return [cityResponse!];
                },
                loadingBuilder: (context) {
                  return SizedBox(
                    height: 40.h,
                    child: Center(
                        child: Text(
                            AppLocalizations.of(context)!.loading_cities_ucf,
                            style: TextStyle(color: MyTheme.medium_grey))),
                  );
                },
                itemBuilder: (context, dynamic city) {
                  //print(suggestion.toString());
                  return ListTile(
                    dense: true,
                    title: Text(
                      city.name,
                      style: const TextStyle(color: MyTheme.font_grey),
                    ),
                  );
                },
                noItemsFoundBuilder: (context) {
                  return SizedBox(
                    height: 40.h,
                    child: Center(
                        child: Text(
                            AppLocalizations.of(context)!.no_city_available,
                            style: TextStyle(color: MyTheme.medium_grey))),
                  );
                },
                onSuggestionSelected: (City city) {
                  print("Check again");
                  onSelectCityDuringAdd(
                    city,
                  );
                },
                textFieldConfiguration: TextFieldConfiguration(
                  focusNode: cityFocusNode,
                  onTap: () {
                    setState(() {
                      cityFocusNode.requestFocus();
                    });
                  },
                  onEditingComplete: () {
                    setState(() {
                      cityFocusNode.unfocus();
                    });
                  },
                  //autofocus: true,
                  controller: _cityController,
                  style: TextStyle(fontSize: 12.sp),
                  onSubmitted: (txt) {
                    // keep blank
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 3.h),
                      hintText: LangText(context: context).getLocal()!.city_ucf,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      suffixIcon: const Icon(Icons.arrow_drop_down)),
                ),
              ),
            ),
          ),
          spacer(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            child: Container(
              height: 40.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: MyTheme.textfield_grey),
              child: TypeAheadField<District?>(
                hideKeyboard: true,
                suggestionsCallback: (name) async {
                  if (_selected_city == null) {
                    return [];
                  }
                  if (districtFocusNode.hasFocus &&
                      _districtController.text.isNotEmpty) {
                    var districtResponse = await AddressRepository()
                        .getDistrictListByCityCode(
                            _selected_city!.id!); // blank response
                    return districtResponse;
                  }
                  if (_selected_district == null) {
                    var districtResponse = await AddressRepository()
                        .getDistrictListByCityCode(
                            _selected_city!.id!); // blank response
                    return districtResponse;
                  }
                  var districtResponse = await AddressRepository()
                      .getDistrictByCode(_selected_district!.id!);
                  return [districtResponse];
                },
                loadingBuilder: (context) {
                  return SizedBox(
                    height: 40.h,
                    child: Center(
                        child: Text(
                            AppLocalizations.of(context)!.loading_districts_ucf,
                            style: TextStyle(color: MyTheme.medium_grey))),
                  );
                },
                itemBuilder: (context, dynamic city) {
                  //print(suggestion.toString());
                  return ListTile(
                    dense: true,
                    title: Text(
                      city.name,
                      style: TextStyle(color: MyTheme.font_grey),
                    ),
                  );
                },
                noItemsFoundBuilder: (context) {
                  return SizedBox(
                    height: 40.h,
                    child: Center(
                        child: Text(
                            AppLocalizations.of(context)!.no_district_available,
                            style: TextStyle(color: MyTheme.medium_grey))),
                  );
                },
                onSuggestionSelected: (District? district) {
                  onSelectDistrictDuringAdd(
                    district,
                  );
                },
                textFieldConfiguration: TextFieldConfiguration(
                  focusNode: districtFocusNode,
                  onTap: () {
                    setState(() {
                      districtFocusNode.requestFocus();
                    });
                  },
                  onEditingComplete: () {
                    setState(() {
                      districtFocusNode.unfocus();
                    });
                  },
                  //autofocus: true,
                  controller: _districtController,
                  style: TextStyle(fontSize: 12.sp),
                  onSubmitted: (txt) {
                    // keep blank
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 3.h),
                      hintText:
                          LangText(context: context).getLocal()!.district_ucf,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      suffixIcon: const Icon(Icons.arrow_drop_down)),
                ),
              ),
            ),
          ),
          spacer(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            child: Container(
              alignment: Alignment.centerLeft,
              height: 40.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: MyTheme.textfield_grey),
              child: Center(
                child: TypeAheadField<Ward?>(
                  hideKeyboard: true,
                  suggestionsCallback: (name) async {
                    if (_selected_district == null) {
                      return [];
                    }
                    if (wardFocusNode.hasFocus &&
                        _wardController.text.isNotEmpty) {
                      var wardResponse = await AddressRepository()
                          .getWardListByDistrictCode(
                              _selected_district!.id!); // blank response
                      return wardResponse;
                    }
                    if (_selected_ward == null) {
                      var wardResponse = await AddressRepository()
                          .getWardListByDistrictCode(
                              _selected_district!.id!); // blank response
                      return wardResponse;
                    }
                    var wardResponse = await AddressRepository()
                        .getWardByCode(_selected_ward!.id!);
                    return [wardResponse!];
                  },
                  loadingBuilder: (context) {
                    return Container(
                      height: 40.h,
                      child: Center(
                          child: Text(
                              AppLocalizations.of(context)!.loading_wards_ucf,
                              style: TextStyle(color: MyTheme.medium_grey))),
                    );
                  },
                  itemBuilder: (context, dynamic city) {
                    //print(suggestion.toString());
                    return ListTile(
                      dense: true,
                      title: Text(
                        city.name,
                        style: const TextStyle(color: MyTheme.font_grey),
                      ),
                    );
                  },
                  noItemsFoundBuilder: (context) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      height: 40.h,
                      child: Center(
                          child: Text(
                              AppLocalizations.of(context)!.no_ward_available,
                              style: TextStyle(color: MyTheme.medium_grey))),
                    );
                  },
                  onSuggestionSelected: (Ward? ward) {
                    onSelectWardDuringAdd(
                      ward,
                    );
                  },
                  textFieldConfiguration: TextFieldConfiguration(
                    focusNode: wardFocusNode,
                    onTap: () {
                      setState(() {
                        wardFocusNode.requestFocus();
                      });
                    },
                    onEditingComplete: () {
                      setState(() {
                        wardFocusNode.unfocus();
                      });
                    },

                    //autofocus: true,
                    controller: _wardController,
                    style: TextStyle(fontSize: 12.sp),
                    onSubmitted: (txt) {
                      // keep blank
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 3.h),
                        hintText:
                            LangText(context: context).getLocal()!.ward_ucf,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        suffixIcon: const Icon(Icons.arrow_drop_down)),
                  ),
                ),
              ),
            ),
          ),
          spacer(height: 10.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            child: Container(
              height: 40.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: MyTheme.textfield_grey),
              child: TextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(
                      255), // Giới hạn độ dài tối đa
                ],
                focusNode: homeNumberFocusNode,
                onTap: () {
                  setState(() {
                    homeNumberFocusNode.requestFocus();
                  });
                },
                onEditingComplete: () {
                  print("Untap");
                  setState(() {
                    homeNumberFocusNode.unfocus();
                  });
                },
                style: TextStyle(color: MyTheme.black),
                controller: _homeNumberController,
                autofocus: false,
                decoration: InputDecorations.buildInputDecoration_1(
                    borderColor: MyTheme.noColor,
                    hint_text: _homeNumberController.text.isEmpty &&
                            !homeNumberFocusNode.hasFocus
                        ? LangText(context: context).getLocal()!.home_number
                        : null,
                    hintTextColor: MyTheme.black),
              ),
            ),
          ),
          spacer(height: 10.h),

          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
          //   child: TextField(
          //     focusNode: homeNumberFocusNode,
          //     onTap: () {
          //       setState(() {
          //         homeNumberFocusNode.requestFocus();
          //       });
          //     },
          //     onEditingComplete: () {
          //       print("Untap");
          //       setState(() {
          //         homeNumberFocusNode.unfocus();
          //       });
          //     },
          //     controller: _homeNumberController,
          //     inputFormatters: [
          //       LengthLimitingTextInputFormatter(255), // Giới hạn độ dài tối đa
          //     ],
          //     decoration: InputDecoration(
          //         contentPadding:
          //             EdgeInsets.symmetric(vertical: 5.h, horizontal: 7.w),
          //         border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(10.r)),
          //         hintText: _homeNumberController.text.isEmpty &&
          //                 !homeNumberFocusNode.hasFocus
          //             ? LangText(context: context).getLocal()!.home_number
          //             : null),
          //   ),
          // ),
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
