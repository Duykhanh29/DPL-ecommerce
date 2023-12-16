// add_product_screen.dart

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/models/category.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/repositories/category_repo.dart';
import 'package:dpl_ecommerce/utils/common/common_methods.dart';
import 'package:dpl_ecommerce/views/seller/screens/product2/product_app.dart';
import 'package:dpl_ecommerce/views/seller/screens/video_asset_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;
  final Function(Product) onProductUpdated;

  EditProductScreen(
      {required this.product,
      required this.onProductUpdated,
      required List products});
  List<String>? images = [];
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<EditProductScreen> {
  TextEditingController _availableQuantityController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _colorsController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _sizeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // _nameController.text = widget.product.name.toString();
    // _priceController.text = widget.product.price.toString();
    // _availableQuantityController.text =
    //     widget.product.availableQuantity.toString();
    fetchData();
  }

  Future<void> fetchData() async {
    images = widget.product.images;
    description = widget.product.description;
    name = widget.product.name;
    availableQuantity = widget.product.availableQuantity;
    types = widget.product.types;
    colors = widget.product.colors;
    videos = widget.product.videos;
    sizes = widget.product.sizes;
    description = widget.product.description;
    name = widget.product.name;
    availableQuantity = widget.product.availableQuantity;
    types = widget.product.types;
    colors = widget.product.colors;
    selectedCategory = CommondMethods.getCategoryByID(
        widget.product.categoryID!, listCategory!);
    price = widget.product.price;
    initializeText();
  }

  void initializeText() {
    _nameController.text = name ?? "";
    _descriptionController.text = description ?? "";
    _priceController.text = price != null ? price.toString() : "0";
    _availableQuantityController.text = availableQuantity.toString();
  }

  List<String>? images = [];
  List<String>? videos = [];
  String? name;
  String? description;
  int? availableQuantity;
  int? price;
  List<String>? types;
  List<String>? colors;
  List<String>? sizes;
  Category? selectedCategory;
  List<Category>? listCategory = CategoryRepo().list;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Product'),
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
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: _nameController,

                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    filled: true,
                    hoverColor: Color.fromARGB(110, 218, 218, 218),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product number';
                    }
                    return null;
                  },
                  // onSaved: (value) {
                  //   _nameController;
                  // },
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("Category"),
                SizedBox(
                  height: 10.h,
                ),
                DropdownSearch<Category>(
                  items: [selectedCategory!],
                  dropdownDecoratorProps: DropDownDecoratorProps(),
                  // onChanged: print,
                  selectedItem: selectedCategory,
                  itemAsString: (item) => selectedCategory!.name!,
                  // validator: (String? item) {
                  //   if (item == null)
                  //     return "Required field";
                  //   else if (item == "Brazil")
                  //     return "Invalid item";
                  //   else
                  //     return null;
                  // },
                ),
                SizedBox(
                  height: 10.h,
                ),

                Text("Quantity"),
                SizedBox(
                  height: 10.h,
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
                        borderRadius: BorderRadius.circular(10.r),
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
                  onSaved: (value) {
                    // Lưu giá trị chỉ khi nó là một số nguyên dương
                    // if (int.tryParse(value!) != null && int.parse(value) > 0) {
                    //   _availableQuantityController;
                    // }
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text("Price"),
                SizedBox(
                  height: 10.h,
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
                        borderRadius: BorderRadius.circular(10.r),
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
                SizedBox(
                  height: 10.h,
                ),
                Text("Types"),
                SizedBox(
                  height: 10.h,
                ),
                buildWrapTextField(types, _typeController),
                SizedBox(
                  height: 10.h,
                ),
                Text("Sizes"),
                SizedBox(
                  height: 10.h,
                ),
                buildWrapTextField(sizes, _sizeController),
                const SizedBox(
                  height: 10,
                ),
                Text("Colors"),
                SizedBox(
                  height: 10.h,
                ),
                buildWrapTextField(colors, _colorsController),
                SizedBox(
                  height: 10.h,
                ),
                Text("Description"),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  maxLines: 4,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    filled: true,
                    hoverColor: Color.fromARGB(110, 218, 218, 218),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  // onSaved: (value) {
                  //   description = value;
                  // },
                ),

                SizedBox(
                  height: 10.h,
                ),

                Text("Images"),
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
                            right: Radius.circular(10.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                images == null
                    ? Icon(
                        Icons.add_a_photo_outlined,
                        size: 40,
                        color: Colors.black38,
                      )
                    : buildListImage(),

                // Các trường khác tương tự
                SizedBox(height: 16),
                Text("Video"),
                const SizedBox(
                  height: 10,
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
                            right: Radius.circular(10.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                videos != null && videos!.isNotEmpty
                    ? buildListVideo()
                    : Icon(
                        Icons.add_a_photo_outlined,
                        size: 40,
                        color: Colors.black38,
                      ),
                SizedBox(
                  height: 10.h,
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
          onPressed: () {
            _updateProduct();
          },
          child: Text(
            'Update Product',
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

  void _updateProduct() {
    String name = _nameController.text;
    String priceString = _priceController.text;
    String quantityString = _availableQuantityController.text;

    if (name.isNotEmpty &&
        priceString.isNotEmpty &&
        quantityString.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      int price = int.tryParse(priceString) ?? 0;
      int quantity = int.tryParse(quantityString) ?? 0;

      if (price > 0 && quantity >= 0) {
        Product updatedProduct = Product(
          id: widget.product.id,
          name: name,
          price: price,
          images: images,
          availableQuantity: quantity,
          categoryID: selectedCategory!.id,
          colors: colors,
          createdAt: widget.product.createdAt,
          updatedAt: Timestamp.now(),
          description: _descriptionController.text,
          // shopID: ,
          // shopLogo: ,
          sizes: sizes,
          types: types,
          videos: videos,
          // shopName: ,
        );

        widget.onProductUpdated(updatedProduct);

        Navigator.pop(
          context,
          MaterialPageRoute(builder: (context) => ProductsApp()),
        );
        // Close the EditProductScreen after updating
      }
    }
  }
}
