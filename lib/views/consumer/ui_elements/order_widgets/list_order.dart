import 'package:dpl_ecommerce/models/order_model.dart';
import 'package:dpl_ecommerce/repositories/order_repo.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/order_widgets/order_item.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : (listOrder != null
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
              ));
  }
}
