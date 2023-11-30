// add_product_screen.dart

import 'dart:io';

import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/views/seller/screens/product/product_app.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';


class AddProductScreen extends StatefulWidget {
  final List<Product> products;
  final Function(Product) onProductAdded;
  
  
  AddProductScreen({required this.products, required this.onProductAdded});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController _availableQuantityController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  
  String? _imagePath;

  String? name;
  String? description;
  int? availableQuantity;
  int? price;
  List<String>? types;
  List<String>? colors;
  List<String>? size;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
      ),
      body:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Product information",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Product name"),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      filled: true,
                      hoverColor: appTheme.gray300,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a product number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _nameController ;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Category"),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownSearch(
                    items: ["Dress", "Shirt", "Hat", "Glover"],
                    dropdownDecoratorProps: DropDownDecoratorProps(),
                    onChanged: print,
                    selectedItem: "Hat",
                    validator: (String? item) {
                      if (item == null)
                        return "Required field";
                      else if (item == "Brazil")
                        return "Invalid item";
                      else
                        return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Text("Quantity"),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _availableQuantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      filled: true,
                      hoverColor: appTheme.gray300,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter  a price';
                      }

                      // Kiểm tra xem giá trị có phải là số nguyên dương hay không
                      if (int.tryParse(value) == null ||
                          int.parse(value) <= 0) {
                        return 'Please enter a positive integer for price';
                      }

                      return null;
                    },
                    onSaved: (value) {
                      // Lưu giá trị chỉ khi nó là một số nguyên dương
                      if (int.tryParse(value!) != null &&
                          int.parse(value) > 0) {
                        _availableQuantityController ;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Price"),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      filled: true,
                      hoverColor: appTheme.gray300,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter  a price';
                      }

                      // Kiểm tra xem giá trị có phải là số nguyên dương hay không
                      if (int.tryParse(value) == null ||
                          int.parse(value) <= 0) {
                        return 'Please enter a positive integer for price';
                      }

                      return null;
                    },
                    onSaved: (value) {
                      // Lưu giá trị chỉ khi nó là một số nguyên dương
                      if (int.tryParse(value!) != null &&
                          int.parse(value) > 0) {
                        _priceController;
                      }
                    },
                  ),
                   const SizedBox(
                    height: 10,
                  ),
                  Text("Type"),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      filled: true,
                      hoverColor: appTheme.gray300,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      // if (value == null || value.isEmpty) {
                      //   return 'Please enter a typer';
                      // }
                      // return null;
                    },
                    onSaved: (value) {
                      types = value as List<String>?;
                    },
                  ),
                   const SizedBox(
                    height: 10,
                  ),
                  Text("Size"),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      filled: true,
                      hoverColor: appTheme.gray300,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a size';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      size = value as List<String>?;
                    },
                  ),
                   const SizedBox(
                    height: 10,
                  ),
                  Text("Colors"),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      filled: true,
                      hoverColor: appTheme.gray300,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a colors';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      colors = value as List<String>?;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Description"),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      filled: true,
                      hoverColor: appTheme.gray300,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      description = value;
                    },
                  ),

                   SizedBox(
                    height: 10.h,
                  ),
                  
                  Text("Image"),
                   SizedBox(
                    height: 10.h,
                  ),
                   
                  GestureDetector(
                     onTap: () {
            _pickImage();
          },
                    child: Row(
                      children: [
                        Container(
                          height: 50.h,
                          width: 260.w,
                          //child: Center(child: Text("Choose file")),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Choose file",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(110, 218, 218, 218),
                              width: 2,
                            ),
                            color: Colors.white10,
                            //color: Color.fromARGB(110, 218, 218, 218),
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(10),
                            ),
                          ),
                        ),
                        Container(
                          height: 50.h,
                          width: 70.w,
                          child: Center(child: Text("Brower")),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(110, 218, 218, 218),
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _imagePath == null
            ? Icon(
                Icons.add_a_photo_outlined,
                size: 40,
                color: Colors.black38,
              )
            : Image.file(
                File(_imagePath!),
                height: 40,
              ),

                  
                  // Các trường khác tương tự
                  SizedBox(height: 16),
                  Text("Video"),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 50.h,
                        width: 260.w,
                        //child: Center(child: Text("Choose file")),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Choose file",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(110, 218, 218, 218),
                            width: 2,
                          ),
                          color: Colors.white10,
                          //color: Color.fromARGB(110, 218, 218, 218),
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(10),
                          ),
                        ),
                      ),
                      Container(
                        height: 50.h,
                        width: 70.w,
                        child: Center(child: Text("Brower")),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(110, 218, 218, 218),
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.video_library_outlined,
                  size: 40,
                color: Colors.black38
                  
                  ),
                  const SizedBox(height: 10,),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 40,
          width: 370,
          margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 25.h),
          child: ElevatedButton(
            // onPressed: () {
            //   if (_formKey.currentState?.validate() ?? false) {
            //     _formKey.currentState?.save();
            //     Product newProduct = Product(name: name, price: price,availableQuantity: availableQuantity,);
            //       widget.onProductAdded(newProduct);

            //       // Clear text fields
            //       _nameController.clear();
            //       _priceController.clear();
            //       _quantityController.clear();
            //   }
            // },
             onPressed: () {
                // String name = _nameController.text;
                // //double price = double.tryParse(_priceController.text) ?? 0.0;
               _addProduct(context);
                // if (name.isNotEmpty) {
                //   Product newProduct = Product(name: name,);
                //   widget.onProductAdded(newProduct);

                //   // Clear text fields
                //   _nameController.clear();
                //   _priceController.clear();
                // }
              },
            child: Text(
              'Add Product',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
    );
  }

  void _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? shopLogo = await _picker.pickImage(source: ImageSource.gallery);

    if (shopLogo != null) {
      setState(() {
        _imagePath = shopLogo.path;
      });
    }
  }

  void _addProduct(BuildContext context) {
    String name = _nameController.text;
    String priceString = _priceController.text;
    String availableQuantity1 = _availableQuantityController.text;

    if (name.isNotEmpty && priceString.isNotEmpty&& availableQuantity1.isNotEmpty ) {
      int price = int.tryParse(priceString) ?? 0;
      int availableQuantity = int.tryParse(availableQuantity1) ?? 0;
      if (price > 0) {
        Product newProduct = Product(
          ratingCount: DateTime.now().millisecondsSinceEpoch,
          name: name,
          price: price,
           shopLogo: _imagePath!,
           availableQuantity: availableQuantity,
        );
        widget.onProductAdded(newProduct);

        // Clear text fields and image path
        _nameController.clear();
        _priceController.clear();
        _imagePath = null;

        // Navigate to ProductsApp
        Navigator.pop(
          context,
          MaterialPageRoute(
            builder: (context) => ProductsApp(products: widget.products),
          ),
        );
       
      }
    }
  }
}


