import 'package:dpl_ecommerce/helpers/shimmer_helper.dart';
import 'package:dpl_ecommerce/models/order_model.dart';
import 'package:dpl_ecommerce/repositories/order_repo.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/order_widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListOrder extends StatefulWidget {
  ListOrder({super.key, required this.uid});
  String uid;
  @override
  State<ListOrder> createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
  OrderRepo orderRepo = OrderRepo();
  List<Order>? listOrder;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    listOrder = await orderRepo.getListOrderByUserID(widget.uid);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  void reset() {
    listOrder = null;
    isLoading = true;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> onRefresh() async {
    reset();
    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: isLoading
          ? ListView.separated(
              itemBuilder: (context, index) => ShimmerHelper()
                  .buildBasicShimmer(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width * 0.9),
              separatorBuilder: (context, index) => SizedBox(
                    height: 10.h,
                  ),
              itemCount: 12)
          : (listOrder != null && listOrder!.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return OrderItem(
                      order: listOrder![index],
                    );
                  },
                  itemCount: listOrder!.length,
                )
              : Center(
                  child: Text(LangText(context: context)
                      .getLocal()!
                      .no_data_is_available),
                )),
    );
  }
}
