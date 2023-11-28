import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_elevate_button.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_form_field.dart';

import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressForm extends StatefulWidget {
  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final _formKey = GlobalKey<FormState>();
  String? country;
  String? city;
  String? number;
  String? ward;
  String? district;
  bool isDefaultAddress = false;
  String? name;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "Address",
            textAlign: TextAlign.center,
          ),
          centerTitle: true,

          //leading: Icon(Icons.menu),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  
                  Text("Country"),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownSearch(
                    items: ["Brazil", "France", "Tunisia", "Canada"],
                    dropdownDecoratorProps: DropDownDecoratorProps(),
                    onChanged: print,
                    selectedItem: "Tunisia",
                    validator: (String? item) {
                      if (item == null)
                        return "Required field";
                      else if (item == "Brazil")
                        return "Invalid item";
                      else
                        return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("City"),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownSearch(
                    items: ["Brazil", "France", "Tunisia", "Canada"],
                    dropdownDecoratorProps: DropDownDecoratorProps(),
                    onChanged: print,
                    selectedItem: "Tunisia",
                    validator: (String? item) {
                      if (item == null)
                        return "Required field";
                      else if (item == "Brazil")
                        return "Invalid item";
                      else
                        return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("District"),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownSearch(
                    items: ["Brazil", "France", "Tunisia", "Canada"],
                    dropdownDecoratorProps: DropDownDecoratorProps(),
                    onChanged: print,
                    selectedItem: "Tunisia",
                    validator: (String? item) {
                      if (item == null)
                        return "Required field";
                      else if (item == "Brazil")
                        return "Invalid item";
                      else
                        return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Text("Ward"),
                  const SizedBox(
                    height: 10,
                  ),
                   DropdownSearch(
                    items: ["Brazil", "France", "Tunisia", "Canada"],
                    dropdownDecoratorProps: DropDownDecoratorProps(),
                    onChanged: print,
                    selectedItem: "Tunisia",
                    validator: (String? item) {
                      if (item == null)
                        return "Required field";
                      else if (item == "Brazil")
                        return "Invalid item";
                      else
                        return null;
                    },
                  ),
                  
                  const SizedBox(
                    height: 10,
                  ),

                  Text("Apartment number"),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      filled: true,
                      hoverColor: appTheme.gray300,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an apartment number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      country = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Text("Name"),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      filled: true,
                      hoverColor: appTheme.gray300,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      country = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  
                  CheckboxListTile(
                    title: Text('Default Address'),
                    value: isDefaultAddress,
                    onChanged: (value) {
                      setState(() {
                        isDefaultAddress = value!;
                      });
                    },
                  ),
                  // Các trường khác tương tự
                  SizedBox(height: 16),
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
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();

                // Thực hiện thêm địa chỉ vào cơ sở dữ liệu hoặc xử lý tương ứng
                print('Address added successfully');
              }
            },
            child: Text(
              'Add Address',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget

  /// Section Widget
// Widget _buildAddAddressButton(BuildContext context) {
//     return CustomElevatedButton(
//       height: 40,
//       width: 370,
//         text: "Add Address",
//         buttonTextStyle: TextStyle(fontSize: 18),
//         margin: EdgeInsets.only(left: 16.h, right: 16.h, bottom: 25.v));

//   }
}

class _formKey {}
