import 'dart:io';

import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/helpers/toast_helper.dart';
import 'package:dpl_ecommerce/models/category.dart';
import 'package:dpl_ecommerce/repositories/category_repo.dart';
import 'package:dpl_ecommerce/services/storage_services/storage_service.dart';
import 'package:dpl_ecommerce/utils/common/picker_files.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddCategoryScreen extends StatefulWidget {
  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController nameController = TextEditingController();
  CategoryRepo categoryRepo = CategoryRepo();
  StorageService storageService = StorageService();
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
              title: LangText(context: context).getLocal()!.add_category,
              context: context,
              centerTitle: true)
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
            if (_image != null)
              Image.file(
                _image!,
                width: MediaQuery.of(context).size.width * 0.8,
                height: 120.h,
              ),
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
                    LangText(context: context).getLocal()!.pick_logo,
                    style: TextStyle(fontSize: 16.sp, color: MyTheme.white),
                  )),
                )),
            // ElevatedButton(
            //   onPressed: _pickImage,
            //   child: Text(LangText(context: context).getLocal()!.pick_logo),
            // ),

            SizedBox(height: 32.0.h),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          if (_image != null && nameController.text.isNotEmpty) {
            Category category = Category();
            bool isSuccess = await storageService.uploadFile(
              filePath: filePath!,
              fileName: fileName!,
              rootRef: 'categories',
              secondRef: category.id,
            );
            if (isSuccess) {
              String url = await storageService.downloadURL(
                filePath: filePath!,
                fileName: fileName!,
                rootRef: 'categories',
                secondRef: category.id,
              );
              category.logo = url;
              category.name = nameController.text;
              await categoryRepo.addCategory(category);
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            }
          } else {
            ToastHelper.showDialog(
              LangText(context: context).getLocal()!.add_full_infor,
              gravity: ToastGravity.CENTER,
            );
          }

          // Category category = Category(logo: ,name: nameController.text);
          // await categoryRepo
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
                LangText(context: context).getLocal()!.add_ucf,
                style: TextStyle(fontSize: 20.sp, color: MyTheme.white),
              ))),
        ),
      ),
    );
  }
}
