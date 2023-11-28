import 'dart:io';

import 'package:dpl_ecommerce/const/app_theme.dart';

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dpl_ecommerce/models/product.dart';

class ProductForm extends StatefulWidget {
  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  File? _image;

  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  String? district;
  bool isDefaultAddress = false;
  String? name;
  String? description;
  int? availableQuantity;
  int? price;
  List<String>? types;
  List<String>? colors;
  List<String>? size;
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            " Add New Product ",
            textAlign: TextAlign.center,
          ),
          centerTitle: true,

          //leading: Icon(Icons.menu),
        ),
        body: SingleChildScrollView(
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
                      name = value;
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
                        return 'Please enter  a quantity';
                      }

                      // Kiểm tra xem giá trị có phải là số nguyên dương hay không
                      if (int.tryParse(value) == null ||
                          int.parse(value) <= 0) {
                        return 'Please enter a positive integer for quantity';
                      }

                      return null;
                    },
                    onSaved: (value) {
                      // Lưu giá trị chỉ khi nó là một số nguyên dương
                      if (int.tryParse(value!) != null &&
                          int.parse(value) > 0) {
                        availableQuantity = value as int?;
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
                        availableQuantity = value as int?;
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

                  const SizedBox(
                    height: 10,
                  ),
                  Text("Gallery Image"),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 290,
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
                        height: 50,
                        width: 70,
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
                  const SizedBox(height: 10,),
                  Text("Video"),
                  const SizedBox(
                    height: 10,
                  ),
                   
                  GestureDetector(
                     onTap: () {
            getImage();
          },
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 290,
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
                          height: 50,
                          width: 70,
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
                  _image == null
            ? Icon(
                Icons.add_a_photo_outlined,
                size: 40,
                color: Colors.black38,
              )
            : Image.file(
                _image!,
                height: 40,
              ),

                  
                  // Các trường khác tương tự
                  SizedBox(height: 16),
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
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();

                // Thực hiện thêm địa chỉ vào cơ sở dữ liệu hoặc xử lý tương ứng
                print('Address added successfully');
              }
            },
            child: Text(
              'Add Product',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget

  /// Section Widget
// Widget _buildAddAddressButton(BuildContext context) {
//     return CustomElevatedButton(
//       height: 40,
//       width: 370,
//         text: "Add Address",
//         buttonTextStyle: TextStyle(fontSize: 18),
//         margin: EdgeInsets.only(left: 16.h, right: 16.h, bottom: 25.v));

//   }
}

class _formKey {}
