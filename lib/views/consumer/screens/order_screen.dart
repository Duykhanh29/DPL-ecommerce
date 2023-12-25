import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/const/my_text_style.dart';
import 'package:dpl_ecommerce/customs/custom_outline_button.dart';
import 'package:dpl_ecommerce/models/order_model.dart';
import 'package:dpl_ecommerce/models/ordering_product.dart';
import 'package:dpl_ecommerce/repositories/order_repo.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/order_detail.dart';
import 'package:dpl_ecommerce/views/consumer/screens/track_order.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/order_widgets/list_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key})
      : super(
          key: key,
        );
  // Order? order;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    final user = userProvider.currentUser;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LangText(context: context).getLocal()!.my_orders_ucf,
          style: MyTextStyle1().appBarText(),
        ),
        backgroundColor: MyTheme.accent_color,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.h),
        child: ListOrder(uid: user!.id!),
      ),
    );
  }
}
