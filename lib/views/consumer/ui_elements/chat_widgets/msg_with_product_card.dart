import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/utils/common/common_methods.dart';
import 'package:dpl_ecommerce/views/consumer/screens/product_detail_page.dart';
import 'package:flutter/material.dart';

class MsgWithProduct extends StatefulWidget {
  MsgWithProduct({super.key, this.productID});
  String? productID;

  @override
  State<MsgWithProduct> createState() => _MsgWithProductState();
}

class _MsgWithProductState extends State<MsgWithProduct> {
  Product? product;
  List<Product>? listProduct = ProductRepo().list;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    product = CommondMethods.getProductByID(listProduct!, widget.productID!);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return ProductDetailsPage(id: widget.productID!);
          },
        ));
      },
      child: Container(
        height: size.height * 0.1,
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.teal[100],
                  borderRadius: BorderRadius.circular(10)),
              width: size.width * 0.55,
              child: _buildProductCard(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      margin: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: size.height * 0.1,
            width: size.width * 0.1,
            child: Image.network(product != null
                ? product!.images![0]
                : "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png"),
          ),
          // CircleAvatar(
          //   radius: 50,
          //   backgroundImage: NetworkImage(product != null
          //       ? product!.images![0]
          //       : "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png"),
          // ),
          FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(product!.name ?? ""),
                Text(product!.price != null ? product!.price.toString() : "")
              ],
            ),
          )
        ],
      ),
    );
  }
}
