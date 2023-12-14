import 'package:dpl_ecommerce/models/ordering_product.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/order_widgets/ordering_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListorderItem extends StatelessWidget {
  ListorderItem({super.key, required this.listOrderingProduct});
  List<OrderingProduct> listOrderingProduct;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return OrderingProductItem();
        },
        itemCount: listOrderingProduct.length,
      ),
    );
  }
}
