// add_product_screen.dart

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/models/category.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/repositories/category_repo.dart';
import 'package:dpl_ecommerce/views/seller/screens/product/product_app.dart';
import 'package:dpl_ecommerce/views/seller/screens/product2/product_app.dart';
import 'package:dpl_ecommerce/views/seller/screens/video_asset_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
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
  TextEditingController _typeController = TextEditingController();
  TextEditingController _sizeController = TextEditingController();
  TextEditingController _colorController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  List<String>? images = [];
  List<String>? videos = [];
  String? name;
  String? description;
  int? availableQuantity;
  int? price;
  List<String>? types = [];
  List<String>? colors = [];
  List<String>? sizes = [];
  Category? selectedCategory;
  List<Category>? listCategory = CategoryRepo().list;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
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
                  controller: _nameController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    filled: true,
                    hoverColor: Color.fromARGB(110, 218, 218, 218),
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
                    _nameController;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("Category"),
                SizedBox(
                  height: 10.h,
                ),
                DropdownSearch<Category>(
                  items: listCategory!,

                  dropdownDecoratorProps: DropDownDecoratorProps(),
                  onChanged: (value) {
                    setState(() {
                      print("Value here: $value");
                      selectedCategory = value!;
                    });
                  },
                  selectedItem: selectedCategory,
                  itemAsString: (item) => item.name!,
                  // validator: (Category? category) {
                  //   if (category == null)
                  //     return "Required field";
                  //   else if (category == "Brazil")
                  //     return "Invalid item";
                  //   else
                  //     return null;
                  // },
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    filled: true,
                    hoverColor: Color.fromARGB(110, 218, 218, 218),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter  a price';
                    }

                    // Kiểm tra xem giá trị có phải là số nguyên dương hay không
                    if (int.tryParse(value) == null || int.parse(value) <= 0) {
                      return 'Please enter a positive integer for price';
                    }

                    return null;
                  },
                  // onSaved: (value) {
                  //   // Lưu giá trị chỉ khi nó là một số nguyên dương
                  //   if (int.tryParse(value!) != null && int.parse(value) > 0) {
                  //     _availableQuantityController;
                  //   }
                  // },
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    filled: true,
                    hoverColor: Color.fromARGB(110, 218, 218, 218),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter  a price';
                    }

                    // Kiểm tra xem giá trị có phải là số nguyên dương hay không
                    if (int.tryParse(value) == null || int.parse(value) <= 0) {
                      return 'Please enter a positive integer for price';
                    }

                    return null;
                  },
                  // onSaved: (value) {
                  //   // Lưu giá trị chỉ khi nó là một số nguyên dương
                  //   if (int.tryParse(value!) != null && int.parse(value) > 0) {
                  //     _priceController;
                  //   }
                  // },
                ),
                const SizedBox(
                  height: 15,
                ),
                Text("Types"),
                SizedBox(
                  height: 10.h,
                ),
                // TextFormField(
                //   decoration: InputDecoration(
                //     contentPadding:
                //         EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                //     filled: true,
                //     hoverColor: Color.fromARGB(110, 218, 218, 218),
                //     border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //         borderSide: BorderSide.none),
                //   ),
                //   validator: (value) {
                //     // if (value == null || value.isEmpty) {
                //     //   return 'Please enter a typer';
                //     // }
                //     // return null;
                //   },
                //   onSaved: (value) {
                //     types = value as List<String>?;
                //   },
                // ),
                buildWrapTextField(types!, _typeController),
                SizedBox(
                  height: 15.h,
                ),
                Text("Size"),
                SizedBox(
                  height: 10.h,
                ),
                buildWrapTextField(sizes!, _sizeController),
                // TextFormField(
                //   decoration: InputDecoration(
                //     contentPadding:
                //         EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                //     filled: true,
                //     hoverColor: Color.fromARGB(110, 218, 218, 218),
                //     border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //         borderSide: BorderSide.none),
                //   ),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter a size';
                //     }
                //     return null;
                //   },
                //   onSaved: (value) {
                //     size = value as List<String>?;
                //   },
                // ),
                SizedBox(
                  height: 15.h,
                ),
                Text("Colors"),
                SizedBox(
                  height: 10.h,
                ),
                // TextFormField(
                //   decoration: InputDecoration(
                //     contentPadding:
                //         EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                //     filled: true,
                //     hoverColor: Color.fromARGB(110, 218, 218, 218),
                //     border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //         borderSide: BorderSide.none),
                //   ),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter a colors';
                //     }
                //     return null;
                //   },
                //   onSaved: (value) {
                //     colors = value as List<String>?;
                //   },
                // ),

                buildWrapTextField(colors!, _colorController),
                SizedBox(
                  height: 15.h,
                ),
                Text("Description"),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    filled: true,
                    hoverColor: Color.fromARGB(110, 218, 218, 218),
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
                    // description = value;
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
                  onTap: () async {
                    await _pickImage();
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
                              width: 10.w,
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
                            left: Radius.circular(10.r),
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
                images == null || images!.isEmpty
                    ? Icon(
                        Icons.add_a_photo_outlined,
                        size: 40,
                        color: Colors.black38,
                      )
                    : buildListImage(),

                // Các trường khác tương tự
                SizedBox(height: 16),
                Text("Video"),
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                  onTap: () async {
                    await _pickVideo();
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
                              width: 10.w,
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
                            left: Radius.circular(10.r),
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
                videos != null && videos!.isNotEmpty
                    ? buildListVideo()
                    : Icon(Icons.video_library_outlined,
                        size: 40, color: Colors.black38),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 40.h,
        width: MediaQuery.of(context).size.width * 0.9,
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

  Widget buildWrapTextField(
      List<String>? list, TextEditingController textEditingController) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      alignment: Alignment.centerLeft,
      constraints: BoxConstraints(minHeight: 40),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.grey.shade300),
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.start,
        clipBehavior: Clip.antiAlias,
        children: List.generate(list!.length + 1, (index) {
          if (index == list!.length) {
            return SizedBox(
              // padding: EdgeInsets.symmetric(horizontal: 5.w),
              height: 45.h,
              child: TextField(
                onSubmitted: (string) {
                  var tag = textEditingController.text
                      .trim()
                      .replaceAll(",", "")
                      .toString();
                  print("tag empty ${tag.isEmpty}");
                  if (tag.isNotEmpty) {
                    if (string.trim().isNotEmpty) {
                      list.add(string.trim());
                    }
                    textEditingController.clear();
                  }
                },
                onChanged: (string) {
                  if (string.trim().contains(",")) {
                    var tag = string.trim().replaceAll(",", "").toString();
                    print("tag empty ${tag.isEmpty}");

                    if (tag.isNotEmpty) {
                      if (string.trim().isNotEmpty) {
                        list.add(string.trim());
                      }
                      textEditingController.clear();
                    }
                  }
                },
                controller: textEditingController,
                keyboardType: TextInputType.text,
                maxLines: 1,
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5.h),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    hintText: "Input"),
              ),
            );
          }
          return Container(
            decoration: BoxDecoration(
                color: Colors.yellow.shade300,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 2, color: Colors.black)),
            constraints: BoxConstraints(
                maxWidth: (MediaQuery.of(context).size.width - 50) / 4),
            margin: const EdgeInsets.only(right: 5, bottom: 5),
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Stack(
              children: [
                Container(
                    padding: EdgeInsets.only(
                        left: 10.w, right: 20.w, top: 2.h, bottom: 2.h),
                    constraints: BoxConstraints(
                        maxWidth: (MediaQuery.of(context).size.width - 50) / 4),
                    child: Text(
                      list[index].toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 10.sp),
                    )),
                Positioned(
                  right: 2.w,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        list.removeAt(index);
                      });
                    },
                    child: Icon(Icons.highlight_remove,
                        size: 15.sp, color: Colors.red),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget buildListImage() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        // width: double.infinity,
        // padding: EdgeInsets.only(left: 10.w,top: 5.h,bottom: 5.h),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return Image.file(
              File(images![index]),
              height: 80.h,
              width: 120.h,
            );
          },
          itemCount: images!.length,
          separatorBuilder: (context, index) => SizedBox(
            width: 10.w,
          ),
          physics: BouncingScrollPhysics(),
          // shrinkWrap: true,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  Widget buildListVideo() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        // width: double.infinity,
        // padding: EdgeInsets.only(left: 10.w,top: 5.h,bottom: 5.h),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return VideoLocalItemWidget(filePath: videos![index]);
          },
          itemCount: videos!.length,
          separatorBuilder: (context, index) => SizedBox(
            width: 10.w,
          ),
          physics: BouncingScrollPhysics(),
          // shrinkWrap: true,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        images!.add(image.path);
        // _imagePath = shopLogo.path;
      });
    }
  }

  Future<void> _pickVideo() async {
    try {
      final filePath = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['mp4']);
      if (filePath != null) {
        setState(() {
          videos!.add(filePath.files.single.path!);
        });
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  void _addProduct(BuildContext context) {
    String name = _nameController.text;
    String priceString = _priceController.text;
    String availableQuantity1 = _availableQuantityController.text;

    if (name.isNotEmpty &&
        priceString.isNotEmpty &&
        availableQuantity1.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      int price = int.tryParse(priceString) ?? 0;
      int availableQuantity = int.tryParse(availableQuantity1) ?? 0;
      if (price > 0) {
        Product newProduct = Product(
          images: images,
          name: name,
          price: price,
          availableQuantity: availableQuantity,
          videos: videos,
          sizes: sizes,
          colors: colors,
          categoryID: selectedCategory!.id,
          createdAt: Timestamp.now(),
          updatedAt: Timestamp.now(),
          description: _descriptionController.text,
          reviewIDs: [],

          // shopLogo: ,
          // shopID: ,
          // voucherID: ,
          // shopName: ,
          types: types,
        );
        widget.onProductAdded(newProduct);

        // Clear text fields and image path
        _nameController.clear();
        _priceController.clear();

        // Navigate to ProductsApp
        Navigator.pop(
          context,
          MaterialPageRoute(
            builder: (context) => ProductsApp(),
          ),
        );
      }
    }
  }
}
