import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/city.dart';
import 'package:dpl_ecommerce/models/district.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/models/verification_form.dart';
import 'package:dpl_ecommerce/repositories/shop_repo.dart';
import 'package:dpl_ecommerce/repositories/verification_form_repo.dart';
import 'package:dpl_ecommerce/services/storage_services/storage_service.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/seller/shop_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Verification extends StatefulWidget {
  Verification({super.key, required this.shopID});
  String shopID;
  @override
  State<Verification> createState() => __VerificationState();
}

class __VerificationState extends State<Verification> {
  FilePickerResult? result;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ShopRepo shopRepo = ShopRepo();

  Future<void> _sendVerificationForm(VerificationForm verificationForm) async {
    await shopRepo.sendVerificationForm(verificationForm: verificationForm);
  }

  VerificationFormRepo verificationFormRepo = VerificationFormRepo();
  TextEditingController homeNumberController = TextEditingController();
  TextEditingController shopNameController = TextEditingController();
  TextEditingController lisenceController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  StorageService storageService = StorageService();
  String? taxPaperPath;
  String? taxPaperName;
  bool isInitial = true;
  File? _image;
  String? urlImage;
  XFile? pickedFile;
  bool? isSend;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    isSend = await verificationFormRepo.isVerificatioinFormExist(widget.shopID);
    isLoading = false;
    setState(() {});
  }

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
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    final shopProvider = Provider.of<ShopViewModel>(context);
    final user = userProvider.currentUser;
    final shop = shopProvider.shop;
    if (shop != null && isInitial) {
      if (shop.contactPhone != null) {
        phoneNumberController.text = shop.contactPhone!;
      }
      if (shop.name != null) {
        shopNameController.text = shop.name!;
      }
      // = shop.contactPhone ?? "";
      // lisenceController.text=shop.
    }

    return Scaffold(
      appBar: CustomAppBar(
              centerTitle: true,
              context: context,
              title: LangText(context: context).getLocal()!.verification_ucf)
          .show(),
      body: isLoading
          ? Container()
          : isSend != null && !isSend!
              ? SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(15.h),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //_buidck(name: "Your name", hintname: "Your name", namevalue: "Your name", namctr: TextEditingController()),
                          SizedBox(
                            height: 20.h,
                          ),
                          _buidck(
                              readOnly: true,
                              textInputType: TextInputType.text,
                              name: "",
                              hintname: LangText(context: context)
                                  .getLocal()!
                                  .shop_name,
                              namevalue: LangText(context: context)
                                  .getLocal()!
                                  .shop_name,
                              namctr: shopNameController),
                          SizedBox(
                            height: 20.h,
                          ),
                          _buidck(
                              textInputType: TextInputType.text,
                              name: "",
                              hintname: LangText(context: context)
                                  .getLocal()!
                                  .license_no_ucf,
                              namevalue: LangText(context: context)
                                  .getLocal()!
                                  .license_no_ucf,
                              namctr: lisenceController),
                          SizedBox(
                            height: 20.h,
                          ),
                          _buidck(
                              textInputType: TextInputType.streetAddress,
                              name: "",
                              hintname: LangText(context: context)
                                  .getLocal()!
                                  .home_number,
                              namevalue: LangText(context: context)
                                  .getLocal()!
                                  .home_number,
                              namctr: homeNumberController),
                          SizedBox(
                            height: 20.h,
                          ),
                          _buidck(
                              readOnly:
                                  shop!.contactPhone != null ? true : false,
                              textInputType: TextInputType.phone,
                              name: "",
                              hintname: LangText(context: context)
                                  .getLocal()!
                                  .phone_number_ucf,
                              namevalue: LangText(context: context)
                                  .getLocal()!
                                  .phone_number_ucf,
                              namctr: phoneNumberController),
                          SizedBox(
                            height: 20.h,
                          ),
                          //_buidck(name: "Email", hintname: "Email", namevalue: "Email", namctr: TextEditingController()),
                          Text(LangText(context: context)
                              .getLocal()!
                              .tax_paper_ucf),
                          SizedBox(
                            height: 10.h,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () async {
                                result = await FilePicker.platform.pickFiles(
                                    allowedExtensions: ['png', 'jpg'],
                                    type: FileType.custom);
                                if (result == null) {
                                  print("No file selected");
                                } else {
                                  setState(() {
                                    _image = File(result!.files.single.path!);
                                    taxPaperPath = result?.files.single.path;
                                    taxPaperName = result?.files.single.name;
                                    print(result?.files.single.name);
                                  });
                                }
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: 50.h,
                                    width: 261.w,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                            Color.fromARGB(110, 218, 218, 218),
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
                                        result != null
                                            ? Text(
                                                result?.files.single.name ?? "",
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                ))
                                            : Text(
                                                LangText(context: context)
                                                    .getLocal()!
                                                    .choose_file,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 50.h,
                                    width: 71.5.w,
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
                          ),
                          _image != null
                              ? Image.file(
                                  _image!,
                                  height: 90.h,
                                  width: 90.h,
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Text(LangText(context: context)
                      .getLocal()!
                      .you_have_sent_verification),
                ),
      bottomNavigationBar: isLoading
          ? Container()
          : isSend != null && !isSend!
              ? Container(
                  height: 40.h,
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin:
                      EdgeInsets.only(left: 16.w, right: 16.w, bottom: 25.h),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (taxPaperName == null || taxPaperPath == null) {
                          //
                        } else {
                          bool isSuccess = await storageService.uploadFile(
                            filePath: taxPaperPath!,
                            fileName: taxPaperName!,
                            rootRef: 'verifications',
                            secondRef: shop!.id,
                          );
                          if (isSuccess) {
                            String url = await storageService.downloadURL(
                              filePath: taxPaperPath!,
                              fileName: taxPaperName!,
                              rootRef: 'verifications',
                              secondRef: shop.id,
                            );
                            VerificationForm verificationForm =
                                VerificationForm(
                                    contactAddress: user!.userInfor!
                                        .sellerInfor!.contactAddress!,
                                    email: user!.email ?? "",
                                    licenseNo: lisenceController.text,
                                    homeNumber: homeNumberController.text,
                                    phoneNumber: phoneNumberController.text,
                                    shopName: shopNameController.text,
                                    taxPaper: url,
                                    sellerID: user.id,
                                    shopID: shop.id);
                            print("OKe: ${verificationForm}");
                            await _sendVerificationForm(verificationForm);
                            await shopRepo.updateShop(
                                shopID: shop.id!,
                                name: shopNameController.text,
                                addressInfor: user
                                    .userInfor!.sellerInfor!.contactAddress!,
                                contactPhone: phoneNumberController.text);
                            Navigator.of(context).pop();
                          }
                        }
                      }
                    },
                    child: Text(
                      LangText(context: context).getLocal()!.send_ucf,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ),
                )
              : const SizedBox(),
    );
  }

  Widget _buidck(
          {required String name,
          required String hintname,
          required String namevalue,
          required TextEditingController namctr,
          required TextInputType textInputType,
          bool readOnly = false}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name),
          SizedBox(
            height: 10.h,
          ),
          TextFormField(
            readOnly: readOnly,
            controller: namctr,
            keyboardType: textInputType,
            decoration: InputDecoration(
              hintText: hintname,
              hintStyle: TextStyle(color: Colors.grey),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
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
            onSaved: (value) {
              namctr;
            },
          ),
        ],
      );
}
