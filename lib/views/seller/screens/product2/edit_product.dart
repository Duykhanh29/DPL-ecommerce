// add_product_screen.dart

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/models/category.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/repositories/category_repo.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/services/storage_services/storage_service.dart';
import 'package:dpl_ecommerce/utils/common/common_methods.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/seller/shop_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/seller/screens/product2/product_app.dart';
import 'package:dpl_ecommerce/views/seller/ui_elements/video_asset_widget.dart';
import 'package:dpl_ecommerce/views/seller/ui_elements/video_network_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;

  EditProductScreen({
    required this.product,
  });
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

    fetchAllData();
  }

  fetchAllData() async {
    await fetchCategories();
    await fetchData();
  }

  fetchCategories() async {
    selectedCategory =
        await categoryRepo.getCategoryByID(widget.product.categoryID!);
    setState(() {});
  }

  Future<void> fetchData() async {
    images = widget.product.images;
    description = widget.product.description;
    print("Des: $description");
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
    // selectedCategory = CommondMethods.getCategoryByID(
    //     widget.product.categoryID!, listCategory!);
    price = widget.product.price;
    initializeText();
    setState(() {});
  }

  void initializeText() {
    _nameController.text = name ?? "";
    _descriptionController.text = description ?? "";
    _priceController.text = price != null ? price.toString() : "0";
    _availableQuantityController.text = availableQuantity.toString();
    setState(() {});
  }

  List<String>? images = [];
  List<String>? videos = [];
  List<XFile>? listImage = [];
  List<PlatformFile>? listVideo = [];
  String? name;
  String? description;
  int? availableQuantity;
  int? price;
  List<String>? types;
  List<String>? colors;
  List<String>? sizes;
  Category? selectedCategory;
  List<Category>? listCategory;
  CategoryRepo categoryRepo = CategoryRepo();
  final _formKey = GlobalKey<FormState>();
  StorageService storageService = StorageService();
  ProductRepo productRepo = ProductRepo();
  @override
  Widget build(BuildContext context) {
    final shopProvider = Provider.of<ShopViewModel>(context);
    final shop = shopProvider.shop;
    final userProvider = Provider.of<UserViewModel>(context);
    final user = userProvider.currentUser;
    return Scaffold(
      appBar: CustomAppBar(
              centerTitle: true,
              context: context,
              title: LangText(context: context).getLocal()!.update_product_ucf)
          .show(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LangText(context: context)
                      .getLocal()!
                      .product_information_ucf,
                  style: TextStyle(fontSize: 20.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(LangText(context: context).getLocal()!.product_name_ucf),
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
                      return LangText(context: context)
                          .getLocal()!
                          .please_enter_number;
                    }
                    return null;
                  },
                  // onSaved: (value) {
                  //   _nameController;
                  // },
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(LangText(context: context).getLocal()!.category_ucf),
                SizedBox(
                  height: 10.h,
                ),
                selectedCategory != null
                    ? DropdownSearch<Category>(
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
                      )
                    : Container(),
                SizedBox(
                  height: 10.h,
                ),

                Text(LangText(context: context).getLocal()!.quantity_ucf),
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
                      return LangText(context: context)
                          .getLocal()!
                          .please_enter_quantity;
                    }

                    // Kiểm tra xem giá trị có phải là số nguyên dương hay không
                    if (int.tryParse(value) == null || int.parse(value) <= 0) {
                      return LangText(context: context)
                          .getLocal()!
                          .please_enter_positive_integer;
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
                Text(LangText(context: context).getLocal()!.price_ucf),
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
                      return LangText(context: context)
                          .getLocal()!
                          .please_enter_price;
                    }

                    // Kiểm tra xem giá trị có phải là số nguyên dương hay không
                    if (int.tryParse(value) == null || int.parse(value) <= 0) {
                      return LangText(context: context)
                          .getLocal()!
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
                  height: 10.h,
                ),
                Text(LangText(context: context).getLocal()!.types_ucf),
                SizedBox(
                  height: 10.h,
                ),
                types == null
                    ? Container()
                    : buildWrapTextField(types, _typeController),
                SizedBox(
                  height: 10.h,
                ),
                Text(LangText(context: context).getLocal()!.sizes_ucf),
                SizedBox(
                  height: 10.h,
                ),
                sizes == null
                    ? Container()
                    : buildWrapTextField(sizes, _sizeController),
                const SizedBox(
                  height: 10,
                ),
                Text(LangText(context: context).getLocal()!.colors_ucf),
                SizedBox(
                  height: 10.h,
                ),
                colors == null
                    ? Container()
                    : buildWrapTextField(colors, _colorsController),
                SizedBox(
                  height: 10.h,
                ),
                Text(LangText(context: context)
                    .getLocal()!
                    .product_description_ucf),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  maxLines: 4,
                  controller: _descriptionController,
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
                      return LangText(context: context)
                          .getLocal()!
                          .please_enter_description;
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

                Text(LangText(context: context).getLocal()!.product_images_ucf),
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
                              LangText(context: context)
                                  .getLocal()!
                                  .choose_file,
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
                            child: Text(
                                LangText(context: context).getLocal()!.brower)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
                (images == null || images!.isEmpty)
                    ? (listImage == null || listImage!.isEmpty
                        ? Icon(
                            Icons.add_a_photo_outlined,
                            size: 40.h,
                            color: Colors.black38,
                          )
                        : Container())
                    : buildListImage(),
                SizedBox(height: 5.h),
                listImage == null || listImage!.isEmpty
                    ? Container()
                    : buildNewListImage(),
                // Các trường khác tương tự
                SizedBox(height: 16.h),
                Text(LangText(context: context).getLocal()!.product_videos_ucf),
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
                              LangText(context: context)
                                  .getLocal()!
                                  .choose_file,
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
                            child: Text(
                                LangText(context: context).getLocal()!.brower)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
                (videos == null || videos!.isEmpty)
                    ? (listVideo == null || listVideo!.isEmpty
                        ? Icon(
                            Icons.add_a_photo_outlined,
                            size: 40.h,
                            color: Colors.black38,
                          )
                        : Container())
                    : buildListVideo(),

                SizedBox(
                  height: 5.h,
                ),
                listVideo == null || listVideo!.isEmpty
                    ? Container()
                    : buildNewListVideo(),
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
          onPressed: () async {
            await _updateProduct(shop!);
          },
          child: Text(
            LangText(context: context).getLocal()!.update_product_ucf,
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
                    hintText: LangText(context: context).getLocal()!.input_ucf),
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
                CachedNetworkImage(
                  imageUrl: images![index],
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      height: 80.h,
                      width: 80.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.contain),
                      ),
                    );
                  },
                  placeholder: (context, url) => Center(
                      child: SizedBox(
                          width: 30.h,
                          height: 30.h,
                          child: const CircularProgressIndicator())),
                  errorWidget: (context, url, error) => Center(
                      child: Icon(
                    Icons.error,
                    size: 10.h,
                  )),
                ),
                Positioned(
                    top: 5.h,
                    right: 5.h,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          images!.removeAt(index);
                        });
                      },
                      child: Icon(
                        Icons.close,
                        size: 12.h,
                      ),
                    )),
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

  Widget buildNewListImage() {
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
                  File(listImage![index].path),
                  height: 80.h,
                  width: 80.h,
                  fit: BoxFit.contain,
                ),
                Positioned(
                    top: 5.h,
                    right: 5.h,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          // images!.removeAt(index);
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
          itemCount: listImage!.length,
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
                VideoNetworkItemWidget(
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
                          // listVideo!.removeAt(index);
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

  Widget buildNewListVideo() {
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
                  filePath: listVideo![index].path!,
                  key: UniqueKey(),
                ),
                Positioned(
                    top: 5.h,
                    right: 5.h,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          listVideo!.removeAt(index);
                          // listVideo!.removeAt(index);
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
          itemCount: listVideo!.length,
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
          // videos!.add(filePath.files.single.path!);
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

  Future<void> _updateProduct(Shop shop) async {
    String name = _nameController.text;
    String priceString = _priceController.text;
    String quantityString = _availableQuantityController.text;

    if (name.isNotEmpty &&
        priceString.isNotEmpty &&
        quantityString.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      int price = int.tryParse(priceString) ?? 0;
      int quantity = int.tryParse(quantityString) ?? 0;
      List<String>? productImages;
      List<String>? productVideos;
      if (listImage!.isNotEmpty) {
        List<String>? list =
            await getListUrlImage(listImage!, widget.product.id!);
        if (list != null) {
          if (images != null) {
            productImages = List<String>.from(images! + list);
          } else {
            productImages = list;
          }
        }
      } else {
        productImages = images;
      }
      if (listVideo!.isNotEmpty) {
        List<String>? list =
            await getListUrlVideo(listVideo!, widget.product.id!);
        if (list != null) {
          if (videos != null) {
            productVideos = List<String>.from(videos! + list);
          } else {
            productVideos = list;
          }
        }
      } else {
        productVideos = videos;
      }
      // Future.delayed(const Duration(seconds: 1)).then((value) {
      if (price > 0 && quantity >= 0) {
        Product updatedProduct = Product(
          id: widget.product.id,
          name: name,
          price: price,
          images: productImages,
          availableQuantity: quantity,
          categoryID: selectedCategory!.id,
          colors: colors,
          createdAt: widget.product.createdAt,
          updatedAt: Timestamp.now(),
          description: _descriptionController.text,
          shopID: shop.id,
          shopLogo: shop.logo,
          sizes: sizes,
          types: types,
          videos: productVideos,
          shopName: shop.name,
        );
        await productRepo.updateProduct(
            productID: widget.product.id!,
            colors: colors,
            cost: price,
            description: _descriptionController.text,
            images: productImages,
            videos: productVideos,
            quantity: quantity,
            sizes: sizes,
            types: types);
        // widget.onProductUpdated  (updatedProduct);

        Navigator.pop(
          context,
          MaterialPageRoute(builder: (context) => ProductsApp()),
        );
        // Close the EditProductScreen after updating
      }
      // });
    }
  }
}
