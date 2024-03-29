import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/category.dart';
import 'package:dpl_ecommerce/models/chat.dart';
import 'package:dpl_ecommerce/models/flash_sale.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/repositories/auth_repo.dart';
import 'package:dpl_ecommerce/repositories/category_repo.dart';
import 'package:dpl_ecommerce/repositories/chat_repo.dart';
import 'package:dpl_ecommerce/repositories/flash_sale_repo.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/repositories/shop_repo.dart';
import 'package:dpl_ecommerce/repositories/user_repo.dart';
import 'package:dpl_ecommerce/repositories/voucher_repo.dart';
import 'package:dpl_ecommerce/utils/common/common_methods.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/view_model/consumer/chat_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/chatting_page.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/voucher_widgets/list_voucher_widget.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_item_widget1.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_small_list_item1_widget.dart';
import 'package:dpl_ecommerce/views/consumer/screens/detail_seller_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ShopProfile extends StatefulWidget {
  ShopProfile({required this.shop});
  Shop? shop;
  @override
  _ShopProfileState createState() => _ShopProfileState();
}

class _ShopProfileState extends State<ShopProfile>
    with SingleTickerProviderStateMixin {
  int isSelected = 0;
  late TabController _tabController;
  int selectedIndex = -1;
  // List<FlashSale>? listFlashSale;
  List<Product>? listProduct;
  List<Category>? listCategory;
  List<Voucher>? listVoucher;
  bool isLoading = true;
  // repos
  VoucherRepo voucherRepo = VoucherRepo();
  CategoryRepo categoryRepo = CategoryRepo();
  ProductRepo productRepo = ProductRepo();
  ShopRepo shopRepo = ShopRepo();
  UserRepo userRepo = UserRepo();

  // UserModel userModel = AuthRepo().user;
  // List<Chat> listChat = ChatRepo().list;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
    super.initState();
    fetchData();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  Future<void> fetchData() async {
    listProduct = await shopRepo.getListProductByShopID(widget.shop!.id!);
    listVoucher = await voucherRepo.getListVoucherByShop(widget.shop!.id!);
    listCategory = await categoryRepo.getListCategory();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    if (listVoucher != null) {
      listVoucher!.clear();
    }
    if (listProduct != null) {
      listProduct!.clear();
    }
    if (listCategory != null) {
      listCategory!.clear();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatViewModel>(context);
    final userProvider = Provider.of<UserViewModel>(context);
    final currentUser = userProvider.currentUser;
    return Scaffold(
      appBar:
          AppBar(leading: CustomArrayBackWidget(), title: Text("Shop profile")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileSeller(
                                shop: widget.shop!,
                              ),
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(widget.shop!.logo!),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProfileSeller(shop: widget.shop!),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.shop!.name!,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 230, 207, 6),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(widget.shop!.rating != null
                                      ? widget.shop!.rating.toString()
                                      : ""),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  // Text("|"),
                                  // SizedBox(
                                  //   width: 5,
                                  // ),
                                  //Text("900k followers")
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: () async {
                                  List<UserModel>? lisUser =
                                      await userRepo.getListUser();
                                  Future.delayed(const Duration(seconds: 5));
                                  UserModel? seller =
                                      CommondMethods.getUserModelByShopID(
                                          widget.shop!.id!, lisUser!);
                                  Chat? chat;
                                  // TODO: Add button press logic
                                  if (!CommondMethods.hasConversation(
                                      currentUser!.id!,
                                      seller!.id!,
                                      chatProvider.list)) {
                                    chat = Chat(
                                      listMsg: [],
                                      sellerID: seller.id,
                                      shopID: widget.shop!.id,
                                      shopLogo: widget.shop!.logo,
                                      shopName: widget.shop!.name,
                                      userAvatar: currentUser.avatar,
                                      userID: currentUser.id,
                                      userName: currentUser.firstName,
                                    );
                                    chatProvider.addNewChat(chat);
                                  } else {
                                    chat =
                                        CommondMethods.getChatByuserAndSeller(
                                            seller.id!,
                                            currentUser.id!,
                                            chatProvider.list);
                                  }

                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return ChattingPage(chat: chat);
                                    },
                                  ));
                                },
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.chat,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Chat',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                    TabBar(
                        controller: _tabController,
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.black,
                        isScrollable: true,
                        indicator: const UnderlineTabIndicator(
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.blue,
                            ),
                            insets: EdgeInsets.symmetric(horizontal: 16)),
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        labelStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                        tabs: const [
                          Tab(text: "Shop"),
                          Tab(text: "Products"),
                          Tab(text: "Product category"),
                          //Tab(text: "Live"),
                        ]),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: [
                        Container(
                          //color: Colors.pink,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (listVoucher != null && !isLoading) ...{
                                  ListVoucherWidget(list: listVoucher!),
                                },

                                if (listProduct != null && !isLoading) ...{
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.h, vertical: 6),
                                    child: _buildDealOfTheDay(
                                      context,
                                      dealOfTheDayText: "Featured products",
                                      viewAllText: listProduct!.length > 2
                                          ? "View all"
                                          : "",
                                    ),
                                  ),
                                  _buildDealOfTheDayRow(context, listProduct!),
                                },

                                SizedBox(height: 26.h),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      padding: EdgeInsets.all(5.h),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          color: Color.fromARGB(
                                              255, 212, 253, 255)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.w),
                                            child: Text(
                                              widget.shop!.name!,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.w),
                                            child: Text(
                                              widget.shop!.shopDescription!,
                                              overflow: TextOverflow.clip,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.w),
                                            child: Text(
                                              widget.shop!.contactPhone!,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                if (listProduct != null && !isLoading) ...{
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 5.h, left: 10.w),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10.h,
                                          ),
                                          //padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: _buildDealOfTheDay(
                                            context,
                                            dealOfTheDayText: "Recommend",
                                            viewAllText: "",
                                          ),
                                        ),
                                        _buildProductSmallList1(
                                            context, listProduct!),
                                      ],
                                    ),
                                  ),
                                },

                                //SizedBox(height: 16.v),
                              ],
                            ),
                          ),

                          //color: Colors.white,
                        ),
                        Container(
                          //color: Colors.red,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 5.h, left: 10.w),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.h,
                                  ),
                                  //padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: _buildDealOfTheDay(
                                    context,
                                    dealOfTheDayText: "",
                                    viewAllText: "",
                                  ),
                                ),
                                if (listProduct != null && !isLoading) ...{
                                  _buildProductSmallList1(
                                      context, listProduct!),
                                } else ...{
                                  Container()
                                }
                              ],
                            ),
                          ),
                        ),
                        Container(
                          //color: Colors.red,
                          child: !isLoading
                              ? listCategory != null
                                  ? Column(
                                      children: listCategory!.map((category) {
                                        return ListTile(
                                          leading: CachedNetworkImage(
                                            imageUrl: category.logo!,
                                            imageBuilder:
                                                (context, imageProvider) {
                                              return Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.08,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: imageProvider),
                                                ),
                                              );
                                            },
                                            placeholder: (context, url) =>
                                                Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          ),
                                          title: Text(category.name!),
                                        );
                                      }).toList(),
                                    )
                                  : Center(
                                      child: Text("No category"),
                                    )
                              : Center(
                                  child: CircularProgressIndicator(),
                                ),
                        ),
                      ][_tabController.index],
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // _buildProductCategory({required int index, required String name}) =>
  // GestureDetector(
  //   onTap: () => setState(() => isSelected = index),
  //   child: Container(
  //     width: 100,
  //     height: 40,
  //     margin:  const EdgeInsets.only(top: 10, right: 10),
  //     alignment: Alignment.center,
  //     decoration: BoxDecoration(
  //       color: isSelected == index ? Colors.red :Colors.red.shade300,
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: Text(name,
  //     style: const TextStyle(color: Colors.white,),),
  //   ),
  // );
  //  Widget buildProductCategory({required int index, required String name}) {
  //   return GestureDetector(
  //     onTap: () => setState(() => isSelected = index),
  //     child: Container(
  //       width: 100,
  //       height: 40,
  //       margin: const EdgeInsets.only(top: 10, right: 10),
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //         color: isSelected == index ? Colors.red : Colors.red.shade300,
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //       child: Text(
  //         name,
  //         style: TextStyle(
  //           color: isSelected == index ? Colors.white : Colors.black,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

Widget _buildDealOfTheDay(
  BuildContext context, {
  required String dealOfTheDayText,
  required String viewAllText,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: EdgeInsets.only(top: 1.h),
        child: Text(
          dealOfTheDayText,
          style: theme.textTheme.titleSmall!.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(bottom: 3.w),
        child: TextButton(
          onPressed: () {
            // go to see all
          },
          child: Text(
            viewAllText,
            style: CustomTextStyles.bodySmallGray600.copyWith(
              color: appTheme.gray600,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildDealOfTheDayRow(BuildContext context, List<Product> list) {
  return SizedBox(
    height: 220.h,
    child: ListView.separated(
      padding: EdgeInsets.only(left: 16.h),
      scrollDirection: Axis.horizontal,
      separatorBuilder: (
        context,
        index,
      ) {
        return SizedBox(
          width: 16.h,
        );
      },
      itemCount: list.length,
      itemBuilder: (context, index) {
        return ProductItemWidget(
          product: list[index],
        );
      },
    ),
  );
}

Widget _buildProductSmallList1(BuildContext context, List<Product> list) {
  return Padding(
    padding: EdgeInsets.only(right: 10.h),
    child: GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 283.h,
        // childAspectRatio: 3 / 2,
      ),
      itemBuilder: (context, index) {
        return Productsmalllist1ItemWidget(
          product: list[index],
        );
      },
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
    ),
  );
}
