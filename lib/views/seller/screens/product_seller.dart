import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_elevate_button.dart';

import 'package:dpl_ecommerce/customs/custom_outline_button.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/product_in_cart_model.dart';

import 'package:dpl_ecommerce/views/consumer/screens/address_edit.dart';
import 'package:dpl_ecommerce/views/seller/screens/product/edit_product.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductSellerScreen extends StatefulWidget {
  ProductSellerScreen({Key? key}) : super(key: key);

  @override
  _AddresslistItemWidgetState createState() => _AddresslistItemWidgetState();
}

class _AddresslistItemWidgetState extends State<ProductSellerScreen> {
  List<Product> productes = [
    Product(
        name: "Airpod 1",
        price: 300000,
        availableQuantity: 20,
        shopLogo: "assets/images/airpod.jpg"),
    Product(
        name: "Airpod 1",
        price: 300000,
        availableQuantity: 20,
        shopLogo: "assets/images/airpod.jpg"),
    Product(
        name: "Airpod 1",
        price: 300000,
        availableQuantity: 20,
        shopLogo: "assets/images/airpod.jpg"),
    Product(
        name: "Airpod 1",
        price: 300000,
        availableQuantity: 20,
        shopLogo: "assets/images/airpod.jpg"),
    Product(
        name: "Airpod 1",
        price: 300000,
        availableQuantity: 20,
        shopLogo: "assets/images/airpod.jpg"),

    // Add more addresses if needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Products",
          textAlign: TextAlign.center,
        ),
        centerTitle: true,

        //leading: Icon(Icons.menu),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductForm(),
          ),
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: productes.length,
            padding: EdgeInsets.all(20),
            itemBuilder: (context, index) {
              Product product = productes[index];
              return Column(
                children: [
                  SizedBox(
                    height: 20,
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
                            Image.asset(
                              '${productes[index].shopLogo}',
                              height: 70,
                              width: 70,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${productes[index].name}',
                                  style: theme.textTheme.titleSmall,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Price: ${productes[index].price}',
                                  style: theme.textTheme.bodySmall,
                                  maxLines: 2,
                                ),
                                Text(
                                  'Quantity: ${productes[index].availableQuantity}',
                                  style: theme.textTheme.bodySmall,
                                ),
                                // Text(
                                //   '${addresses[index].district}',
                                //   style: theme.textTheme.bodySmall,
                                // ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductForm(),
                                ),
                              ),
                              child: Container(
                                width: 100,
                                height: 40,
                                child: Center(
                                    child: Text(
                                  "Edit",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                )),
                                decoration: BoxDecoration(
                                    //color: Colors.white,
                                    border: Border.all(
                                      color: Color.fromARGB(35, 0, 0, 0),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                            // CustomOutlinedButton(
                            //   width: 150,
                            //     height: 40,
                            //   text: "Delete",
                            //   buttonTextStyle: TextStyle(color: Colors.blue),
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomOutlinedButton(
                              width: 100,
                              height: 40,
                              text: "Delete",
                              buttonTextStyle: TextStyle(color: Colors.black54),

                              // Add onPressed callback for the Delete button
                              onPressed: () {
                                // Add your logic for deleting here
                                // For example, you can show a confirmation dialog and then delete the address
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Delete Product"),
                                    content: Text(
                                        "Are you sure you want to delete this product?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Add logic to delete the address here
                                          // You can use setState or any state management solution to update the UI
                                          setState(() {
                                            productes.removeAt(index);
                                          });
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: Text("Delete"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
      // bottomNavigationBar:  BottomAppBar(
      //   // shape: CircularNotchedRectangle(),
      //     child: Container(

      //   height: 50,
      //   color: Colors.yellow,
      // ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (value) {
          setState(() {
            //indexPage = value;
          });
        },
        unselectedItemColor: Colors.black26,
        useLegacyColorScheme: false,
        backgroundColor: Color.fromARGB(255, 98, 170, 212),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_sharp),
            label: "Category",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.cart),
            label: "Order",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.person_alt_circle,
            ),
            label: "Profile",
          ),
        ],
        //currentIndex: indexPage,
        iconSize: 25,
        selectedFontSize: 8,
        selectedItemColor: Colors.blue.shade400,
      ),
    );
  }
}

Widget _buildAddAddressButton(BuildContext context) {
  return CustomElevatedButton(
      height: 40,
      width: 150,
      text: "Add Address",
      buttonTextStyle: TextStyle(fontSize: 18),
      margin: EdgeInsets.only(left: 16.h, right: 16.h, bottom: 25.h));
}
