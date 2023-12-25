import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/models/ordering_product.dart';
import 'package:dpl_ecommerce/repositories/order_repo.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/order_widgets/ordering_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListorderingItem extends StatefulWidget {
  ListorderingItem(
      {super.key, required this.listOrderingProduct, required this.orderID});
  List<OrderingProduct> listOrderingProduct;
  String orderID;

  @override
  State<ListorderingItem> createState() => _ListorderingItemState();
}

class _ListorderingItemState extends State<ListorderingItem> {
  List<OrderingProduct>? list;
  OrderRepo orderRepo = OrderRepo();
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    list = await orderRepo.getListOrderingProductByOrder(widget.orderID);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: SingleChildScrollView(
        child: isLoading
            ? Container(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  height: 3.h,
                ),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return OrderingProductItem(
                    orderingProduct: list![index],
                    orderID: widget.orderID,
                  );
                },
                itemCount: list!.length,
              ),
      ),
    );
  }
}
