// add_product_screen.dart

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/models/category.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/repositories/category_repo.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/services/storage_services/storage_service.dart';
import 'package:dpl_ecommerce/view_model/seller/shop_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/seller/screens/product/product_app.dart';
import 'package:dpl_ecommerce/views/seller/screens/product2/product_app.dart';
import 'package:dpl_ecommerce/views/seller/ui_elements/video_asset_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddProductScreen extends StatefulWidget {
  // final List<Product> products;
  // final Function(Product) onProductAdded;

  // AddProductScreen({required this.products, required this.onProductAdded});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _availableQuantityController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<String>? images = [];
  List<String>? videos = [];
  List<XFile>? listImage = [];
  List<PlatformFile>? listVideo = [];
  String? name;
  String? description;
  int? availableQuantity;
  int? price;
  List<String>? types = [];
  List<String>? colors = [];
  List<String>? sizes = [];
  Category? selectedCategory;
  List<Category>? listCategory;
  CategoryRepo categoryRepo = CategoryRepo();
  final _formKey = GlobalKey<FormState>();
  StorageService storageService = StorageService();
  ProductRepo productRepo = ProductRepo();
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    listCategory = await categoryRepo.getListCategory();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    final user = userProvider.currentUser;
    final shopProvider = Provider.of<ShopViewModel>(context);
    final shop = shopProvider.shop;

    return Scaffold(
      appBar: CustomAppBar(
              centerTitle: true,
              context: context,
              title: AppLocalizations.of(context)!.add_new_product_ucf)
          .show(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.product_information_ucf,
                  style: TextStyle(fontSize: 20.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(AppLocalizations.of(context)!.product_name_ucf),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    filled: true,
                    hoverColor: Color.fromARGB(110, 218, 218, 218),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!
                          .please_enter_phone_number;
                      ;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _nameController;
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(AppLocalizations.of(context)!.category_ucf),
                SizedBox(
                  height: 10.h,
                ),
                isLoading
                    ? Container()
                    : DropdownSearch<Category>(
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
                SizedBox(
                  height: 10.h,
                ),

                Text(AppLocalizations.of(context)!.quantity_ucf),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: _availableQuantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    filled: true,
                    hoverColor: Color.fromARGB(110, 218, 218, 218),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!
                          .please_enter_quantity;
                    }

                    // Kiểm tra xem giá trị có phải là số nguyên dương hay không
                    if (int.tryParse(value) == null || int.parse(value) <= 0) {
                      return AppLocalizations.of(context)!
                          .please_enter_positive_integer;
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
                SizedBox(
                  height: 10.h,
                ),
                Text(AppLocalizations.of(context)!.price_ucf),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    filled: true,
                    hoverColor: Color.fromARGB(110, 218, 218, 218),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.please_enter_price;
                    }

                    // Kiểm tra xem giá trị có phải là số nguyên dương hay không
                    if (int.tryParse(value) == null || int.parse(value) <= 0) {
                      return AppLocalizations.of(context)!
                          .please_enter_positive_integer;
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
                  height: 15.h,
                ),
                Text(AppLocalizations.of(context)!.types_ucf),
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
                Text(AppLocalizations.of(context)!.sizes_ucf),
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
                Text(AppLocalizations.of(context)!.colors_ucf),
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
                Text(AppLocalizations.of(context)!.description_ucf),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    filled: true,
                    hoverColor: Color.fromARGB(110, 218, 218, 218),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!
                          .please_enter_description;
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

                Text(AppLocalizations.of(context)!.product_images_ucf),
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
                        //child: Center(child: Text("Choose file")),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              AppLocalizations.of(context)!.choose_file,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(110, 218, 218, 218),
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(10.r),
                          ),
                        ),
                        child: Center(
                            child: Text(AppLocalizations.of(context)!.brower)),
                      ),
                    ],
                  ),
                ),
                images == null || images!.isEmpty
                    ? Icon(
                        Icons.add_a_photo_outlined,
                        size: 40.h,
                        color: Colors.black38,
                      )
                    : buildListImage(),

                // Các trường khác tương tự
                SizedBox(height: 16.h),
                Text(AppLocalizations.of(context)!.product_videos_ucf),
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
                        //child: Center(child: Text("Choose file")),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              AppLocalizations.of(context)!.choose_file,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(110, 218, 218, 218),
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(10.r),
                          ),
                        ),
                        child: Center(
                            child: Text(AppLocalizations.of(context)!.brower)),
                      ),
                    ],
                  ),
                ),
                videos != null && videos!.isNotEmpty
                    ? buildListVideo()
                    : Icon(Icons.video_library_outlined,
                        size: 40.h, color: Colors.black38),
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
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(MyTheme.accent_color)),
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
          onPressed: () async {
            await _addProduct(context, shop!);
          },
          child: Text(
            AppLocalizations.of(context)!.add_new_product_ucf,
            style: TextStyle(fontSize: 18.sp),
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
      constraints: BoxConstraints(minHeight: 40.h),
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
                style: TextStyle(fontSize: 16.sp),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5.h),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    hintText: AppLocalizations.of(context)!.input_ucf),
              ),
            );
          }
          return Container(
            decoration: BoxDecoration(
                color: Colors.yellow.shade300,
                borderRadius: BorderRadius.circular(5.r),
                border: Border.all(width: 2, color: Colors.black)),
            constraints: BoxConstraints(
                maxWidth: (MediaQuery.of(context).size.width - 50) / 4),
            margin: EdgeInsets.only(right: 5.w, bottom: 5.w),
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
            return Stack(
              children: [
                Image.file(
                  File(images![index]),
                  height: 80.h,
                  width: 120.h,
                ),
                Positioned(
                    top: 5.h,
                    right: 5.h,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          images!.removeAt(index);
                          listImage!.removeAt(index);
                        });
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 12.h,
                      ),
                    ))
              ],
            );
          },
          itemCount: images!.length,
          separatorBuilder: (context, index) => SizedBox(
            width: 10.w,
          ),
          physics: const BouncingScrollPhysics(),
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
            return Stack(
              children: [
                VideoLocalItemWidget(
                  filePath: videos![index],
                  key: UniqueKey(),
                ),
                Positioned(
                    top: 5.h,
                    right: 5.h,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          videos!.removeAt(index);
                          listVideo!.removeAt(index);
                        });
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 12.h,
                      ),
                    ))
              ],
            );
          },
          itemCount: videos!.length,
          separatorBuilder: (context, index) => SizedBox(
            width: 10.w,
          ),
          physics: const BouncingScrollPhysics(),
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
        listImage!.add(image);
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
          listVideo!.add(filePath.files.single);
          videos!.add(filePath.files.single.path!);
        });
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<String>?> getListUrlImage(
      List<XFile> listImage, String id) async {
    List<String>? list = [];
    for (var image in listImage) {
      bool isSuccess = await storageService.uploadFile(
        filePath: image.path,
        fileName: image.name,
        rootRef: 'products',
        secondRef: id,
        thirdRef: 'images',
      );
      if (isSuccess) {
        String url = await storageService.downloadURL(
            filePath: image.path,
            fileName: image.name,
            secondRef: id,
            rootRef: 'products',
            thirdRef: 'images');
        list!.add(url);
      }
    }
    return list;
  }

  Future<List<String>?> getListUrlVideo(
      List<PlatformFile> listVideo, String id) async {
    List<String>? list = [];
    for (var image in listVideo) {
      bool isSuccess = await storageService.uploadFile(
        filePath: image.path!,
        fileName: image.name,
        rootRef: 'products',
        secondRef: id,
        thirdRef: 'videos',
      );
      if (isSuccess) {
        String url = await storageService.downloadURL(
            filePath: image.path!,
            fileName: image.name,
            secondRef: id,
            rootRef: 'products',
            thirdRef: 'videos');
        list!.add(url);
      }
    }
    return list;
  }

  Future<void> _addProduct(BuildContext context, Shop shop) async {
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
        String id = Uuid().v4();
        List<String>? productImages;
        List<String>? productVideos;
        if (listImage!.isNotEmpty) {
          productImages = await getListUrlImage(listImage!, id);
        }
        if (listVideo!.isNotEmpty) {
          productVideos = await getListUrlVideo(listVideo!, id);
        }
        // Future.delayed(const Duration(seconds: 1)).then((value) {
        Product newProduct = Product(
          shopID: shop.id,
          shopLogo: shop.logo,
          shopName: shop.name,
          id: id,
          images: productImages,
          name: name,
          price: price,
          availableQuantity: availableQuantity,
          videos: productVideos,
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
        await productRepo.addProduct(newProduct, shop.id!);
        // widget.onProductAdded(newProduct);

        // Clear text fields and image path
        _nameController.clear();
        _priceController.clear();

        // Navigate to ProductsApp
        // ignore: use_build_context_synchronously
        Navigator.pop(
          context,
          MaterialPageRoute(
            builder: (context) => ProductsApp(),
          ),
        );
        // });
      }
    }
  }
}
