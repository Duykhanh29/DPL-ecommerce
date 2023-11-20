import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/order_widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOrdersListPage extends StatefulWidget {
  const MyOrdersListPage({Key? key})
      : super(
          key: key,
        );

  @override
  MyOrdersOnePageState createState() => MyOrdersOnePageState();
}

class MyOrdersOnePageState extends State<MyOrdersListPage>
    with AutomaticKeepAliveClientMixin<MyOrdersListPage> {
  @override
  bool get wantKeepAlive => true;

  List<Widget> tab1Containers = [
    //MyOrdersOnePage(),
  ];

  List<Widget> tab2Containers = [];
  int currentTabIndex = 0;

  void switchTab() {
    // Chuyển container từ Tab 1 sang Tab 2
    if (currentTabIndex == 0 && tab1Containers.isNotEmpty) {
      setState(() {
        tab2Containers.add(tab1Containers.removeAt(0));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          //decoration: AppDecoration.fillOnPrimary,
          child: Column(
            children: [
              SizedBox(height: 32.h),
              _buildMyOrdersOne(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildMyOrdersOne(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 1.h),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              height: 5.h,
            );
          },
          itemCount: 3,
          itemBuilder: (context, index) {
            return MyordersoneItemWidget();
          },
        ),
      ),
    );
  }
}
