import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpl_ecommerce/const/app_bar.dart';
import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/customs/custom_badge_cart.dart';
import 'package:dpl_ecommerce/customs/custom_button_style.dart';
import 'package:dpl_ecommerce/customs/custom_elevate_button.dart';
import 'package:dpl_ecommerce/customs/custom_icon_button.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_outline_button.dart';
import 'package:dpl_ecommerce/customs/custom_photo_view.dart';
import 'package:dpl_ecommerce/customs/custom_radio_button.dart';
import 'package:dpl_ecommerce/customs/custom_rating_bar.dart';
import 'package:dpl_ecommerce/customs/custom_text_form_field.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/helpers/show_modal_bottom_sheet.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/product_in_cart_model.dart';
import 'package:dpl_ecommerce/models/review.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/repositories/flash_sale_repo.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/repositories/voucher_repo.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dpl_ecommerce/view_model/consumer/cart_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/product_detail_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/cart_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/test.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/list_voucher_widget.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_details_widgets/chip_view_item_widget.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_details_widgets/radio_button.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_details_widgets/slider_item_widget.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_small_list_item1_widget.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/review_elements/list_review_view.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/review_elements/review_view_page.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/review_elements/review_view_widget.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/video_item_widget.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/voucher_item_widget.dart';
import 'package:dpl_ecommerce/views/seller/screens/seller_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:badges/badges.dart' as badges;

// import 'package:flutter_screenutil/flutter_screenutil.dart';
class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage({Key? key, required this.product})
      : super(
          key: key,
        );
  Product? product;
  int sliderIndex = 1;

  TextEditingController editTextController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Voucher> listVoucher = VoucherRepo().list;
  List<Product>? listProduct = ProductRepo().list;
  Review review = Review(
      id: "Review01",
      productID: "product01",
      rating: 4.5,
      resourseType: ResourseType.image,
      text: "You are great",
      time: DateTime.now(),
      userAvatar:
          "https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg",
      userID: "user01");
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    // final cartProvider = Provider.of<CartViewModel>(context, listen: false);
    final productDetailProvider = Provider.of<ProductDetailViewModel>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: CustomArrayBackWidget(
            function: () => productDetailProvider.reset(),
          ),
          actions: [
            InkWell(
              onTap: () {},
              child: const Icon(Icons.favorite_outline),
            ),
            const SizedBox(width: 12),
            InkWell(
              onTap: () {},
              child: const Icon(Icons.share),
            ),
            const SizedBox(width: 12),
            Consumer<CartViewModel>(builder: (context, value, child) {
              return CustomBadgeCart(number: value.cart.productInCarts!.length);
            }),
            const SizedBox(width: 12),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: 5.v),
            child: Column(
              children: [
                _buildSlider(
                    context,
                    [
                      "https://drive.google.com/file/d/1RZ7zIBdX37F3axngfo4xLwU-GlLjKnhJ/view?usp=drive_link"
                    ],
                    product!.images!),
                SizedBox(height: 8.v),
                _buildAnimatedIndicator(sliderIndex: sliderIndex),
                SizedBox(height: 17.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.h),
                    child: Text(
                      "lbl_calvin_clein",
                      style: CustomTextStyles.bodySmallGray600,
                    ),
                  ),
                ),
                SizedBox(height: 9.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.h),
                      child: Text(
                        "Name product",
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                    Spacer(),
                    Padding(
                        padding: EdgeInsets.only(right: 16.h),
                        child: Text("Available products: ")),
                  ]),
                ),
                SizedBox(height: 8.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.h),
                    child: Row(
                      children: [
                        _buildButton(context),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 8.h,
                            top: 2.v,
                            bottom: 2.v,
                          ),
                          child: Text(
                            "87 reviews",
                            style: CustomTextStyles.bodySmallGray600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.v),
                _buildProductPrices(),
                SizedBox(height: 18.v),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: _buildSizeText(
                    context,
                    sizeLabel: "SIZES",
                    sizeChartLabel: "lbl_size_chart",
                  ),
                ),
                SizedBox(height: 6.v),
                _buildProductSize(context),
                SizedBox(height: 10.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: _buildSizeText(
                    context,
                    sizeLabel: "TYPES",
                    sizeChartLabel: "lbl_size_chart",
                  ),
                ),
                SizedBox(height: 6.v),
                _buildProductType(context),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: _buildSizeText(
                    context,
                    sizeLabel: "Colors",
                    sizeChartLabel: "lbl_size_chart",
                  ),
                ),
                SizedBox(height: 10.v),
                _buildProductColor(context),
                SizedBox(height: 24.v),
                _buildShopInfor(context),
                SizedBox(height: 24.v),
                ListVoucherWidget(list: listVoucher),
                SizedBox(height: 24.v),
                // _buildColumn(context),
                // SizedBox(height: 16.v),
                _buildProductDescription(context),
                SizedBox(height: 16.v),
                _buildRatingsAndReviews(context),
                SizedBox(height: 27.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: _buildSizeText(
                    context,
                    sizeLabel: "other shop's products",
                    sizeChartLabel: "view all",
                  ),
                ),
                SizedBox(height: 16.v),
                _buildShopProducts(context, listProduct!),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: _buildSizeText(
                    context,
                    sizeLabel: "you may like",
                    sizeChartLabel: "view all",
                  ),
                ),
                SizedBox(height: 16.v),
                _buildRelatedProducts(context, listProduct!),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildRow2(context),
      ),
    );
  }

  // Widget _buildMultimedia(BuildContext context,List<String>? videos,List<String> ){
  //   return
  // }
  /// Section Widget
  Widget _buildSlider(
      BuildContext context, List<String>? videos, List<String>? listImage) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12, width: 2),
      ),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          autoPlayAnimationDuration: const Duration(seconds: 1),
          autoPlayCurve: Curves.linear,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
          initialPage: 0,
          pageSnapping: true,
          height: 342.v,
          autoPlay: (videos == null) ? true : false,
          // autoPlay: true,
          viewportFraction: 1.0,
          enableInfiniteScroll: true,
          autoPlayInterval: const Duration(seconds: 4),
          scrollDirection: Axis.horizontal,
          onPageChanged: (
            index,
            reason,
          ) {
            sliderIndex = index;
          },
        ),
        itemCount: listImage!.length + videos!.length,
        itemBuilder: (context, index, realIndex) {
          if (videos != null && index < videos.length) {
            return VideoItemWidget(
              videoUrl: videos[index],
            );
          }
          return SliderItemWidget(
            urlImage: listImage[index - videos.length],
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildButton(BuildContext context) {
    return CustomElevatedButton(
      height: 20.v,
      width: 26.h,
      text: "lbl_4_12",
      leftIcon: Container(
        margin: EdgeInsets.only(right: 4.h),
        child: CustomImageView(
          imagePath: ImageData.imgIconBoldStar,
          height: 12.adaptSize,
          width: 12.adaptSize,
        ),
      ),
      // buttonStyle: CustomButtonStyles.fillAmber,
      buttonTextStyle: CustomTextStyles.labelLargeOnPrimaryContainer,
    );
  }

  /// Section Widget
  Widget _buildProductSize(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 16.h),
        child: Wrap(
          runSpacing: 8.v,
          spacing: 8.h,
          children: List<Widget>.generate(5, (index) => ChipviewItemWidget()),
        ),
      ),
    );
  }

  Widget _buildProductType(BuildContext context) {
    return Container(
      height: 50.h,
      padding: EdgeInsets.only(left: 16.h),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ChipviewItemWidget();
        },
        itemCount: 6,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _buildProductColor(BuildContext context) {
    return Container(
      height: 50.h,
      padding: EdgeInsets.only(left: 16.h),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ChipviewItemWidget();
        },
        itemCount: 6,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  /// Section Widget
  Widget _buildEditText(BuildContext context) {
    return Expanded(
      child: CustomTextFormField(
        controller: editTextController,
        hintText: "lbl_enter_pin_code",
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.number,
      ),
    );
  }

  /// Section Widget
  Widget _buildColumn(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.outlineBluegray7000f1.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 3.v),
          Text(
            "msg_delivery_options",
            style: theme.textTheme.bodyMedium,
          ),
          SizedBox(height: 11.v),
          Container(
            padding: EdgeInsets.all(16.h),
            decoration: AppDecoration.outlineBlueGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder8,
            ),
            child: Row(
              children: [
                _buildEditText(context),
                Padding(
                  padding: EdgeInsets.only(left: 12.h),
                  child: Text(
                    "lbl_check",
                    style: CustomTextStyles.labelLargePrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildProductDescription(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      padding: EdgeInsets.symmetric(vertical: 16.v),
      decoration: AppDecoration.outlineBluegray7000f1.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 2.v),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Text(
              "Product details",
              style: theme.textTheme.bodyMedium,
            ),
          ),
          SizedBox(height: 21.v),
          Padding(
            padding: EdgeInsets.only(left: 22.h),
            child: Column(
              children: [
                SizedBox(
                  width: 53.h,
                  child: Text(
                    "detail 1",
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.bodySmallGray600_1.copyWith(
                      height: 2.00,
                    ),
                  ),
                ),
                Container(
                  width: 87.h,
                  margin: EdgeInsets.only(left: 8.h),
                  child: Text(
                    "detail 2",
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall!.copyWith(
                      height: 2.00,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 17.v),
            decoration: AppDecoration.fillOnPrimaryContainer,
            child: Divider(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            child: _buildViewAllReviews(
              context,
              viewAllReviewsText: "See mmore",
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRatingButton(BuildContext context) {
    return CustomOutlinedButton(
      width: 80.h,
      text: "Rate",
      margin: EdgeInsets.only(bottom: 2.v),
    );
  }

  Widget _buildShopInfor(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      padding: EdgeInsets.symmetric(vertical: 16.v),
      decoration: AppDecoration.outlineBluegray7000f1.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 3.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              CachedNetworkImage(
                imageUrl:
                    "https://www.akamai.com/site/im-demo/media-viewer/01.jpg?imwidth=5000",
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: 60.h,
                    width: 60.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  );
                },
                placeholder: (context, url) => const Center(
                    child: SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator())),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Shop name",
                      style: CustomTextStyles.titleSmallMedium,
                    ),
                    SizedBox(height: 2.v),
                    Text(
                      "Address",
                      style: CustomTextStyles.bodySmallGray600,
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(right: 1.h),
              //   child:
              const SizedBox(
                width: 100,
              ),
              // OutlinedButton(
              //     onPressed: () {
              //       // go to shop profile
              //     },
              //     child: Text("See shop"))
              CustomOutlinedButton(
                text: "See shop",
                width: 90,
                height: 40.h,
                onPressed: () {
                  // go to shop profile
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ShopProfile(),
                  ));
                },
              ),
            ],
          ),

          SizedBox(height: 5.v),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 16.h),
          //   child:
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              height: 22,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "55 sản phẩm",
                    style: CustomTextStyles.titleSmallMedium,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "4.5 rating",
                    style: CustomTextStyles.titleSmallMedium,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "345 ratingCount",
                    style: CustomTextStyles.titleSmallMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRatingsAndReviews(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      padding: EdgeInsets.symmetric(vertical: 16.v),
      decoration: AppDecoration.outlineBluegray7000f1.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 3.v),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Text(
              "Ratings and Reivews",
              style: theme.textTheme.bodyMedium,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 17.v),
            decoration: AppDecoration.fillOnPrimaryContainer,
            child: Divider(),
          ),
          SizedBox(height: 3.v),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.v),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "4.8",
                            style: CustomTextStyles.headlineSmallOnPrimary,
                          ),
                          TextSpan(
                            text: "5",
                            style: CustomTextStyles.headlineSmallGray600,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "overall rating",
                          style: CustomTextStyles.titleSmallMedium,
                        ),
                        SizedBox(height: 2.v),
                        Text(
                          "574 ratings",
                          style: CustomTextStyles.bodySmallGray600,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  _buildRatingButton(context),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 17.v),
            decoration: AppDecoration.fillOnPrimaryContainer,
            child: Divider(),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 17.v),
            decoration: AppDecoration.fillOnPrimaryContainer,
            child: Divider(),
          ),
          ReviewViewWidget(review: review),
          _buildViewAllReviews(
            context,
            viewAllReviewsText: "View all 76 reviews",
          )
        ],
      ),
    );
  }

  Widget _buildShopProducts(BuildContext context, List<Product> list) {
    return SizedBox(
      height: 260,
      child: ListView.separated(
        padding: EdgeInsets.only(left: 16.h),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (
          context,
          index,
        ) {
          return SizedBox(
            width: 12.h,
          );
        },
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Productsmalllist1ItemWidget(
            product: list[index],
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildRelatedProducts(BuildContext context, List<Product> list) {
    return SizedBox(
      height: 260,
      child: ListView.separated(
        padding: EdgeInsets.only(left: 16.h),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (
          context,
          index,
        ) {
          return SizedBox(
            width: 12.h,
          );
        },
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Productsmalllist1ItemWidget(
            product: list[index],
          );
        },
      ),
    );
  }

  Widget _buildChatWithProduct(BuildContext context) {
    return CustomOutlinedButton(
      height: 48.v,
      width: 110.h,
      text: "Chat",
      buttonStyle: CustomButtonStyles.outlinePrimaryContainerTL8,
      buttonTextStyle: CustomTextStyles.titleMediumPrimaryContainer,
    );
  }

  /// Section Widget
  Widget _buildAddToCart(BuildContext context) {
    final cartProvider = Provider.of<CartViewModel>(context);
    final productDetailProvider = Provider.of<ProductDetailViewModel>(context);
    final size = MediaQuery.of(context).size;
    return CustomOutlinedButton(
      height: 48.v,
      width: 110.h,
      text: "Add to cart",
      onPressed: () {
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage(),));
        BottomSheetHelper.showBottomSheet(
            context: context,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    height: size.height * 0.1,
                    width: size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomImageView(
                          imagePath: product!.images![0],
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return Scaffold(
                                  appBar:
                                      AppBar(leading: CustomArrayBackWidget()),
                                  body: CustomPhotoView(
                                    urlImage: product!.images![0],
                                  ),
                                );
                              },
                            ));
                          },
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              product!.name!,
                              style: theme.textTheme.displayMedium,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              product!.availableQuantity.toString(),
                              style: theme.textTheme.labelLarge,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (product!.sizes != null) ...{
                    const Padding(
                      padding: EdgeInsets.only(top: 5, left: 25),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Sizes"),
                      ),
                    ),
                    CustomradioButton(
                        list: product!.sizes!, kindOfData: KindOfData.sizes),
                  },
                  if (product!.types != null) ...{
                    const Padding(
                      padding: EdgeInsets.only(top: 5, left: 25),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Types"),
                      ),
                    ),
                    CustomradioButton(
                        list: product!.types!, kindOfData: KindOfData.types),
                  },
                  if (product!.colors != null) ...{
                    const Padding(
                      padding: EdgeInsets.only(top: 5, left: 25),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Colors"),
                      ),
                    ),
                    CustomradioButton(
                        list: product!.colors!, kindOfData: KindOfData.colors),
                  },
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Number",
                          style: theme.textTheme.headlineLarge,
                        ),
                        Spacer(),
                        CustomIconButton(
                          width: 28,
                          height: 28,
                          child: Container(
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.1)),
                              child: Icon(
                                Icons.remove,
                                size: 20,
                              )),
                          onTap: () {
                            // minus
                            print("decrease number");
                            productDetailProvider.decreaseNumber();
                          },
                        ),
                        Container(
                          width: 58,
                          padding: EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 6,
                          ),
                          decoration: AppDecoration.outlineBlueGray,
                          child: Consumer<ProductDetailViewModel>(
                            builder: (context, value, child) {
                              return Center(
                                child: Text(
                                  value.choseNumber.toString(),
                                  style: CustomTextStyles.bodyMediumGray600,
                                ),
                              );
                            },
                          ),
                        ),
                        CustomIconButton(
                          width: 28,
                          height: 28,
                          child: Container(
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.1)),
                              child: Icon(
                                Icons.add,
                                size: 20,
                              )),
                          onTap: () {
                            // increase
                            print("increase number");
                            productDetailProvider.increaseNumner();
                          },
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: size.width * 0.9,
                    child: Consumer<ProductDetailViewModel>(
                      builder: (context, value, child) {
                        return ElevatedButton(
                            onPressed: () {
                              ProductInCartModel productInCartModel =
                                  ProductInCartModel(
                                      cost: product!.price!,
                                      quantity: value.choseNumber,
                                      color: value.color,
                                      currencyID: "currencyID01",
                                      productID: product!.id,
                                      productImage: product!.images![0],
                                      productName: product!.name!,
                                      voucherID: "voucherID01",
                                      userID: "userID01",
                                      size: value.size,
                                      createdAt: DateTime.now(),
                                      type: value.type);
                              cartProvider.addToCart(productInCartModel);
                              productDetailProvider.reset();
                              Navigator.of(context).pop();
                            },
                            child: const Text("Add to cart"));
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            height: size.height * 0.6,
            width: double.infinity);
        // cartProvider.addToCart(product);
      },
      buttonStyle: CustomButtonStyles.outlinePrimaryContainerTL8,
      buttonTextStyle: CustomTextStyles.titleMediumPrimaryContainer,
    );
  }

  /// Section Widget
  Widget _buildBuyNow(BuildContext context) {
    return CustomElevatedButton(
      height: 48.v,
      width: 110.h,
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return Profilepage();
          },
        ));
      },
      text: "Buy now",
      // margin: EdgeInsets.only(left: 16.h),
      buttonStyle: CustomButtonStyles.fillPrimaryContainer,
      buttonTextStyle: theme.textTheme.titleMedium!,
    );
  }

  /// Section Widget
  Widget _buildRow2(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 5.h,
        right: 5.h,
        bottom: 10.v,
      ),
      decoration: AppDecoration.outlineBluegray7000f,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildChatWithProduct(context),
          _buildAddToCart(context),
          _buildBuyNow(context),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildSizeText(
    BuildContext context, {
    required String sizeLabel,
    required String sizeChartLabel,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          sizeLabel,
          style: theme.textTheme.titleSmall!.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
        Text(
          sizeChartLabel,
          style: CustomTextStyles.labelLargeGray600.copyWith(
            decoration: TextDecoration.underline,
            color: appTheme.gray600,
          ),
        ),
      ],
    );
  }

  /// Common widget
  Widget _buildViewAllReviews(
    BuildContext context, {
    required String viewAllReviewsText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.v),
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ReviewPage(),
              ));
            },
            child: Text(
              viewAllReviewsText,
              style: CustomTextStyles.labelLargePrimaryContainer.copyWith(
                color: theme.colorScheme.primaryContainer,
              ),
            ),
          ),
        ),
        // CustomImageView(
        //   imagePath: ImageData.imgArrowRight,
        //   height: 24.adaptSize,
        //   width: 24.adaptSize,
        // ),
      ],
    );
  }
}

class _buildAnimatedIndicator extends StatelessWidget {
  const _buildAnimatedIndicator({
    super.key,
    required this.sliderIndex,
  });

  final int sliderIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 6.v,
      child: AnimatedSmoothIndicator(
        activeIndex: sliderIndex,
        count: 1,
        axisDirection: Axis.horizontal,
        effect: ScrollingDotsEffect(
          spacing: 8,
          activeDotColor: theme.colorScheme.primaryContainer,
          dotColor: appTheme.gray200,
          dotHeight: 6.v,
          dotWidth: 6.h,
        ),
      ),
    );
  }
}

class _buildProductPrices extends StatelessWidget {
  const _buildProductPrices({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 16.h),
        child: Row(
          children: [
            Text(
              "350000VND",
              style: theme.textTheme.titleSmall,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 4.h,
                top: 3.v,
              ),
              child: Text(
                "400000VND",
                style: theme.textTheme.labelMedium!.copyWith(
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 4.h,
                top: 3.v,
              ),
              child: Text(
                "15% off",
                style: CustomTextStyles.labelMediumOrange900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _buildHeader extends StatelessWidget {
  const _buildHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      width: 320.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
          const SizedBox(
            width: 160,
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            child: InkWell(
              onTap: () {},
              child: const Icon(Icons.favorite_outline),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            child: InkWell(
              onTap: () {},
              child: Icon(Icons.share),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            child: InkWell(
              onTap: () {},
              child: Icon(CupertinoIcons.cart),
            ),
          )
        ],
      ),
    );
  }
}
