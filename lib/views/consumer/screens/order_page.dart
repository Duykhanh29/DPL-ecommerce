import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/customs/custom_badge_cart.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/models/ordering_product.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/consumer/cart_view_model.dart';
//import 'package:dpl_ecommerce/customs/app_bar_leading.dart';
///import 'package:dpl_ecommerce/views/consumer/screens/app_bar_title.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/order_widgets/order_item.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/order_widgets/order_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key})
      : super(
          key: key,
        );

  @override
  MyOrderThreeTabContainerScreenState createState() =>
      MyOrderThreeTabContainerScreenState();
}

class MyOrderThreeTabContainerScreenState extends State<OrderPage>
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          LangText(context: context).getLocal()!.my_orders_ucf,
          textAlign: TextAlign.center,
        ),
        // centerTitle: true,

        //leading: Icon(Icons.menu),
      ),
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            SizedBox(height: 17.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTabview(context),
                    SizedBox(
                      height: 589.h,
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
      height: 28.h,
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
              LangText(context: context).getLocal()!.processing,
            ),
          ),
          Tab(
            child: Text(
              LangText(context: context).getLocal()!.confirm_ucf,
            ),
          ),
          Tab(
            child: Text(
              LangText(context: context).getLocal()!.delivering,
            ),
          ),
          Tab(
            child: Text(LangText(context: context).getLocal()!.delivered_ucf),
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
        height: 23.h,
        width: 269.h,
        margin: EdgeInsets.fromLTRB(53.h, 24.h, 51.h, 32.h),
      ),
    );
  }
}
