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
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/chat.dart';
import 'package:dpl_ecommerce/models/favourite_product.dart';
import 'package:dpl_ecommerce/models/message.dart';
import 'package:dpl_ecommerce/models/order_model.dart' as orderModel;
import 'package:dpl_ecommerce/models/ordering_product.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/product_in_cart_model.dart';
import 'package:dpl_ecommerce/models/review.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/repositories/auth_repo.dart';
import 'package:dpl_ecommerce/repositories/cart_repo.dart';
import 'package:dpl_ecommerce/repositories/chat_repo.dart';
import 'package:dpl_ecommerce/repositories/flash_sale_repo.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/repositories/review_repo.dart';
import 'package:dpl_ecommerce/repositories/shop_repo.dart';
import 'package:dpl_ecommerce/repositories/user_repo.dart';
import 'package:dpl_ecommerce/repositories/voucher_repo.dart';
import 'package:dpl_ecommerce/repositories/wishlist_repo.dart';
import 'package:dpl_ecommerce/utils/common/common_caculated_methods.dart';
import 'package:dpl_ecommerce/utils/common/common_methods.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/address_view_model.dart';
import 'package:dpl_ecommerce/view_model/auth_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/cart_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/chat_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/checkout_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/product_detail_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/cart_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/chat_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/chatting_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/checkout.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/checkout/radio_button1.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
class ProductDetailsPage extends StatefulWidget {
  ProductDetailsPage({Key? key, required this.id})
      : super(
          key: key,
        );
  String id;

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
  List<Product>? allProduct;
  Product? product;
  // repos
  ProductRepo productRepo = ProductRepo();
  VoucherRepo voucherRepo = VoucherRepo();
  ShopRepo shopRepo = ShopRepo();
  UserRepo userRepo = UserRepo();
  CartRepo cartRepo = CartRepo();
  ChatRepo chatRepo = ChatRepo();

  Shop? shop;
  UserModel? seller;

  // loading
  bool isLoadingShop = true;
  bool isLoadingShopProduct = true;
  bool isLoadingRelatedProduct = true;
  bool isLoadingVoucher = true;
  bool isLoadingListUser = true;
  bool isLoadingSeller = true;
  bool isLoadingProduct = true;
  bool isLoadingFavouriteIcon = true;
  //lists
  // UserModel userModel = AuthRepo().user;
  List<UserModel>? listUser;
  List<Review>? listReview;
  ReviewRepo reviewRepo = ReviewRepo();
  WishListRepo wishListRepo = WishListRepo();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllData();
  }

  Future<void> fetchProduct() async {
    product = await productRepo.getProductByID(widget.id);
    setState(() {
      isLoadingProduct = false;
    });
  }

  void reset() {
    listUser = [];
    listReview = [];
    listVoucher = [];
    listShop = [];
    listShopProduct = [];
    listRelatedProduct = [];
    isLoadingShop = true;
    isLoadingShopProduct = true;
    isLoadingRelatedProduct = true;
    isLoadingVoucher = true;
    isLoadingListUser = true;
    isLoadingFavouriteIcon = true;
    setState(() {});
  }

  Future<void> refresh() async {
    reset();
    await fetchAllData();
  }

  Future<void> fetchAllData() async {
    await fetchProduct();
    listShop = await shopRepo.getListShop();
    shop = CommondMethods.getShopByID(product!.shopID!, listShop!);
    if (listShop != null && shop != null) {
      // setState(() {
      isLoadingShop = false;
      // });
    }
    listShopProduct = await shopRepo.getListProductByShopID(product!.shopID!);
    if (listShopProduct != null) {
      // setState(() {
      isLoadingShopProduct = false;
      // });
    }
    listVoucher =
        await voucherRepo.getListVoucherByProduct(product!.id!).then((value) {
      // setState(() {
      isLoadingVoucher = false;
      // });
    });

    listRelatedProduct = await productRepo
        .getListRelatedProduct(product!.categoryID!)
        .then((value) {
      // setState(() {
      isLoadingRelatedProduct = false;
      // });
    });

    listUser = await userRepo.getListUser();
    if (listUser != null) {
      // setState(() {
      isLoadingListUser = false;
      // });
    }

    seller = CommondMethods.getUserModelByShopID(product!.shopID!, listUser!);
    if (seller != null) {
      // setState(() {
      isLoadingSeller = false;
      // });
    }
    if (mounted) {
      setState(() {});
    }
  }

  void showSheet(size, CheckoutViewModel checkoutProvider, String userID,
      AddressViewModel addressProvider) {
    return BottomSheetHelper.showBottomSheet(
        context: context,
        child: Padding(
          padding: EdgeInsets.all(5.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5.h),
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
                              appBar: AppBar(leading: CustomArrayBackWidget()),
                              body: CustomPhotoView(
                                urlImage: product!.images![0],
                              ),
                            );
                          },
                        ));
                      },
                    ),
                    SizedBox(
                      width: 15.h,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product!.name!,
                          style: theme.textTheme.displayMedium,
                        ),
                        SizedBox(
                          height: 30.h,
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
                Padding(
                  padding: EdgeInsets.only(top: 5.h, left: 25.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child:
                        Text(LangText(context: context).getLocal()!.sizes_ucf),
                  ),
                ),
                CustomradioButtonForBuyNow(
                    list: product!.sizes!, kindOfData: KindOfData.sizes),
              },
              if (product!.types != null) ...{
                Padding(
                  padding: EdgeInsets.only(top: 5.h, left: 25.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child:
                        Text(LangText(context: context).getLocal()!.types_ucf),
                  ),
                ),
                CustomradioButtonForBuyNow(
                    list: product!.types!, kindOfData: KindOfData.types),
              },
              if (product!.colors != null) ...{
                const SizedBox(
                  width: 15,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.h, left: 25.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child:
                        Text(LangText(context: context).getLocal()!.colors_ucf),
                  ),
                ),
                CustomradioButtonForBuyNow(
                    list: product!.colors!, kindOfData: KindOfData.colors),
              },
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      LangText(context: context).getLocal()!.number_ucf,
                      style: theme.textTheme.headlineLarge,
                    ),
                    Spacer(),
                    CustomIconButton(
                      width: 28.h,
                      height: 28.h,
                      child: Container(
                          decoration:
                              BoxDecoration(border: Border.all(width: 0.1)),
                          child: Icon(
                            Icons.remove,
                            size: 20.h,
                          )),
                      onTap: () {
                        // minus
                        print("decrease number");
                        checkoutProvider.decreaseNumber();
                      },
                    ),
                    Container(
                      width: 58.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 3.h,
                      ),
                      decoration: AppDecoration.outlineBlueGray,
                      child: Consumer<CheckoutViewModel>(
                        builder: (context, value, child) {
                          return Center(
                            child: Text(
                              value.initialPurcharsingNumber.toString(),
                              style: CustomTextStyles.bodyMediumGray600,
                            ),
                          );
                        },
                      ),
                    ),
                    CustomIconButton(
                      width: 28.h,
                      height: 28.h,
                      child: Container(
                          decoration:
                              BoxDecoration(border: Border.all(width: 0.1)),
                          child: Icon(
                            Icons.add,
                            size: 20.h,
                          )),
                      onTap: () {
                        // increase
                        print("increase number");
                        checkoutProvider.increaseNumber();
                      },
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                width: size.width * 0.9,
                child: Consumer<CheckoutViewModel>(
                  builder: (context, value, child) {
                    return ElevatedButton(
                        onPressed: () async {
                          int savingCost = 0;
                          // if (value.voucherIDs != null) {
                          //   Voucher? voucher = CommondMethods.getVoucherFromID(
                          //       listVoucher!, value.voucherIDs![0]);
                          //   if (voucher != null) {
                          //     savingCost =
                          //         CommonCaculatedMethods.caculateSavignCost(
                          //             voucher, product!.price!);
                          //   }
                          // }
                          if (value.voucherIDs != null) {
                            Voucher? voucher = CommondMethods.getVoucherFromID(
                                listVoucher!, value.voucherIDs![0]);
                            if (voucher != null) {
                              savingCost =
                                  CommonCaculatedMethods.caculateSavignCost(
                                      voucher, product!.price!);
                            }
                          }
                          OrderingProduct orderingProduct = OrderingProduct(
                              deliverStatus: DeliverStatus.processing,
                              color: product!.colors != null
                                  ? (value.color ?? product!.colors![0])
                                  : null,
                              date: Timestamp.now(),
                              price: product!.price!,
                              productID: product!.id,
                              quantity: value.initialPurcharsingNumber,
                              realPrice: product!.price! - savingCost,
                              userID: userID,
                              size: product!.sizes != null
                                  ? (value.size ?? product!.sizes![0])
                                  : null,
                              type: product!.types != null
                                  ? (value.type ?? product!.types![0])
                                  : null,
                              voucherID: value.voucherIDs != null
                                  ? value.voucherIDs![0]
                                  : null);
                          orderModel.Order order = orderModel.Order(
                            orderingProductsID: [orderingProduct],
                            totalProduct: 1,
                            userID: userID,
                            totalCost: orderingProduct.realPrice,
                          );
                          checkoutProvider.setOrder(order);
                          AddressInfor? addressInfor =
                              await userRepo.getDefaultAddress(userID);
                          addressProvider.setDefaultAddress(addressInfor!);
                          List<AddressInfor>? list =
                              await userRepo.getListAddressInfor(userID);
                          addressProvider.setListAddressInfor(list!);
                          addressProvider.setOrderingAddress(addressInfor);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return CheckOut(uid: userID);
                            },
                          ));
                        },
                        child: Text(LangText(context: context)
                            .getLocal()!
                            .buy_now_ucf));
                  },
                ),
              ),
              SizedBox(
                height: 10.h,
              )
            ],
          ),
        ),
        height: size.height * 0.6,
        width: double.infinity);
  }

  @override
  Widget build(BuildContext context) {
    // final cartProvider = Provider.of<CartViewModel>(context, listen: false);
    final productDetailProvider = Provider.of<ProductDetailViewModel>(context);
    // Shop? shop = CommondMethods.getShopByID(product!.shopID!, listShop);
    final userProvider = Provider.of<UserViewModel>(context);
    final checkoutProvider = Provider.of<CheckoutViewModel>(context);
    final user = userProvider.currentUser;
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await refresh();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: CustomArrayBackWidget(function: () {
              checkoutProvider.reset();
              productDetailProvider.reset();
            }),
            actions: [
              buildFavouriteIcon(uid: user!.id!, productID: widget.id),
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
              SizedBox(width: 12.w),
            ],
            title: Container(
                padding: EdgeInsets.symmetric(horizontal: 1.w),
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.35),
                child: Text(
                  product != null ? product!.name! : "",
                  overflow: TextOverflow.ellipsis,
                )),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.h),
              child: isLoadingProduct
                  ? Container()
                  : Column(
                      children: [
                        _buildSlider(
                            context: context,
                            listImage: product!.images,
                            videos: product!.videos),
                        SizedBox(height: 8.h),
                        _buildAnimatedIndicator(
                            sliderIndex: sliderIndex), // fix
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
                                product!.name!,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Spacer(),
                            Padding(
                                padding: EdgeInsets.only(right: 16.h),
                                child: Text(
                                    "${AppLocalizations.of(context)!.available_products}: ${product!.availableQuantity}")),
                          ]),
                        ),
                        SizedBox(height: 8.h),

                        if (product!.reviewIDs != null) ...{
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
                                      "${product!.reviewIDs!.length} ${AppLocalizations.of(context)!.reviews_ucf}",
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

                        if (product!.sizes != null) ...{
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.h),
                            child: _buildSizeText(
                              context,
                              sizeLabel:
                                  AppLocalizations.of(context)!.sizes_ucf,
                              sizeChartLabel: "",
                            ),
                          ),
                          SizedBox(height: 6.h),
                          _buildProductSize(context, product!.sizes!),
                        },
                        if (product!.types != null) ...{
                          SizedBox(height: 10.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.h),
                            child: _buildSizeText(
                              context,
                              sizeLabel:
                                  AppLocalizations.of(context)!.types_ucf,
                              sizeChartLabel: "",
                            ),
                          ),
                          SizedBox(height: 6.h),
                          _buildProductType(context, product!.types!),
                        },

                        if (product!.colors != null) ...{
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.h),
                            child: _buildSizeText(
                              context,
                              sizeLabel:
                                  AppLocalizations.of(context)!.colors_ucf,
                              sizeChartLabel: "",
                            ),
                          ),
                          SizedBox(height: 10.h),
                          _buildProductColor(context, product!.colors!),
                        },

                        SizedBox(height: 24.h),
                        isLoadingShop
                            ? Container()
                            : _buildShopInfor(context, shop),
                        SizedBox(height: 24.h),
                        isLoadingVoucher
                            ? Container()
                            : listVoucher != null
                                ? ListVoucherWidget(list: listVoucher!)
                                : Container(),
                        SizedBox(height: 24.h),
                        // _buildColumn(context),
                        // SizedBox(height: 16.h),
                        if (product!.description != null) ...{
                          _buildProductDescription(context),
                        },

                        SizedBox(height: 16.h),
                        _buildRatingsAndReviews(context, product!),
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
                                      sizeLabel: AppLocalizations.of(context)!
                                          .other_products_of_shop,
                                      sizeChartLabel:
                                          AppLocalizations.of(context)!
                                              .view_more_ucf,
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.h),
                                        child: _buildSizeText(
                                          context,
                                          sizeLabel:
                                              AppLocalizations.of(context)!
                                                  .you_may_like,
                                          sizeChartLabel:
                                              AppLocalizations.of(context)!
                                                  .view_more_ucf,
                                        ),
                                      ),
                                      _buildRelatedProducts(
                                          context, listRelatedProduct!),
                                    ],
                                  )
                                : const SizedBox(),
                        SizedBox(
                          height: 10.h,
                        )
                      ],
                    ),
            ),
          ),
          bottomNavigationBar: Card(elevation: 45, child: _buildRow2(context)),
        ),
      ),
    );
  }

  Widget buildFavouriteIcon({required String productID, required String uid}) {
    return FutureBuilder(
      future: wishListRepo.isFavourite(uid: uid, productID: productID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Icon(
            Icons.favorite_border,
            size: 20.h,
          );
        } else {
          if (snapshot.data != null) {
            final isFavourite = snapshot.data;
            return Padding(
                padding: EdgeInsets.only(
                  left: 60.h,
                  // bottom: 72.h,
                ),
                child: InkWell(
                    onTap: () async {
                      if (isFavourite!) {
                        await wishListRepo.deleteFavouriteByParams(
                            uid: uid, productID: productID);
                        await refresh();
                      } else {
                        FavouriteProduct favouriteProduct = FavouriteProduct(
                            createdAt: Timestamp.now(),
                            productID: productID,
                            userID: uid);
                        await wishListRepo.addToFavourite(favouriteProduct);
                        await refresh();
                      }
                    },
                    child: Icon(
                      isFavourite!
                          ? Icons.favorite
                          : Icons.favorite_border_rounded,
                      color: Colors.red,
                    )));
          } else {
            return Padding(
                padding: EdgeInsets.only(
                  left: 60.h,
                  bottom: 72.h,
                ),
                child: Icon(
                  Icons.favorite_border,
                  size: 20.h,
                ));
          }
        }
      },
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
        physics: const BouncingScrollPhysics(),
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
              LangText(context: context).getLocal()!.product_information_ucf,
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
                    product!.description!,
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
      text: LangText(context: context).getLocal()!.rating_ucf,
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
              SizedBox(
                width: 10.w,
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
                      placeholder: (context, url) => Center(
                          child: SizedBox(
                              width: 30.h,
                              height: 30.h,
                              child: const CircularProgressIndicator())),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                  : Image.asset(ImageData.placeHolderImg),
              Padding(
                padding: EdgeInsets.only(left: 10.w),
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
                          ? shop.addressInfor!.city!.name!
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
                text: LangText(context: context).getLocal()!.see_shop,
                width: 90.w,
                height: 40.h,
                onPressed: () async {
                  // go to shop profile
                  await shopRepo.updateShopView(shop.id!);
                  // ignore: use_build_context_synchronously
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
            padding: EdgeInsets.only(left: 10.w),
            child: SizedBox(
              height: 22.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${shop.totalProduct} ${LangText(context: context).getLocal()!.products_ucf}",
                    style: CustomTextStyles.titleSmallMedium,
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(
                    "${shop.rating} ${LangText(context: context).getLocal()!.rating_ucf}",
                    style: CustomTextStyles.titleSmallMedium,
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(
                    "${shop.ratingCount} ${LangText(context: context).getLocal()!.rating_count}",
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
              LangText(context: context).getLocal()!.ratings_and_reviews,
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
                          LangText(context: context).getLocal()!.overall_rating,
                          style: CustomTextStyles.titleSmallMedium,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "${product.ratingCount} ${LangText(context: context).getLocal()!.ratings_ucf}s",
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
            stream: firestoreDatabase.getAllReviewByProduct(product!.id!),
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
                                  "${LangText(context: context).getLocal()!.view_more_ucf} ${product.reviewIDs!.length}",
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
    return GestureDetector(
      onTap: () async {
        Chat? chat;
        Message msg = Message(
            chatType: ChatType.text,
            isShop: false,
            productID: product!.id,
            receiverID: seller!.id,
            senderID: usermodel!.id,
            time: Timestamp.fromDate(DateTime.now()));

        // dafd

        bool? hasConversation = await chatRepo.checkExistedChatBoxWithUsers(
            sellerID: seller!.id!, userID: usermodel.id!);
        if (hasConversation!) {
          chat = Chat(
            listMsg: [],
            sellerID: seller!.id,
            shopID: product!.shopID,
            shopLogo: product!.shopLogo,
            shopName: product!.shopName,
            userAvatar: usermodel.avatar,
            userID: usermodel.id,
            userName: usermodel.firstName,
          );
          await chatRepo.addNewChat(chat);
        } else {
          chat = await chatRepo.getChatWithUsers(
              userID: usermodel.id!, sellerID: seller!.id!);
        }
        await chatRepo.sendAMessage(chatID: chat!.id!, msg: msg);
        // if (!CommondMethods.hasConversation(
        //     usermodel.id!, seller!.id!, listChat)) {
        //   chat = Chat(
        //     listMsg: [],
        //     sellerID: seller!.id,
        //     shopID: product!.shopID,
        //     shopLogo: product!.shopLogo,
        //     shopName: product!.shopName,
        //     userAvatar: usermodel.avatar,
        //     userID: usermodel.id,
        //     userName: usermodel.firstName,
        //   );
        //   chatProvider.addNewChat(chat);
        // } else {
        //   chat = CommondMethods.getChatByuserAndSeller(
        //       seller!.id!, usermodel.id!, listChat);
        // }
        // chatProvider.sendMsgToAChatBox(msg, chat!.id!);
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return ChattingPage(chat: chat);
          },
        ));
      },
      child: Container(
        height: 52.h,
        width: MediaQuery.of(context).size.width * 0.22,
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: MyTheme.accent_color),
            color: MyTheme.white),
        child: Center(
          child: Text(
            LangText(context: context).getLocal()!.chat_ucf,
            style: TextStyle(
                fontSize: 14.sp,
                color: MyTheme.accent_color,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
    // CustomOutlinedButton(
    //   onPressed: () async {
    //     Chat? chat;
    //     Message msg = Message(
    //         chatType: ChatType.text,
    //         isShop: false,
    //         productID: product!.id,
    //         receiverID: seller!.id,
    //         senderID: usermodel!.id,
    //         time: Timestamp.fromDate(DateTime.now()));

    //     // dafd

    //     bool? hasConversation = await chatRepo.checkExistedChatBoxWithUsers(
    //         sellerID: seller!.id!, userID: usermodel.id!);
    //     if (hasConversation!) {
    //       chat = Chat(
    //         listMsg: [],
    //         sellerID: seller!.id,
    //         shopID: product!.shopID,
    //         shopLogo: product!.shopLogo,
    //         shopName: product!.shopName,
    //         userAvatar: usermodel.avatar,
    //         userID: usermodel.id,
    //         userName: usermodel.firstName,
    //       );
    //       await chatRepo.addNewChat(chat);
    //     } else {
    //       chat = await chatRepo.getChatWithUsers(
    //           userID: usermodel.id!, sellerID: seller!.id!);
    //     }
    //     await chatRepo.sendAMessage(chatID: chat!.id!, msg: msg);
    //     // if (!CommondMethods.hasConversation(
    //     //     usermodel.id!, seller!.id!, listChat)) {
    //     //   chat = Chat(
    //     //     listMsg: [],
    //     //     sellerID: seller!.id,
    //     //     shopID: product!.shopID,
    //     //     shopLogo: product!.shopLogo,
    //     //     shopName: product!.shopName,
    //     //     userAvatar: usermodel.avatar,
    //     //     userID: usermodel.id,
    //     //     userName: usermodel.firstName,
    //     //   );
    //     //   chatProvider.addNewChat(chat);
    //     // } else {
    //     //   chat = CommondMethods.getChatByuserAndSeller(
    //     //       seller!.id!, usermodel.id!, listChat);
    //     // }
    //     // chatProvider.sendMsgToAChatBox(msg, chat!.id!);
    //     // ignore: use_build_context_synchronously
    //     Navigator.of(context).push(MaterialPageRoute(
    //       builder: (context) {
    //         return ChattingPage(chat: chat);
    //       },
    //     ));
    //   },
    //   height: 48.h,
    //   width: 80.h,
    //   text: LangText(context: context).getLocal()!.chat_ucf,
    //   buttonStyle: CustomButtonStyles.outlinePrimaryContainerTL8,
    //   buttonTextStyle: CustomTextStyles.titleMediumPrimaryContainer,
    // );
  }

  /// Section Widget
  Widget _buildAddToCart(BuildContext context) {
    final cartProvider = Provider.of<CartViewModel>(context);
    final productDetailProvider = Provider.of<ProductDetailViewModel>(context);
    // productDetailProvider.initialize(
    //   firstColor:
    //       product!.colors != null ? product!.colors![0] : null,
    //   firstSize:
    //       product!.sizes != null ? product!.sizes![0] : null,
    //   firstType:
    //       product!.types != null ? product!.types![0] : null,
    // );
    final size = MediaQuery.of(context).size;
    final userModel = Provider.of<AuthViewModel>(context).currentUser;
    return GestureDetector(
      onTap: () async {
        BottomSheetHelper.showBottomSheet(
            context: context,
            child: Padding(
              padding: EdgeInsets.all(5.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(5.h),
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
                        SizedBox(
                          width: 15.h,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              product!.name!,
                              style: theme.textTheme.displayMedium,
                            ),
                            SizedBox(
                              height: 30.h,
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
                    Padding(
                      padding: EdgeInsets.only(top: 5.h, left: 25.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            LangText(context: context).getLocal()!.sizes_ucf),
                      ),
                    ),
                    CustomradioButton(
                        list: product!.sizes!, kindOfData: KindOfData.sizes),
                  },
                  if (product!.types != null) ...{
                    Padding(
                      padding: EdgeInsets.only(top: 5.h, left: 25.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            LangText(context: context).getLocal()!.types_ucf),
                      ),
                    ),
                    CustomradioButton(
                        list: product!.types!, kindOfData: KindOfData.types),
                  },
                  if (product!.colors != null) ...{
                    const SizedBox(
                      width: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h, left: 25.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            LangText(context: context).getLocal()!.colors_ucf),
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
                          LangText(context: context).getLocal()!.number_ucf,
                          style: theme.textTheme.headlineLarge,
                        ),
                        Spacer(),
                        CustomIconButton(
                          width: 28.h,
                          height: 28.h,
                          child: Container(
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.1)),
                              child: Icon(
                                Icons.remove,
                                size: 20.h,
                              )),
                          onTap: () {
                            // minus
                            print("decrease number");
                            productDetailProvider.decreaseNumber();
                          },
                        ),
                        Container(
                          width: 58.w,
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                            vertical: 3.h,
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
                          width: 28.h,
                          height: 28.h,
                          child: Container(
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.1)),
                              child: Icon(
                                Icons.add,
                                size: 20.h,
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
                              //         cost: product!.price!,
                              //         quantity: value.choseNumber,
                              //         color: value.color,
                              //         currencyID: "currencyID01",
                              //         productID: product!.id,
                              //         productImage: product!.images![0],
                              //         productName: product!.name!,
                              //         voucherID: "voucherID01",
                              //         userID: "userID01",
                              //         size: value.size,
                              //         createdAt:
                              //             Timestamp.fromDate(DateTime.now()),
                              //         type: value.type);
                              ProductInCartModel productInCartModel =
                                  ProductInCartModel(
                                      cost: product!.price!,
                                      quantity: value.choseNumber,
                                      color: product!.colors != null
                                          ? (value.color ?? product!.colors![0])
                                          : null,
                                      currencyID: "704",
                                      productID: product!.id,
                                      productImage: product!.images![0],
                                      productName: product!.name!,
                                      voucherID: value.voucherIDs != null
                                          ? value.voucherIDs![0]
                                          : null,
                                      userID: userModel!.id!,
                                      size: product!.sizes != null
                                          ? (value.size ?? product!.sizes![0])
                                          : null,
                                      createdAt:
                                          Timestamp.fromDate(DateTime.now()),
                                      type: product!.types != null
                                          ? (value.type ?? product!.types![0])
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
                                          voucher, product!.price!);
                                }
                              }
                              cartRepo.addToCart(
                                  uid: userModel.id!,
                                  productInCartModel: productInCartModel,
                                  savingCost: savingCost);
                              productDetailProvider.reset();
                              Navigator.of(context).pop();
                            },
                            child: Text(LangText(context: context)
                                .getLocal()!
                                .add_to_cart_ucf));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
            ),
            height: size.height * 0.6,
            width: double.infinity);
        // cartProvider.addToCart(product);
      },
      child: Container(
        height: 52.h,
        width: MediaQuery.of(context).size.width * 0.3,
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: MyTheme.accent_color),
            color: MyTheme.white),
        child: Center(
          child: Text(
            LangText(context: context).getLocal()!.add_to_cart_ucf,
            style: TextStyle(
                fontSize: 14.sp,
                color: MyTheme.accent_color,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

    // CustomOutlinedButton(
    //   width: 110.w,
    //   onPressed: () {
    //     // Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage(),));

    //   buttonStyle: CustomButtonStyles.outlinePrimaryContainerTL8,
    //   buttonTextStyle: CustomTextStyles.titleMediumPrimaryContainer,
    // );
  }

  /// Section Widget
  Widget _buildBuyNow(BuildContext context) {
    final checkoutProvider = Provider.of<CheckoutViewModel>(context);
    final addressProvider = Provider.of<AddressViewModel>(context);
    final size = MediaQuery.of(context).size;
    return Consumer<UserViewModel>(
      builder: (context, provider, child) => GestureDetector(
        onTap: () async {
          showSheet(size, checkoutProvider, provider.currentUser!.id!,
              addressProvider);
        },
        child: Container(
          height: 52.h,
          width: MediaQuery.of(context).size.width * 0.32,
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: MyTheme.accent_color),
              color: Colors.orangeAccent),
          child: Center(
            child: Text(
              LangText(context: context).getLocal()!.buy_now_ucf,
              style: TextStyle(
                  fontSize: 14.sp,
                  color: MyTheme.accent_color,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRow2(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5.h, right: 5.h, bottom: 10.h, top: 5.h),
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
            width: 40.h,
            height: 40.h,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
          SizedBox(
            width: 160.w,
          ),
          Container(
            width: 40.h,
            height: 40.h,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            child: InkWell(
              onTap: () {},
              child: const Icon(Icons.favorite_outline),
            ),
          ),
          Container(
            width: 40.h,
            height: 40.h,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            child: InkWell(
              onTap: () {},
              child: Icon(Icons.share),
            ),
          ),
          Container(
            width: 40.h,
            height: 40.h,
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

enum KindOfData { types, sizes, colors }
