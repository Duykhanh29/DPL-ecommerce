import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_elevate_button.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_outline_button.dart';
import 'package:dpl_ecommerce/customs/custom_text_form_field.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/helpers/validators.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:email_validator/email_validator.dart';

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
            children: [
              SizedBox(
                height: 15.h,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Image.network(
                  "https://media.istockphoto.com/id/546763388/photo/the-perfect-vantage-point.jpg?s=170667a&w=0&k=20&c=KcEe8bcUUAheYpdzIJ52Tk2N4ZY3OAtFRBjFCqI7Aq8=",
                  width: 120.h,
                  height: 120.h,
                ),
              ),
              SizedBox(height: 17.h),
              Text(
                "Welcome to DPL Ecommerce",
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: 9.h),
              Text(
                "sign in to continue",
                style: theme.textTheme.bodySmall,
              ),
              SizedBox(height: 28.h),
              // _buildEmail(context),
              // SizedBox(height: 8.h),
              // _buildPassword(context),
              SizedBox(height: 16.h),
              _buildSignIn(context),
              SizedBox(height: 20.h),
              _buildOrLine(context),
              SizedBox(height: 16.h),
              _buildLoginWithGoogle(context),
              // SizedBox(height: 8.h),
              // _buildLoginWithFacebook(context),
              SizedBox(height: 17.h),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "forgot password",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 7.h),
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
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumber(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value == '') {
          return "Please input again";
        } else {
          Validators.validatePhone(value);
        }
      },
      controller: emailController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          hintText: "Your phone",
          prefixIcon: const Icon(Icons.email_rounded)),
      keyboardType: TextInputType.phone,
    );
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value == '') {
          return "Please input again";
        } else {
          Validators.isValidEmail(value);
        }
      },
      controller: emailController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          hintText: "Your email",
          prefixIcon: const Icon(Icons.email_rounded)),
      keyboardType: TextInputType.emailAddress,
    );
  }

  /// Section Widget
  Widget _buildPassword(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value == '') {
          return "Please input again";
        } else if (value.length < 6) {
          return "Password contains at least 6 characters";
        } else {
          return null;
        }
      },
      controller: passwordController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          hintText: "password",
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
        child: const Text("Sign In"),
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)))),
      ),
    );
  }

  /// Section Widget
  Widget _buildOrLine(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 10.h,
            bottom: 9.h,
          ),
          child: SizedBox(
            width: 160.h,
            child: Divider(),
          ),
        ),
        const Text(
          "or",
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 10.h,
            bottom: 9.h,
          ),
          child: SizedBox(
            width: 160.h,
            child: Divider(),
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildLoginWithGoogle(BuildContext context) {
    return Container(
      height: 50.h,
      width: ScreenUtil().screenWidth * 0.9,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: Image.asset(
          ImageData.googleLogo,
          height: 10.h,
          width: 10.h,
        ),
        label: Text("Login with Google"),
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)))),
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
