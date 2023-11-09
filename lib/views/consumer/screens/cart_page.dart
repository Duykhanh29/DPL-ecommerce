import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_button_style.dart';
import 'package:dpl_ecommerce/customs/custom_elevate_button.dart';
import 'package:dpl_ecommerce/customs/custom_text_form_field.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/cart_widgets/product_cart_item.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_details_widgets/product_detail_page.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class CartPage extends StatelessWidget {
  CartPage({Key? key})
      : super(
          key: key,
        );

  TextEditingController cuponCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillOnPrimaryContainer,
          child: Column(
            children: [
              _buildYourCart(context),
              SizedBox(height: 16),
              _buildProductDetails(context),
              SizedBox(height: 32),
              _buildCuponForm(context), // replace by other CuponWidget
              SizedBox(height: 16),
              _buildTotalPrice1(context),
              // SizedBox(height: 16),
              Spacer(),
              CustomElevatedButton(
                onPressed: () {
                  // go to order page
                },
                text: "check_out",
                margin: EdgeInsets.symmetric(horizontal: 16),
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildYourCart(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 26,
      ),
      decoration: AppDecoration.fillOnPrimaryContainer,
      child: Text(
        "Your cart",
        style: CustomTextStyles.titleMediumOnPrimary,
      ),
    );
  }

  /// Section Widget
  Widget _buildProductDetails(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (
          context,
          index,
        ) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              width: double.maxFinite,
              child: Divider(
                height: 1,
                thickness: 1,
                color: appTheme.blueGray7000f,
              ),
            ),
          );
        },
        itemCount: 12,
        itemBuilder: (context, index) {
          return ProductCartItem();
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildCuponForm(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: AppDecoration.outlineBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              top: 20,
              bottom: 17,
            ),
            child: CustomTextFormField(
              width: 227,
              controller: cuponCodeController,
              hintText: "msg_enter_cupon_code",
              hintStyle: theme.textTheme.bodySmall!,
              textInputAction: TextInputAction.done,
            ),
          ),
          CustomElevatedButton(
            width: 87,
            text: "lbl_apply",
            margin: EdgeInsets.only(left: 12),
            buttonStyle: CustomButtonStyles.fillPrimary,
            buttonTextStyle: CustomTextStyles.labelLargeOnPrimaryContainer,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTotalPrice1(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.all(15),
      decoration: AppDecoration.outlineBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder2,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildShipping(
            context,
            shippingLabel: "Items(3)",
            priceLabel: "234VND",
          ),
          SizedBox(height: 16),
          _buildShipping(
            context,
            shippingLabel: "shipping",
            priceLabel: "40_00",
          ),
          SizedBox(height: 14),
          _buildShipping(
            context,
            shippingLabel: "import_charges",
            priceLabel: "128_00",
          ),
          SizedBox(height: 12),
          Divider(),
          SizedBox(height: 10),
          _buildShipping(
            context,
            shippingLabel: "total_price",
            priceLabel: "766_86",
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildShipping(
    BuildContext context, {
    required String shippingLabel,
    required String priceLabel,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 1),
          child: Text(
            shippingLabel,
            style: theme.textTheme.bodySmall!.copyWith(
              color: appTheme.blueGray300,
            ),
          ),
        ),
        Text(
          priceLabel,
          style: CustomTextStyles.bodyMediumGray600.copyWith(
            color: theme.colorScheme.onPrimary.withOpacity(1),
          ),
        ),
      ],
    );
  }
}
