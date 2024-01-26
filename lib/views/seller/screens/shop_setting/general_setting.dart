import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/city.dart';
import 'package:dpl_ecommerce/models/district.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/repositories/shop_repo.dart';
import 'package:dpl_ecommerce/services/storage_services/storage_service.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/seller/shop_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class GeneralSetting extends StatefulWidget {
  GeneralSetting({super.key, required this.shopID});
  String shopID;

  @override
  State<GeneralSetting> createState() => __GeneralSettingState();
}

class __GeneralSettingState extends State<GeneralSetting> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  StorageService storageService = StorageService();

  ShopRepo shopRepo = ShopRepo();
  // Shop shop = Shop(
  //   ratingCount: 123,
  //   totalProduct: 32,
  //   name: "DK",
  //   addressInfor: AddressInfor(
  //       city: City(id: 8, name: "Tuyen Quang"),
  //       country: "Viet nam",
  //       isDefaultAddress: false,
  //       latitude: 123.12,
  //       longitude: 123,
  //       name: "My address",
  //       district: District(id: 123, name: "Hoang Mai")),
  //   contactPhone: "0987654321",
  //   id: "shopID01",
  //   shopDescription:
  //       "Cultivate your love for gardening with Green Thumb Nursery. We offer a variety of plants, gardening tools, and expert advice to help you create a vibrant and thriving garden.",
  //   logo:
  //       "https://cdn.shopify.com/shopifycloud/hatchful_web_two/bundles/4a14e7b2de7f6eaf5a6c98cb8c00b8de.png",
  //   rating: 4.4,
  //   shopView: 120,
  // );
  Shop? shop;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void reset() {
    _nameController.clear();
    _phoneController.clear();
    _descriptionController.clear();
    _image = null;
    urlImage = null;
    pickedFile = null;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> onRefresh() async {
    reset();
    await fetchData();
  }

  Future<void> fetchData() async {
    shop = await shopRepo.getShopByID(widget.shopID);
    isLoading = false;
    _nameController.text = shop!.name ?? "";
    _phoneController.text = shop!.contactPhone ?? "";
    _descriptionController.text = shop!.shopDescription ?? "";
    urlImage = shop!.logo;
    if (mounted) {
      setState(() {});
    }
  }

  File? _image;
  String? urlImage;
  XFile? pickedFile;
  Future<void> pickImage() async {
    pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    // setState(() {
    if (pickedFile != null) {
      _image = File(pickedFile!.path);
    }
    // });
    setState(() {});
  }

  Future getImage(String shopID) async {
    bool isSuccess = await storageService.uploadFile(
      filePath: pickedFile!.path,
      fileName: pickedFile!.name,
      rootRef: 'shopLogos',
      secondRef: shopID,
    );
    if (isSuccess) {
      urlImage = await storageService.downloadURL(
        filePath: pickedFile!.path,
        fileName: pickedFile!.name,
        rootRef: 'shopLogos',
        secondRef: shopID,
      );
      setState(() {});
    }
  }

  @override
  void dispose() {
    _nameController.clear();
    _descriptionController.clear();
    _phoneController.clear();
    super.dispose();
  }

  // Future<void> fetchData() async {
  //   _nameController.text = widget.shop.name ?? "";
  //   _phoneController.text = widget.shop.contactPhone ?? "";
  //   _descriptionController.text = widget.shop.shopDescription ?? "";
  //   urlImage = widget.shop.logo;
  // }

  @override
  Widget build(BuildContext context) {
    final shopProvider = Provider.of<ShopViewModel>(context);
    // final shop = shopProvider.shop;

    return Scaffold(
      appBar: CustomAppBar(
              context: context,
              title: LangText(context: context).getLocal()!.general_setting_ucf,
              centerTitle: true)
          .show(),
      body: SingleChildScrollView(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : shop == null
                ? Container()
                : Padding(
                    padding: EdgeInsets.all(15.h),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buidck(
                              name: LangText(context: context)
                                  .getLocal()!
                                  .shop_name,
                              hintname: LangText(context: context)
                                  .getLocal()!
                                  .shop_name,
                              namevalue: LangText(context: context)
                                  .getLocal()!
                                  .shop_name,
                              namctr: _nameController),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(LangText(context: context)
                              .getLocal()!
                              .shop_logo_ucf),
                          SizedBox(
                            height: 10.h,
                          ),
                          GestureDetector(
                            onTap: () async {
                              // await getImage(shop!.id!);
                              await pickImage();
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 50.h,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
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
                                  width: 75.w,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(110, 218, 218, 218),
                                    borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(10.r),
                                    ),
                                  ),
                                  child: Center(
                                      child: Text(LangText(context: context)
                                          .getLocal()!
                                          .brower)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          (_image == null
                              ? urlImage != null
                                  ? CachedNetworkImage(
                                      imageUrl: urlImage!,
                                      imageBuilder: (context, imageProvider) {
                                        return Container(
                                          height: 90.h,
                                          width: 90.h,
                                          padding: EdgeInsets.all(2.h),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: imageProvider)),
                                        );
                                      },
                                      placeholder: (context, url) => Center(
                                          child: SizedBox(
                                              width: 30.h,
                                              height: 30.h,
                                              child:
                                                  const CircularProgressIndicator())),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                              alignment: Alignment.centerLeft,
                                              height: 90.h,
                                              width: 90.h,
                                              decoration: BoxDecoration(
                                                  // shape: BoxShape.circle,
                                                  color: MyTheme.green_light),
                                              child: Center(
                                                child: Icon(
                                                  Icons.error,
                                                  size: 30.h,
                                                ),
                                              )),
                                    )
                                  : const Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 80,
                                      color: Colors.black38,
                                    )
                              : Image.file(
                                  _image!,
                                  height: 90.h,
                                  width: 90.h,
                                )),
                          SizedBox(
                            height: 20.h,
                          ),
                          _buidck(
                              name: LangText(context: context)
                                  .getLocal()!
                                  .phone_number_ucf,
                              hintname: LangText(context: context)
                                  .getLocal()!
                                  .phone_number_ucf,
                              namevalue: LangText(context: context)
                                  .getLocal()!
                                  .phone_number_ucf,
                              namctr: _phoneController,
                              textInputType: TextInputType.phone),
                          SizedBox(
                            height: 20.h,
                          ),
                          _buidck(
                              name: LangText(context: context)
                                  .getLocal()!
                                  .description_ucf,
                              hintname: LangText(context: context)
                                  .getLocal()!
                                  .description_ucf,
                              namevalue: LangText(context: context)
                                  .getLocal()!
                                  .description_ucf,
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
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(MyTheme.accent_color)),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await getImage(shop!.id!);
              await shopRepo.updateShop(
                  shopID: shop!.id!,
                  logo: urlImage,
                  contactPhone: _phoneController.text,
                  name: _nameController.text,
                  shopDescription: _descriptionController.text);
              Shop? newShop = await shopRepo.getShopByID(shop!.id!);
              if (newShop != null) {
                shopProvider.setShopInfo(newShop);
              }
              await onRefresh();
            }
          },
          child: Text(
            LangText(context: context).getLocal()!.save_ucf,
            style: TextStyle(fontSize: 18.sp, color: MyTheme.white),
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
          Text(name),
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
                return LangText(context: context).getLocal()!.please_enter +
                    namevalue;
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
