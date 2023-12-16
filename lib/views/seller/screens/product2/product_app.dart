// products_app.dart

import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/views/seller/screens/product2/display_product_screen.dart';
import 'package:flutter/material.dart';

import 'add_product_screen.dart';

class ProductsApp extends StatefulWidget {
  @override
  _ProductsAppState createState() => _ProductsAppState();
}

class _ProductsAppState extends State<ProductsApp> {
  List<Product> products = [
    Product(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: 'Product 1',
      price: 20,
      images: [
        // "https://t3.ftcdn.net/jpg/06/49/51/82/360_F_649518247_J27irz9TezhqqHS6EpF0AQY7bFdVAIn8.jpg",
        "https://images.unsplash.com/photo-1541963463532-d68292c34b19?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1575936123452-b67c3203c357?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D",
        "https://images.pexels.com/photos/11061877/pexels-photo-11061877.jpeg?cs=srgb&dl=pexels-bailey-dill-11061877.jpg&fm=jpg"
      ], // Example image path
      availableQuantity: 5,
    ),
    Product(
      id: DateTime.now()
          .add(Duration(days: 1))
          .millisecondsSinceEpoch
          .toString(),
      name: 'Product 2',
      price: 15,
      images: [
        // "https://t3.ftcdn.net/jpg/06/49/51/82/360_F_649518247_J27irz9TezhqqHS6EpF0AQY7bFdVAIn8.jpg",
        "https://images.unsplash.com/photo-1541963463532-d68292c34b19?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1575936123452-b67c3203c357?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D",
        "https://images.pexels.com/photos/11061877/pexels-photo-11061877.jpeg?cs=srgb&dl=pexels-bailey-dill-11061877.jpg&fm=jpg"
      ], // Example image path
      availableQuantity: 5,
    ),
    // Add more products if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products App'),
      ),
      body: DisplayProductsScreen(
        products: products,
        onProductDeleted: _deleteProduct,
        onProductUpdated: _updateProduct,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddProductScreen(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToAddProductScreen(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProductScreen(
          products: products,
          onProductAdded: _addProduct,
        ),
      ),
    );
  }

  void _addProduct(Product newProduct) {
    setState(() {
      products.add(newProduct);
    });
  }

  void _updateProduct(Product updatedProduct) {
    setState(() {
      int index =
          products.indexWhere((product) => product.id == updatedProduct.id);
      if (index != -1) {
        products[index] = updatedProduct;
      }
    });
  }

  void _deleteProduct(String productId) {
    setState(() {
      products.removeWhere((product) => product.id == productId);
    });
  }
}
