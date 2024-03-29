import 'dart:io';

import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/city.dart';
import 'package:dpl_ecommerce/models/district.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/repositories/shop_repo.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class GeneralSetting extends StatefulWidget {
  const GeneralSetting({super.key});

  @override
  State<GeneralSetting> createState() => __GeneralSettingState();
}

class __GeneralSettingState extends State<GeneralSetting> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ShopRepo shopRepo = ShopRepo();
  Shop shop = Shop(
    ratingCount: 123,
    totalProduct: 32,
    name: "DK",
    addressInfor: AddressInfor(
        city: City(id: 8, name: "Tuyen Quang"),
        country: "Viet nam",
        isDefaultAddress: false,
        latitude: 123.12,
        longitude: 123,
        name: "My address",
        district: District(id: 123, name: "Hoang Mai")),
    contactPhone: "0987654321",
    id: "shopID01",
    shopDescription:
        "Cultivate your love for gardening with Green Thumb Nursery. We offer a variety of plants, gardening tools, and expert advice to help you create a vibrant and thriving garden.",
    logo:
        "https://cdn.shopify.com/shopifycloud/hatchful_web_two/bundles/4a14e7b2de7f6eaf5a6c98cb8c00b8de.png",
    rating: 4.4,
    shopView: 120,
  );

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    _nameController.text = shop.name ?? "";
    _phoneController.text = shop.contactPhone ?? "";
    _descriptionController.text = shop.shopDescription ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('General Setting'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buidck(
                    name: shop.name ?? "",
                    hintname: "Shop name",
                    namevalue: "Shop name",
                    namctr: _nameController),
                SizedBox(
                  height: 20.h,
                ),
                Text("Shop Logo"),
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 50.h,
                        width: MediaQuery.of(context).size.width * 0.7,
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
                        width: 75.w,
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
                SizedBox(
                  height: 10.h,
                ),
                _image == null
                    ? Icon(
                        Icons.add_a_photo_outlined,
                        size: 80,
                        color: Colors.black38,
                      )
                    : Image.file(
                        _image!,
                        height: 80.h,
                      ),
                SizedBox(
                  height: 20.h,
                ),
                _buidck(
                    name: shop.contactPhone ?? "",
                    hintname: "Phone number",
                    namevalue: "Phone number",
                    namctr: _phoneController,
                    textInputType: TextInputType.phone),
                SizedBox(
                  height: 20.h,
                ),
                _buidck(
                    name: shop.shopDescription ?? "",
                    hintname: "description",
                    namevalue: "description",
                    namctr: _descriptionController,
                    maxLines: 5),
                SizedBox(
                  height: 20.h,
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
            if (_formKey.currentState!.validate()) {
              await shopRepo.updateShop(
                  shopID: "shopID",
                  logo: _image!.path,
                  contactPhone: _phoneController.text,
                  name: _nameController.text,
                  shopDescription: _descriptionController.text);
            }
          },
          child: Text(
            'Save',
            style: TextStyle(fontSize: 18.sp),
          ),
        ),
      ),
    );
  }

  Widget _buidck({
    required String name,
    required String hintname,
    required String namevalue,
    required TextEditingController namctr,
    int maxLines = 1,
    TextInputType textInputType = TextInputType.text,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(name),
          SizedBox(
            height: 10.h,
          ),
          TextFormField(
            maxLines: maxLines,
            keyboardType: textInputType,
            controller: namctr,
            decoration: InputDecoration(
              hintText: hintname,
              hintStyle: TextStyle(color: Colors.grey),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
              filled: true,
              hoverColor: Color(0XFFDADADA),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter " + namevalue;
              }
              return null;
            },
            // onSaved: (value) {
            //   namctr;
            // },
          ),
        ],
      );
}
