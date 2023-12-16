// import 'package:dpl_ecommerce/models/product.dart';
// import 'package:dpl_ecommerce/views/seller/screens/product/display_product_screen.dart';
// import 'package:flutter/material.dart';


// import 'add_product_screen.dart';


// class ProductsApp extends StatefulWidget {
//   final List<Product> products;

//   ProductsApp({required this.products});

//   @override
//   _ProductsAppState createState() => _ProductsAppState();
// }

// class _ProductsAppState extends State<ProductsApp> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Products'),
//       ),
//       body: DisplayProductsScreen(
//         products: widget.products,
//         onProductDeleted: _deleteProduct,
//         onProductUpdated: _updateProduct,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _navigateToAddProductScreen(context);
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   void _navigateToAddProductScreen(BuildContext context) async {
//     await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AddProductScreen(
//           products: widget.products,
//           onProductAdded: _addProduct,
//         ),
//       ),
//     );
//   }

//   void _addProduct(Product newProduct) {
//     setState(() {
//       widget.products.add(newProduct);
//     });
//   }
//   void _updateProduct(Product updatedProduct) {
//     setState(() {
//       int index = widget.products.indexWhere((product) => product.ratingCount == updatedProduct.ratingCount);
//       if (index != -1) {
//         widget.products[index] = updatedProduct;
//       }
//     });
//   }

//   void _deleteProduct(int productId) {
//     setState(() {
//       widget.products.removeWhere((product) => product.ratingCount == productId);
//     });
//   }
// }