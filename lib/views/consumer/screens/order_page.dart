import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/customs/custom_badge_cart.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/models/ordering_product.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/view_model/consumer/cart_view_model.dart';
//import 'package:dpl_ecommerce/customs/app_bar_leading.dart';
///import 'package:dpl_ecommerce/views/consumer/screens/app_bar_title.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/order_widgets/order_item.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/order_widgets/order_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key})
      : super(
          key: key,
        );

  @override
  MyOrdersThreeTabContainerScreenState createState() =>
      MyOrdersThreeTabContainerScreenState();
}

class MyOrdersThreeTabContainerScreenState extends State<OrdersPage>
    with TickerProviderStateMixin {
  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 4, vsync: this);
  }

  OrderingProduct order = OrderingProduct(
    id: "13",
    price: 200,
    quantity: 9,
  );
  
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "My Orders",
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: [
          // Consumer<CartViewModel>(builder: (context, value, child) {
          //   return CustomBadgeCart(number: value.cart.productInCarts!.length);
          // }),
          const SizedBox(width: 10),
          Center(
            child: badges.Badge(
              badgeContent: Text(
                "3",
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
              child: InkWell(
                child: Icon(Icons.notifications_outlined,
                    color: Colors.white, size: 30),
                onTap: () {},
              ),
            ),
          ),
          const SizedBox(width: 15),

          const SizedBox(
            width: 12,
          )
        ],

        //leading: Icon(Icons.menu),
      ),
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            SizedBox(height: 17.v),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTabview(context),
                    SizedBox(
                      height: 589.v,
                      child: TabBarView(
                        controller: tabviewController,
                        children: [
                          MyOrdersListPage(),
                          MyOrdersListPage(),
                          MyOrdersListPage(),
                          MyOrdersListPage(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      //bottomNavigationBar: _buildBottomBar(context),
    );
  }

 
  Widget _buildTabview(BuildContext context) {
    return SizedBox(
      height: 28.v,
      width: 309.h,
      child: TabBar(
        controller: tabviewController,
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.black,
        isScrollable: true,
        indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 2,
              color: Colors.blue,
            ),
            insets: EdgeInsets.symmetric(horizontal: 16)),
        labelPadding: const EdgeInsets.symmetric(horizontal: 20),
        labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        tabs: [
          Tab(
            child: Text(
              "Processing",
            ),
          ),
          Tab(
            child: Text(
              "Confirmed",
            ),
          ),
          Tab(
            child: Text(
              "Delivering",
            ),
          ),
          Tab(
            child: Text(
              "Delivered",
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //color: theme.colorScheme.onPrimary,
        color: Colors.blue,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.h),
        ),
        boxShadow: [
          BoxShadow(
            //color: appTheme.black900.withOpacity(0.15),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              0,
            ),
          ),
        ],
      ),
      child: CustomImageView(
        //imagePath: ImageConstant.imgFrame33104,
        height: 23.v,
        width: 269.h,
        margin: EdgeInsets.fromLTRB(53.h, 24.v, 51.h, 32.v),
      ),
    );
  }
}
