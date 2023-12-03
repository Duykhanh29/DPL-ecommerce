import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/helpers/show_modal_bottom_sheet.dart';
import 'package:dpl_ecommerce/models/chat.dart';
import 'package:dpl_ecommerce/models/message.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/product_in_cart_model.dart';
import 'package:dpl_ecommerce/models/review.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/repositories/auth_repo.dart';
import 'package:dpl_ecommerce/repositories/cart_repo.dart';
import 'package:dpl_ecommerce/repositories/flash_sale_repo.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/repositories/review_repo.dart';
import 'package:dpl_ecommerce/repositories/shop_repo.dart';
import 'package:dpl_ecommerce/repositories/user_repo.dart';
import 'package:dpl_ecommerce/repositories/voucher_repo.dart';
import 'package:dpl_ecommerce/utils/common/common_caculated_methods.dart';
import 'package:dpl_ecommerce/utils/common/common_methods.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dpl_ecommerce/view_model/auth_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/cart_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/chat_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/product_detail_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/cart_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/chat_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/chatting_page.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/voucher_widgets/list_voucher_widget.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_details_widgets/chip_view_item_widget.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_details_widgets/radio_button.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_details_widgets/slider_item_widget.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_small_list_item1_widget.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/review_elements/list_review_view.dart';
import 'package:dpl_ecommerce/views/consumer/screens/review_view_page.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/review_elements/review_view_widget.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/video_item_widget.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/voucher_widgets/voucher_item_widget.dart';
import 'package:dpl_ecommerce/views/consumer/screens/shop_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:badges/badges.dart' as badges;

// import 'package:flutter_screenutil/flutter_screenutil.dart';
class ProductDetailsPage extends StatefulWidget {
  ProductDetailsPage({Key? key, required this.product})
      : super(
          key: key,
        );
  Product? product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int sliderIndex = 1;

  TextEditingController editTextController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();
  List<Voucher>? listVoucher;
  late List<Shop>? listShop;
  List<Product>? listShopProduct;
  List<Product>? listRelatedProduct;

  // repos
  ProductRepo productRepo = ProductRepo();
  VoucherRepo voucherRepo = VoucherRepo();
  ShopRepo shopRepo = ShopRepo();
  UserRepo userRepo = UserRepo();
  CartRepo cartRepo = CartRepo();

  Shop? shop;
  UserModel? seller;

  // loading
  bool isLoadingShop = true;
  bool isLoadingShopProduct = true;
  bool isLoadingRelatedProduct = true;
  bool isLoadingVoucher = true;
  bool isLoadingListUser = true;
  bool isLoadingSeller = true;
  //lists
  // UserModel userModel = AuthRepo().user;
  List<UserModel>? listUser;
  List<Review>? listReview;
  ReviewRepo reviewRepo = ReviewRepo();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    listShop = await shopRepo.getListShop();
    shop = CommondMethods.getShopByID(widget.product!.shopID!, listShop!);
    if (listShop != null && shop != null) {
      setState(() {
        isLoadingShop = false;
      });
    }
    listShopProduct =
        await shopRepo.getListProductByShopID(widget.product!.shopID!);
    if (listShopProduct != null) {
      setState(() {
        isLoadingShopProduct = false;
      });
    }
    listVoucher = await voucherRepo
        .getListVoucherByProduct(widget.product!.id!)
        .then((value) {
      setState(() {
        isLoadingVoucher = false;
      });
    });

    listRelatedProduct = await productRepo
        .getListRelatedProduct(widget.product!.categoryID!)
        .then((value) {
      setState(() {
        isLoadingRelatedProduct = false;
      });
    });

    listUser = await userRepo.getListUser();
    if (listUser != null) {
      setState(() {
        isLoadingListUser = false;
      });
    }

    seller =
        CommondMethods.getUserModelByShopID(widget.product!.shopID!, listUser!);
    if (seller != null) {
      setState(() {
        isLoadingSeller = false;
      });
    }
  }

  // Review review = Review(
  //     id: "Review01",
  //     productID: "product01",
  //     rating: 4.5,
  //     resourseType: ResourseType.image,
  //     text: "You are great",
  //     time: Timestamp.fromDate(DateTime.now()),
  //     userAvatar:
  //         "https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg",
  //     userID: "user01");

  @override
  Widget build(BuildContext context) {
    // final cartProvider = Provider.of<CartViewModel>(context, listen: false);
    final productDetailProvider = Provider.of<ProductDetailViewModel>(context);
    // Shop? shop = CommondMethods.getShopByID(widget.product!.shopID!, listShop);
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
            Consumer<CartViewModel>(
              builder: (context, value, child) {
                // if (authValue.currentUser != null) {
                //   return StreamBuilder(
                //     stream: firestoreDatabase
                //         .getCartByUser(authValue.currentUser!.id!),
                //     builder: (context, snapshot) {
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return Center(
                //           child: CircularProgressIndicator(),
                //         );
                //       } else {
                //         if (snapshot.data != null) {
                return CustomBadgeCart(
                    number: value.cart!.productInCarts!.length);
                //         } else {
                //           return CustomBadgeCart(number: 0);
                //         }
                //       }
                //     },
                //   );
                // } else {
                //   return CustomBadgeCart(number: 0);
                // }
              },
            ),
            // Consumer<CartViewModel>(builder: (context, value, child) {
            //   return CustomBadgeCart(number: value.cart.productInCarts!.length);
            // }),
            const SizedBox(width: 12),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Column(
              children: [
                _buildSlider(
                    context: context,
                    listImage: widget.product!.images,
                    videos: widget.product!.videos),
                SizedBox(height: 8.h),
                _buildAnimatedIndicator(sliderIndex: sliderIndex), // fix
                SizedBox(height: 17.h),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Padding(
                //     padding: EdgeInsets.only(left: 16.h),
                //     child: Text(
                //       "lbl_calvin_clein",
                //       style: CustomTextStyles.bodySmallGray600,
                //     ),
                //   ),
                // ),
                SizedBox(height: 9.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.h),
                      child: Text(
                        widget.product!.name!,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Spacer(),
                    Padding(
                        padding: EdgeInsets.only(right: 16.h),
                        child: Text(
                            "Available products: ${widget.product!.availableQuantity}")),
                  ]),
                ),
                SizedBox(height: 8.h),

                if (widget.product!.reviewIDs != null) ...{
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
                              top: 2.h,
                              bottom: 2.h,
                            ),
                            child: Text(
                              "${widget.product!.reviewIDs!.length} reviews",
                              style: CustomTextStyles.bodySmallGray600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                },
                SizedBox(height: 10.h),
                _buildProductPrices(),
                SizedBox(height: 18.h),

                if (widget.product!.sizes != null) ...{
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: _buildSizeText(
                      context,
                      sizeLabel: "sizes",
                      sizeChartLabel: "",
                    ),
                  ),
                  SizedBox(height: 6.h),
                  _buildProductSize(context, widget.product!.sizes!),
                },
                if (widget.product!.types != null) ...{
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: _buildSizeText(
                      context,
                      sizeLabel: "types",
                      sizeChartLabel: "",
                    ),
                  ),
                  SizedBox(height: 6.h),
                  _buildProductType(context, widget.product!.types!),
                },

                if (widget.product!.colors != null) ...{
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: _buildSizeText(
                      context,
                      sizeLabel: "Colors",
                      sizeChartLabel: "",
                    ),
                  ),
                  SizedBox(height: 10.h),
                  _buildProductColor(context, widget.product!.colors!),
                },

                SizedBox(height: 24.h),
                isLoadingShop ? Container() : _buildShopInfor(context, shop),
                SizedBox(height: 24.h),
                isLoadingVoucher
                    ? Container()
                    : listVoucher != null
                        ? ListVoucherWidget(list: listVoucher!)
                        : Container(),
                SizedBox(height: 24.h),
                // _buildColumn(context),
                // SizedBox(height: 16.h),
                if (widget.product!.description != null) ...{
                  _buildProductDescription(context),
                },

                SizedBox(height: 16.h),
                _buildRatingsAndReviews(context, widget.product!),
                SizedBox(height: 27.h),

                SizedBox(height: 16.h),
                isLoadingShopProduct
                    ? Container()
                    : Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 5.h),
                            child: _buildSizeText(
                              context,
                              sizeLabel: "other shop's products",
                              sizeChartLabel: "view all",
                            ),
                          ),
                          _buildShopProducts(context, listShopProduct!),
                        ],
                      ),

                SizedBox(height: 16.h),
                isLoadingRelatedProduct
                    ? Container()
                    : listRelatedProduct != null
                        ? Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.h),
                                child: _buildSizeText(
                                  context,
                                  sizeLabel: "you may like",
                                  sizeChartLabel: "view all",
                                ),
                              ),
                              _buildRelatedProducts(
                                  context, listRelatedProduct!),
                            ],
                          )
                        : const SizedBox(),
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

  /// Section Widget
  Widget _buildSlider(
      {required BuildContext context,
      List<String>? videos,
      List<String>? listImage}) {
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
          height: 342.h,
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
        itemCount: videos != null
            ? listImage!.length + videos!.length
            : listImage!.length,
        itemBuilder: (context, index, realIndex) {
          if (videos != null && index < videos.length) {
            return VideoItemWidget(
              videoUrl: videos[index],
            );
          }
          return SliderItemWidget(
            urlImage: videos != null
                ? listImage[index - videos!.length]
                : listImage[index],
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildButton(BuildContext context) {
    return CustomElevatedButton(
      height: 20.h,
      width: 26.h,
      text: "lbl_4_12",
      leftIcon: Container(
        margin: EdgeInsets.only(right: 4.h),
        child: CustomImageView(
          imagePath: ImageData.imgIconBoldStar,
          height: 12.h,
          width: 12.h,
        ),
      ),
      // buttonStyle: CustomButtonStyles.fillAmber,
      buttonTextStyle: CustomTextStyles.labelLargeOnPrimaryContainer,
    );
  }

  /// Section Widget
  Widget _buildProductSize(BuildContext context, List<String> list) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 16.h),
        child: Wrap(
          runSpacing: 8.h,
          spacing: 8.h,
          children: List<Widget>.generate(
              list.length,
              (index) => ChipviewItemWidget(
                    title: list[index],
                  )),
        ),
      ),
    );
  }

  Widget _buildProductType(BuildContext context, List<String>? list) {
    return Container(
      height: 50.h,
      padding: EdgeInsets.only(left: 16.h),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ChipviewItemWidget(title: list[index]);
        },
        itemCount: list!.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _buildProductColor(BuildContext context, List<String>? list) {
    return Container(
      height: 50.h,
      padding: EdgeInsets.only(left: 16.h),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ChipviewItemWidget(
            title: list[index],
          );
        },
        itemCount: list!.length,
        scrollDirection: Axis.horizontal,
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
          SizedBox(height: 3.h),
          Text(
            "msg_delivery_options",
            style: theme.textTheme.bodyMedium,
          ),
          SizedBox(height: 11.h),
          Container(
            padding: EdgeInsets.all(16.h),
            decoration: AppDecoration.outlineBlueGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder8,
            ),
            child: Row(
              children: [
                // _buildEditText(context),
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
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: AppDecoration.outlineBluegray7000f1.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Text(
              "Product details",
              style: theme.textTheme.bodyMedium,
            ),
          ),
          SizedBox(height: 21.h),
          Padding(
            padding: EdgeInsets.only(left: 22.w),
            child: Column(
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 44.w) * 0.8,
                  child: Text(
                    widget.product!.description!,
                    overflow: TextOverflow.clip,
                    maxLines: 6,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 17.h),
            decoration: AppDecoration.fillOnPrimaryContainer,
            child: Divider(),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 16.h),
          //   child: _buildViewAllReviews(
          //     context,
          //     viewAllReviewsText: "See mmore",
          //   ),
          // ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRatingButton(BuildContext context) {
    return CustomOutlinedButton(
      width: 80.h,
      text: "Rate",
      margin: EdgeInsets.only(bottom: 2.h),
    );
  }

  Widget _buildShopInfor(BuildContext context, Shop? shop) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: AppDecoration.outlineBluegray7000f1.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 3.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              shop!.logo != null
                  ? CachedNetworkImage(
                      imageUrl: shop.logo!,
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
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                  : Image.asset(ImageData.placeHolderImg),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shop.name != null ? shop.name! : "",
                      style: CustomTextStyles.titleSmallMedium,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      shop.addressInfor!.city != null
                          ? shop.addressInfor!.city!
                          : "",
                      style: CustomTextStyles.bodySmallGray600,
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(right: 1.h),
              //   child:
              Spacer(),
              // OutlinedButton(
              //     onPressed: () {
              //       // go to shop profile
              //     },
              //     child: Text("See shop"))
              CustomOutlinedButton(
                text: "See shop",
                width: 90.w,
                height: 40.h,
                onPressed: () {
                  // go to shop profile

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ShopProfile(shop: shop),
                  ));
                },
              ),
              SizedBox(width: 20.w),
            ],
          ),

          SizedBox(height: 5.h),
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
                    "${shop.totalProduct} products",
                    style: CustomTextStyles.titleSmallMedium,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "${shop.rating} rating",
                    style: CustomTextStyles.titleSmallMedium,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "${shop.ratingCount} rating count",
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
  Widget _buildRatingsAndReviews(BuildContext context, Product product) {
    // List<Review>? list = [];
    // if (product.reviewIDs != null) {
    //   list = CommondMethods.getListReview(product.reviewIDs!, listReview);
    // }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: AppDecoration.outlineBluegray7000f1.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 3.h),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Text(
              "Ratings and Reivews",
              style: theme.textTheme.bodyMedium,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 17.h),
            decoration: AppDecoration.fillOnPrimaryContainer,
            child: Divider(),
          ),
          SizedBox(height: 3.h),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: product.rating != null
                                ? product.rating.toString()
                                : "",
                            style: CustomTextStyles.headlineSmallOnPrimary,
                          ),
                          TextSpan(
                            text: product.rating != null ? "/5" : "",
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
                        SizedBox(height: 2.h),
                        Text(
                          "${product.ratingCount} ratings",
                          style: CustomTextStyles.bodySmallGray600,
                        ),
                      ],
                    ),
                  ),
                  // const Spacer(),
                  // _buildRatingButton(context),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 17.h),
            decoration: AppDecoration.fillOnPrimaryContainer,
            child: Divider(),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 17.h),
            decoration: AppDecoration.fillOnPrimaryContainer,
            child: Divider(),
          ),
          StreamBuilder<List<Review>?>(
            stream:
                firestoreDatabase.getAllReviewByProduct(widget.product!.id!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                print("object empty");
                return Center(
                  child: Text("object empty"),
                );
              } else {
                if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                  List<Review>? list = snapshot.data;
                  return Container(
                    height: 80.h,
                    child: Column(
                      children: [
                        ReviewViewWidget(review: list!.last),
                        if (product.reviewIDs!.length > 1) ...{
                          _buildViewAllReviews(context,
                              viewAllReviewsText:
                                  "view all ${product.reviewIDs!.length}",
                              list: list!)
                        },
                      ],
                    ),
                  );
                } else {
                  print("object empty");
                  return const SizedBox();
                }
              }
            },
          ),
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
    final chatProvider = Provider.of<ChatViewModel>(context);
    List<Chat> listChat = chatProvider.list;
    final userViewModel = Provider.of<AuthViewModel>(context);
    final usermodel = userViewModel.currentUser;
    return CustomOutlinedButton(
      onPressed: () {
        Chat? chat;
        Message msg = Message(
            chatType: ChatType.text,
            isShop: false,
            productID: widget.product!.id,
            receiverID: seller!.id,
            senderID: usermodel!.id,
            time: Timestamp.fromDate(DateTime.now()));
        if (!CommondMethods.hasConversation(
            usermodel.id!, seller!.id!, listChat)) {
          chat = Chat(
            listMsg: [],
            sellerID: seller!.id,
            shopID: widget.product!.shopID,
            shopLogo: widget.product!.shopLogo,
            shopName: widget.product!.shopName,
            userAvatar: usermodel.avatar,
            userID: usermodel.id,
            userName: usermodel.firstName,
          );
          chatProvider.addNewChat(chat);
        } else {
          chat = CommondMethods.getChatByuserAndSeller(
              seller!.id!, usermodel.id!, listChat);
        }
        chatProvider.sendMsgToAChatBox(msg, chat!.id!);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return ChattingPage(chat: chat);
          },
        ));
      },
      height: 48.h,
      width: 80.h,
      text: "Chat",
      buttonStyle: CustomButtonStyles.outlinePrimaryContainerTL8,
      buttonTextStyle: CustomTextStyles.titleMediumPrimaryContainer,
    );
  }

  /// Section Widget
  Widget _buildAddToCart(BuildContext context) {
    final cartProvider = Provider.of<CartViewModel>(context);
    final productDetailProvider = Provider.of<ProductDetailViewModel>(context);
    // productDetailProvider.initialize(
    //   firstColor:
    //       widget.product!.colors != null ? widget.product!.colors![0] : null,
    //   firstSize:
    //       widget.product!.sizes != null ? widget.product!.sizes![0] : null,
    //   firstType:
    //       widget.product!.types != null ? widget.product!.types![0] : null,
    // );
    final size = MediaQuery.of(context).size;
    final userModel = Provider.of<AuthViewModel>(context).currentUser;
    return CustomOutlinedButton(
      height: 48.h,
      width: 110.w,
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
                          imagePath: widget.product!.images![0],
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return Scaffold(
                                  appBar:
                                      AppBar(leading: CustomArrayBackWidget()),
                                  body: CustomPhotoView(
                                    urlImage: widget.product!.images![0],
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
                              widget.product!.name!,
                              style: theme.textTheme.displayMedium,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              widget.product!.availableQuantity.toString(),
                              style: theme.textTheme.labelLarge,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (widget.product!.sizes != null) ...{
                    const Padding(
                      padding: EdgeInsets.only(top: 5, left: 25),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Sizes"),
                      ),
                    ),
                    CustomradioButton(
                        list: widget.product!.sizes!,
                        kindOfData: KindOfData.sizes),
                  },
                  if (widget.product!.types != null) ...{
                    const Padding(
                      padding: EdgeInsets.only(top: 5, left: 25),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Types"),
                      ),
                    ),
                    CustomradioButton(
                        list: widget.product!.types!,
                        kindOfData: KindOfData.types),
                  },
                  if (widget.product!.colors != null) ...{
                    const SizedBox(
                      width: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 5, left: 25),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Colors"),
                      ),
                    ),
                    CustomradioButton(
                        list: widget.product!.colors!,
                        kindOfData: KindOfData.colors),
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
                              // ProductInCartModel productInCartModel =
                              //     ProductInCartModel(
                              //         cost: widget.product!.price!,
                              //         quantity: value.choseNumber,
                              //         color: value.color,
                              //         currencyID: "currencyID01",
                              //         productID: widget.product!.id,
                              //         productImage: widget.product!.images![0],
                              //         productName: widget.product!.name!,
                              //         voucherID: "voucherID01",
                              //         userID: "userID01",
                              //         size: value.size,
                              //         createdAt:
                              //             Timestamp.fromDate(DateTime.now()),
                              //         type: value.type);
                              ProductInCartModel productInCartModel =
                                  ProductInCartModel(
                                      cost: widget.product!.price!,
                                      quantity: value.choseNumber,
                                      color: widget.product!.colors != null
                                          ? (value.color ??
                                              widget.product!.colors![0])
                                          : null,
                                      currencyID: "704",
                                      productID: widget.product!.id,
                                      productImage: widget.product!.images![0],
                                      productName: widget.product!.name!,
                                      voucherID: value.voucherIDs != null
                                          ? value.voucherIDs![0]
                                          : null,
                                      userID: userModel!.id!,
                                      size: widget.product!.sizes != null
                                          ? (value.size ??
                                              widget.product!.sizes![0])
                                          : null,
                                      createdAt:
                                          Timestamp.fromDate(DateTime.now()),
                                      type: widget.product!.types != null
                                          ? (value.type ??
                                              widget.product!.types![0])
                                          : null);
                              cartProvider.addToCart(productInCartModel);
                              int savingCost = 0;
                              if (value.voucherIDs != null) {
                                Voucher? voucher =
                                    CommondMethods.getVoucherFromID(
                                        listVoucher!, value.voucherIDs![0]);
                                if (voucher != null) {
                                  savingCost =
                                      CommonCaculatedMethods.caculateSavignCost(
                                          voucher, widget.product!.price!);
                                }
                              }
                              cartRepo.addToCart(
                                  uid: userModel.id!,
                                  productInCartModel: productInCartModel,
                                  savingCost: savingCost);
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
      height: 48.h,
      width: 130.h,
      onPressed: () {},
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
        bottom: 10.h,
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
  Widget _buildViewAllReviews(BuildContext context,
      {required String viewAllReviewsText, required List<Review> list}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ReviewPage(list: list),
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
      height: 6.h,
      child: AnimatedSmoothIndicator(
        activeIndex: sliderIndex,
        count: 1,
        axisDirection: Axis.horizontal,
        effect: ScrollingDotsEffect(
          spacing: 8,
          activeDotColor: theme.colorScheme.primaryContainer,
          dotColor: appTheme.gray200,
          dotHeight: 6.h,
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
                top: 3.h,
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
                top: 3.h,
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
