import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/verification_form.dart';
import 'package:dpl_ecommerce/repositories/shop_repo.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

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

  TextEditingController homeNumberController = TextEditingController();
  TextEditingController shopNameController = TextEditingController();
  TextEditingController lisenceController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  String? taxPaper;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verification'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
                    textInputType: TextInputType.text,
                    name: "",
                    hintname: "Shop name",
                    namevalue: "Shop name",
                    namctr: shopNameController),
                SizedBox(
                  height: 20.h,
                ),
                _buidck(
                    textInputType: TextInputType.text,
                    name: "",
                    hintname: "License No",
                    namevalue: "License No",
                    namctr: lisenceController),
                SizedBox(
                  height: 20.h,
                ),
                _buidck(
                    textInputType: TextInputType.streetAddress,
                    name: "",
                    hintname: "Home number",
                    namevalue: "Home number",
                    namctr: homeNumberController),
                SizedBox(
                  height: 20.h,
                ),
                _buidck(
                    textInputType: TextInputType.phone,
                    name: "Phone number",
                    hintname: "Phone number",
                    namevalue: "Phone number",
                    namctr: phoneNumberController),
                SizedBox(
                  height: 20.h,
                ),
                //_buidck(name: "Email", hintname: "Email", namevalue: "Email", namctr: TextEditingController()),
                Text("Tax paper"),
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
                          taxPaper = result?.files.single.path;
                          print(result?.files.single.name);
                        });
                      }
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 50.h,
                          width: 261.w,
                          //child: Center(child: Text("Choose file")),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10.w,
                              ),
                              result != null
                                  ? Text(result?.files.single.name ?? "",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                      ))
                                  : Text(
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
                          width: 71.5.w,
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
                ),
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
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              VerificationForm verificationForm = VerificationForm(
                  contactAddress: AddressInfor(),
                  email: "duykhanh@gmail.com",
                  licenseNo: lisenceController.text,
                  homeNumber: homeNumberController.text,
                  phoneNumber: phoneNumberController.text,
                  shopName: shopNameController.text,
                  taxPaper: taxPaper,
                  sellerID: "sellerID01",
                  shopID: "shopID04");
              print("OKe: ${verificationForm}");
              // await _sendVerificationForm(verificationForm);
              // await shopRepo.updateShop(
              //     shopID: "shopID",
              //     name: shopNameController.text,
              //     // addressInfor:
              //     contactPhone: phoneNumberController.text);
            }
          },
          child: Text(
            'Send',
            style: TextStyle(fontSize: 18.sp),
          ),
        ),
      ),
    );
  }

  Widget _buidck(
          {required String name,
          required String hintname,
          required String namevalue,
          required TextEditingController namctr,
          required TextInputType textInputType}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name),
          SizedBox(
            height: 10.h,
          ),
          TextFormField(
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
                return "Please enter " + namevalue;
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
