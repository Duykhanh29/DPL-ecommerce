import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_elevate_button.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_outline_button.dart';
import 'package:dpl_ecommerce/customs/custom_text_form_field.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/helpers/validators.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/auth_view_model.dart';
import 'package:dpl_ecommerce/views/general_views/admin_login.dart';
import 'package:dpl_ecommerce/views/general_views/register_seller.dart';
import 'package:dpl_ecommerce/views/general_views/seller_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 16.h,
            top: 68.h,
            right: 16.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 50.h,
              ),
              Image.asset(
                ImageData.appLogo,
                height: 100.h,
                width: 120.w,
              ),
              SizedBox(height: 30.h),
              Text(
                LangText(context: context).getLocal()!.welcome_to_DPL,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24.sp,
                    color: MyTheme.accent_color,
                    fontWeight: FontWeight.w800),
              ),
              // SizedBox(height: 10.h),
              // Text(
              //   LangText(context: context).getLocal()!.sign_in_to_continue,
              //   style: TextStyle(
              //       fontSize: 18.sp,
              //       color: MyTheme.accent_color_shadow,
              //       fontWeight: FontWeight.w400),
              // ),
              SizedBox(height: 80.h),
              // _buildEmail(context),
              // SizedBox(height: 8.h),
              // _buildPassword(context),
              // SizedBox(height: 16.h),
              // _buildSignIn(context),
              // SizedBox(height: 20.h),s

              // SizedBox(height: 10.h),
              // Padding(padding: EdgeInsets.symmetric(vertical: 10.h)),
              _buildLoginWithGoogle(context),
              // SizedBox(height: 8.h),
              // _buildLoginWithFacebook(context),
              SizedBox(height: 80.h),
              _buildOrLine(context),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: TextButton(
              //     onPressed: () {},
              //     child: Text(
              //       LangText(context: context)
              //           .getLocal()!
              //           .login_screen_forgot_password,
              //       style: TextStyle(fontSize: 12.sp, color: Colors.black),
              //     ),
              //   ),
              // ),
              SizedBox(height: 30.h),
              buildLoginAsSeller(context),
              SizedBox(
                height: 15.h,
              ),
              buildLoginAsAdmin(context),
              // RichText(
              //   text: TextSpan(
              //     children: [
              //       TextSpan(
              //         text: "don't have a account",
              //         style: theme.textTheme.bodySmall,
              //       ),
              //       TextSpan(
              //         text: " ",
              //       ),
              //       TextSpan(
              //         text: "Register",
              //         style: CustomTextStyles.labelLargeOnPrimaryContainer,
              //       ),
              //     ],
              //   ),
              //   textAlign: TextAlign.left,
              // ),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoginAsSeller(BuildContext context) {
    return GestureDetector(
      // style: ButtonStyle(shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: B))),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SellerLogin(),
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
        decoration: BoxDecoration(
            color: MyTheme.accent_color,
            border: Border.all(color: MyTheme.white),
            borderRadius: BorderRadius.circular(10.r)),
        child: Text(
          LangText(context: context).getLocal()!.login_as_seller,
          style: TextStyle(fontSize: 12.sp, color: Colors.white),
        ),
      ),
    );
  }

  Widget buildLoginAsAdmin(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AdminLogin(),
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
        decoration: BoxDecoration(
            color: MyTheme.accent_color,
            border: Border.all(color: MyTheme.white),
            borderRadius: BorderRadius.circular(10.r)),
        child: Text(
          LangText(context: context).getLocal()!.login_as_admin,
          style: TextStyle(fontSize: 12.sp, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildPhoneNumber(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value == '') {
          return LangText(context: context).getLocal()!.input_again;
        } else {
          Validators.validatePhone(value);
        }
      },
      controller: emailController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          hintText: LangText(context: context).getLocal()!.phone_number_ucf,
          prefixIcon: const Icon(Icons.email_rounded)),
      keyboardType: TextInputType.phone,
    );
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value == '') {
          return LangText(context: context).getLocal()!.input_again;
        } else {
          Validators.isValidEmail(value);
        }
      },
      controller: emailController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          hintText: LangText(context: context).getLocal()!.email_ucf,
          prefixIcon: const Icon(Icons.email_rounded)),
      keyboardType: TextInputType.emailAddress,
    );
  }

  /// Section Widget
  Widget _buildPassword(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value == '') {
          return LangText(context: context).getLocal()!.input_again;
        } else if (value.length < 6) {
          return LangText(context: context)
              .getLocal()!
              .password_must_contain_at_least_6_characters;
        } else {
          return null;
        }
      },
      controller: passwordController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          hintText: LangText(context: context).getLocal()!.password_ucf,
          prefixIcon: const Icon(Icons.password)),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
    );
  }

  /// Section Widget
  Widget _buildSignIn(BuildContext context) {
    return Container(
      height: 50.h,
      width: ScreenUtil().screenWidth * 0.9,
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)))),
        child: Text(LangText(context: context).getLocal()!.login_ucf),
      ),
    );
  }

  /// Section Widget
  Widget _buildOrLine(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 10.h,
              bottom: 9.h,
            ),
            child: SizedBox(
              width: 160.h,
              child: Divider(
                color: MyTheme.accent_color,
                height: 0.4,
              ),
            ),
          ),
          Text(
            LangText(context: context).getLocal()!.or,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 10.h,
              bottom: 9.h,
            ),
            child: SizedBox(
              width: 160.h,
              child: Divider(
                color: MyTheme.accent_color,
                height: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildLoginWithGoogle(BuildContext context) {
    final authProvider = Provider.of<AuthViewModel>(context);

    return GestureDetector(
      onTap: () async {
        await authProvider.signInWithGoogle(context);
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: MyTheme.white,
                width: 0.6,
              ),
              color: MyTheme.accent_color),
          height: 50.h,
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
          width: ScreenUtil().screenWidth * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                ImageData.googleLogo,
                height: 20.h,
                width: 20.h,
              ),
              Text(
                LangText(context: context).getLocal()!.login_with_google,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: MyTheme.white),
              ),
            ],
          )
          //  OutlinedButton.icon(
          //   onPressed: () async {
          //     await authProvider.signInWithGoogle();
          //   },
          //   icon: Image.asset(
          //     ImageData.googleLogo,
          //     height: 10.h,
          //     width: 10.h,
          //   ),
          //   label: Text(LangText(context: context).getLocal()!.login_with_google),
          //   style: ButtonStyle(
          //     shape: MaterialStateProperty.all(
          //       RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10.r),
          //           side: BorderSide(color: MyTheme.accent_color, width: 2)),
          //     ),
          //   ),
          // ),
          ),
    );
  }

  /// Section Widget
  Widget _buildLoginWithFacebook(BuildContext context) {
    return CustomOutlinedButton(
      text: "msg_login_with_facebook",
      leftIcon: Container(
        margin: EdgeInsets.only(right: 30.h),
        child: CustomImageView(
          imagePath: ImageData.imgBagOnprimary,
          height: 24.h,
          width: 24.h,
        ),
      ),
    );
  }
}
