// display_products_screen.dart

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/seller/shop_view_model.dart';
import 'package:dpl_ecommerce/views/seller/screens/product2/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DisplayProductsScreen extends StatefulWidget {
  // final List<Product> products;
  // final Function(String) onProductDeleted;
  // final Function(Product) onProductUpdated;
  String shopID;

  DisplayProductsScreen({super.key, required this.shopID});

  // DisplayProductsScreen({
  //   required this.products,
  //   required this.onProductDeleted,
  //   required this.onProductUpdated,
  // });

  @override
  _DisplayProductsScreenState createState() => _DisplayProductsScreenState();
}

class _DisplayProductsScreenState extends State<DisplayProductsScreen> {
  ProductRepo productRepo = ProductRepo();
  List<Product>? listProduct;
  // bool isLoading = true;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   fetchData();
  // }

  // Future<void> fetchData() async {
  //   listProduct = await productRepo.getListProductByShopID(widget.shopID);
  //   isLoading = false;
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   fetchData();
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: productRepo.getAllProductByShopID(widget.shopID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              final list = snapshot.data;
              if (list!.isNotEmpty) {
                return buildListProduct(context, list);
              } else {
                Center(
                  child: Text(LangText(context: context)
                      .getLocal()!
                      .no_data_is_available),
                );
              }
            } else {
              return Center(
                child: Text(LangText(context: context)
                    .getLocal()!
                    .no_data_is_available),
              );
            }
          }
          return Center(
            child: Text(
                LangText(context: context).getLocal()!.no_data_is_available),
          );
        }
      },
    );

    // isLoading
    //     ? Container(
    //         child: CircularProgressIndicator(),
    //       )
    //     : listProduct == null || listProduct!.isEmpty
    //         ? Center(
    //             child: Container(
    //               child: Text(LangText(context: context)
    //                   .getLocal()!
    //                   .no_data_is_available),
    //             ),
    //           )
    //         : ;
  }

  Widget buildListProduct(BuildContext context, List<Product>? list) {
    final shopProvider = Provider.of<ShopViewModel>(context);
    final shop = shopProvider.shop;
    return ListView.builder(
      itemCount: list!.length,
      padding: EdgeInsets.all(20.h),
      itemBuilder: (context, index) {
        final product = list![index];
        return Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 23.h,
                vertical: 21.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 2.h,
                    blurRadius: 2.h,
                    offset: Offset(
                      0,
                      4,
                    ),
                  ),
                ],
              ),
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      product.images != null && product.images!.isNotEmpty
                          ? (CachedNetworkImage(
                              imageUrl: product.images![0],
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  height: 70.h,
                                  width: 70.h,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider)),
                                );
                              },
                              placeholder: (context, url) => Center(
                                  child: SizedBox(
                                      width: 30.h,
                                      height: 30.h,
                                      child:
                                          const CircularProgressIndicator())),
                              errorWidget: (context, url, error) => Center(
                                  child: Icon(
                                Icons.error,
                                size: 30.h,
                              )),
                            ))
                          : Container(
                              height: 70.h,
                              width: 70.h,
                              child: Image.asset(ImageData.imageNotFound),
                            ),
                      // Image.file(
                      //   File('${product.images?[0]}'),
                      //   height: 80.h,
                      //   width: 80.w,
                      // ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${product.name}',
                            //style: theme.textTheme.titleSmall,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            '${LangText(context: context).getLocal()!.price_ucf}: ${product.price}',
                            //style: theme.textTheme.bodySmall,
                            maxLines: 2,
                          ),
                          Text(
                            '${LangText(context: context).getLocal()!.quantity_ucf} ${product.availableQuantity}',
                            //style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 2.h),
                        width: 100.w,
                        height: 40.h,

                        // decoration: BoxDecoration(

                        //     //color: Colors.white,
                        //     border: Border.all(
                        //       color: Color.fromARGB(35, 0, 0, 0),
                        //       width: 1,
                        //     ),
                        //     borderRadius: BorderRadius.circular(5.r)),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(MyTheme.white)),
                          onPressed: () {
                            _navigateToEditProductScreen(product);
                          },
                          child: Center(
                              child: Text(
                            LangText(context: context).getLocal()!.edit,
                            style: TextStyle(
                                fontSize: 16.sp, color: Colors.black54),
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        width: 100.w,
                        height: 40.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 2.h),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  MyTheme.accent_color)),
                          child: Text(
                            LangText(context: context).getLocal()!.delete_ucf,
                            style: TextStyle(color: MyTheme.white),
                          ),

                          // Add onPressed callback for the Delete button
                          onPressed: () {
                            // Add your logic for deleting here
                            // For example, you can show a confirmation dialog and then delete the address
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text(LangText(context: context)
                                    .getLocal()!
                                    .delete_product_ucf),
                                content: Text(LangText(context: context)
                                    .getLocal()!
                                    .are_you_sure_to_delete_product),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(_).pop();
                                    },
                                    child: Text(LangText(context: context)
                                        .getLocal()!
                                        .cancel_ucf),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      // Add logic to delete the address here
                                      // You can use setState or any state management solution to update the UI
                                      // setState(() {
                                      //   productes.removeAt(index);
                                      // });
                                      // widget
                                      //     .onProductDeleted(product.id as int);
                                      // Navigator.of(context)
                                      //     .pop(); // Close the dialog
                                      // widget.onProductDeleted(
                                      //     product.id as String);
                                      await productRepo.deleteProduct(
                                          productID: product.id!,
                                          shopID: shop!.id!);
                                      shopProvider.updateTotalProduct(
                                          TypeOfTotalProduct.decrease);
                                      Navigator.of(_).pop(); // Close the dialog
                                    },
                                    child: Text(LangText(context: context)
                                        .getLocal()!
                                        .delete_ucf),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToEditProductScreen(Product product) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductScreen(
          product: product,
        ),
      ),
    );
  }
}
