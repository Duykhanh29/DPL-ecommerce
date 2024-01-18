import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/helpers/toast_helper.dart';
import 'package:dpl_ecommerce/models/category.dart';
import 'package:dpl_ecommerce/repositories/category_repo.dart';
import 'package:dpl_ecommerce/services/storage_services/storage_service.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditCategoryScreen extends StatefulWidget {
  EditCategoryScreen({Key? key, required this.id});
  String id;

  @override
  _EditCategoryScreenState createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  TextEditingController nameController = TextEditingController();
  CategoryRepo categoryRepo = CategoryRepo();
  Category? category;
  bool isLoading = true;
  StorageService storageService = StorageService();
  @override
  void initState() {
    super.initState();
    // nameController.text = widget.category.name ?? '';
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    await fetchData();
    if (category != null) {
      nameController.text = category!.name!;
    }
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> fetchData() async {
    category = await categoryRepo.getCategoryByID(widget.id);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  File? _image;
  String? urlImage;
  String? filePath;
  String? fileName;
  Future<void> _pickImage() async {
    // await category.pickLogo();
    final result = await FilePicker.platform
        .pickFiles(allowedExtensions: ['png', 'jpg'], type: FileType.custom);
    if (result == null) {
    } else {
      setState(() {
        _image = File(result.files.single.path!);
        filePath = result.files.single.path;
        fileName = result.files.single.name;
        print(result.files.single.name);
      });
    }
    setState(() {}); // Cập nhật giao diện để hiển thị ảnh đã chọn.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
              title: LangText(context: context).getLocal()!.update_category,
              centerTitle: true,
              context: context)
          .show(),
      body: Padding(
        padding: EdgeInsets.all(16.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 20.h,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8.h),
                labelText: LangText(context: context).getLocal()!.name_ucf,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.redAccent, width: 1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.redAccent, width: 1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            SizedBox(height: 32.0.h),
            category != null
                ? _image != null
                    ? Image.file(
                        _image!,
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 100.h,
                      )
                    : CachedNetworkImage(
                        imageUrl: category!.logo!,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 120.h,
                            decoration: BoxDecoration(
                                // border: Border.all(
                                //     color: MyTheme.accent_color, width: 0.5),
                                image: DecorationImage(image: imageProvider)),
                          );
                        },
                        errorWidget: (context, url, error) => Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 100.h,
                          child: const Center(
                            child: Icon(Icons.error_outline_rounded),
                          ),
                        ),
                        placeholder: (context, url) => Image.asset(
                          ImageData.placeHolder,
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 120.h,
                        ),
                      )
                : Container(),
            SizedBox(height: 32.0.h),
            GestureDetector(
                onTap: _pickImage,
                child: Container(
                  decoration: BoxDecoration(
                      color: MyTheme.accent_color,
                      borderRadius: BorderRadius.circular(10.r)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 45.h,
                  child: Center(
                      child: Text(
                    LangText(context: context).getLocal()!.pick_another_logo,
                    style: TextStyle(fontSize: 16.sp, color: MyTheme.white),
                  )),
                )),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          if (_image != null) {
            bool isSuccess = await storageService.uploadFile(
              filePath: filePath!,
              fileName: fileName!,
              rootRef: 'categories',
              secondRef: category!.id,
            );
            if (isSuccess) {
              String url = await storageService.downloadURL(
                filePath: filePath!,
                fileName: fileName!,
                rootRef: 'categories',
                secondRef: category!.id,
              );
              if (nameController.text.isEmpty || nameController.text == "") {
                await categoryRepo.editCategory(
                    id: category!.id!, logo: url, name: category!.name);
              } else {
                await categoryRepo.editCategory(
                    id: category!.id!, logo: url, name: nameController.text);
              }

              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            }
          } else if (_image == null &&
              nameController.text != "" &&
              nameController.text.isNotEmpty) {
            await categoryRepo.editCategory(
                id: category!.id!,
                logo: category!.logo,
                name: nameController.text);
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
          } else {
            ToastHelper.showDialog(
                LangText(context: context).getLocal()!.there_are_no_change,
                gravity: ToastGravity.CENTER);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: Container(
              decoration: BoxDecoration(
                  color: MyTheme.accent_color,
                  borderRadius: BorderRadius.circular(10.r)),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50.h,
              child: Center(
                  child: Text(
                LangText(context: context).getLocal()!.update_ucf,
                style: TextStyle(fontSize: 20.sp, color: MyTheme.white),
              ))),
        ),
      ),
    );
  }
}
