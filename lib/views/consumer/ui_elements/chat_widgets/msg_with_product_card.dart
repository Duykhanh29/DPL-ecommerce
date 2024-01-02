import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/utils/common/common_methods.dart';
import 'package:dpl_ecommerce/views/consumer/screens/product_detail_page.dart';
import 'package:dpl_ecommerce/views/seller/screens/product2/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MsgWithProduct extends StatefulWidget {
  MsgWithProduct({super.key, this.productID, this.isShop = false});
  String? productID;
  bool isShop;

  @override
  State<MsgWithProduct> createState() => _MsgWithProductState();
}

class _MsgWithProductState extends State<MsgWithProduct> {
  Product? product;
  ProductRepo productRepo = ProductRepo();
  List<Product>? listProduct;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // product = CommondMethods.getProductByID(listProduct!, widget.productID!);
    fetchData();
  }

  Future<void> fetchData() async {
    product = await productRepo.getProductByID(widget.productID!);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  // @override
  // void dispose() {
  //   productRepo.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (!widget.isShop) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return ProductDetailsPage(id: widget.productID!);
            },
          ));
        } else {
          //  Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) {
          //     return EditProductScreen(product: product, onProductUpdated: onProductUpdated, products: products)
          //   },
          // ));
        }
      },
      child: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: Container(
          height: size.height * 0.1,
          width: size.width,
          child: Row(
            mainAxisAlignment: !widget.isShop
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
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
      ),
    );
  }

  Widget _buildProductCard(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      margin: EdgeInsets.only(left: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          product != null
              ? SizedBox(
                  height: size.height * 0.1,
                  width: size.width * 0.1,
                  child: Image.network(product != null
                      ? product!.images != null && product!.images!.isNotEmpty
                          ? product!.images![0]
                          : "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png"
                      : "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png"),
                )
              : Container(),
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
                Text(product != null
                    ? product!.name ?? ""
                    : isLoading
                        ? "..."
                        : ""),
                Text(product != null
                    ? product!.price != null
                        ? product!.price.toString()
                        : ""
                    : isLoading
                        ? "..."
                        : "")
              ],
            ),
          )
        ],
      ),
    );
  }
}
