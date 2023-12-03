import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/customs/custom_text_form_field.dart';
import 'package:dpl_ecommerce/views/consumer/screens/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddAddress extends StatelessWidget {
  AddAddress({super.key});

  // final _formKey = GlobalKey<FormState>();
  TextEditingController? countryController = TextEditingController();

  TextEditingController? cityController = TextEditingController();

  TextEditingController? disctrictController = TextEditingController();

  TextEditingController? longitudeController = TextEditingController();

  TextEditingController? latitudeController = TextEditingController();

  TextEditingController? nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomArrayBackWidget(),
        title: Text("Add new Address 1"),
      ),
      body: Padding(
          padding: EdgeInsets.all(3.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: ScreenUtil().screenHeight * 0.1,
              ),
              // CustomTextFormField(
              //   controller: countryController,
              //   hintText: "Nani",
              // ),
              TextField(
                onTap: () {
                  print("ON tap country");
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => ChatPage()));
                },
                onChanged: (value) {
                  print("On change: $value");
                },
                focusNode: FocusNode(),
                controller: countryController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                    hintText: "Country"),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextField(
                  // controller: cityController,
                  // decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10.r)),
                  //     hintText: "City"),
                  ),
              SizedBox(
                height: 20.h,
              ),
              TextField(
                controller: disctrictController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                    hintText: "District"),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: longitudeController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                    hintText: "Longitude"),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: latitudeController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                    hintText: "Latitude"),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                    hintText: "Name"),
              ),
              SizedBox(
                height: 20.h,
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(10.h),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Add"),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)))),
                ),
              )
            ],
          )),
    );
  }
}
