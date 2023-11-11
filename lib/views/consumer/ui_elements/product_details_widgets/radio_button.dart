import 'package:dpl_ecommerce/view_model/consumer/product_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum KindOfData { types, sizes, colors }

class CustomradioButton extends StatefulWidget {
  CustomradioButton({super.key, required this.list, required this.kindOfData});
  List<String>? list;
  KindOfData? kindOfData;
  @override
  State<CustomradioButton> createState() => _CustomradioButtonState();
}

class _CustomradioButtonState extends State<CustomradioButton> {
  int selectedIndex = 0;

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(right: 20),
      height: size.height * 0.06,
      width: double.infinity,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return customRadio(context, index, widget.list![index]);
        },
        itemCount: widget.list!.length,
      ),
    );
  }

  Widget customRadio(BuildContext context, int index, String text) {
    final productDetailProvider = Provider.of<ProductDetailViewModel>(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.04,
      width: size.width * 0.2,
      child: OutlinedButton(
          onPressed: () {
            changeIndex(index);
            if (widget.kindOfData == KindOfData.colors) {
              productDetailProvider.changeColor(text);
            } else if (widget.kindOfData == KindOfData.sizes) {
              productDetailProvider.changeSize(text);
            } else {
              productDetailProvider.changeType(text);
            }
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                  color:
                      selectedIndex == index ? Colors.deepOrange : Colors.grey),
            ),
          )),
          child: Text(
            text,
            style: TextStyle(
                color: selectedIndex == index ? Colors.indigo : Colors.black),
          )),
    );
  }
}
