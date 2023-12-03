import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/customs/custom_elevate_button.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_form_field.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';

import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddressForm extends StatefulWidget {
  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final districtController = TextEditingController();
  final longitudeController = TextEditingController();
  final latitudeController = TextEditingController();
  bool isDefaultAddress = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Address",
          textAlign: TextAlign.center,
        ),
        leading:
            CustomArrayBackWidget(function: () => userProvider.resetAddress()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Consumer<UserViewModel>(
                builder: (context, value, child) => TextFormField(
                  controller: value.countryController,
                  decoration: InputDecoration(labelText: 'Country'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a country';
                    }
                    return null;
                  },
                  // onSaved: (value) {
                  //   country = value;
                  // },
                ),
              ),
              Consumer<UserViewModel>(
                builder: (context, value, child) => TextFormField(
                  decoration: InputDecoration(labelText: 'District'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a district';
                    }
                    return null;
                  },
                  // onSaved: (value) {
                  //   state = value;
                  // },
                  controller: value.districtController,
                ),
              ),

              Consumer<UserViewModel>(
                builder: (context, value, child) => TextFormField(
                  decoration: InputDecoration(labelText: 'City'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a city';
                    }
                    return null;
                  },
                  // onSaved: (value) {
                  //   city = value;
                  // },
                  controller: value.cityController,
                ),
              ),
              Consumer<UserViewModel>(
                builder: (context, value, child) => TextFormField(
                  keyboardType: TextInputType.number,

                  decoration: InputDecoration(labelText: 'Latitude'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a latitude';
                    }
                    return null;
                  },
                  // onSaved: (value) {
                  //   latitude = double.tryParse(value!);
                  // },
                  controller: value.latitudeController,
                ),
              ),
              Consumer<UserViewModel>(
                builder: (context, value, child) => TextFormField(
                  keyboardType: TextInputType.number,

                  decoration: InputDecoration(labelText: 'Longitude'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Longitude';
                    }
                    return null;
                  },
                  // onSaved: (value) {
                  //   latitude = double.tryParse(value!);
                  // },
                  controller: value.longitudeController,
                ),
              ),

              Consumer<UserViewModel>(
                builder: (context, value, child) => TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  controller: value.nameController,
                ),
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
      bottomNavigationBar: Container(
        height: 40,
        width: 370,
        margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 25.h),
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState?.validate() ?? false) {
              _formKey.currentState?.save();
              // print("City: $city");
              // print("Country: $country");
              // print("District: $state");
              // print("Lat: $latitude");
              // print("Long: $longitude");
              // print("Name: $name");
              print("default: $isDefaultAddress");
              await userProvider.addNewAddress(AddressInfor(
                  city: cityController.text,
                  country: countryController.text,
                  district: districtController.text,
                  isDefaultAddress: isDefaultAddress,
                  latitude: double.parse(latitudeController.text),
                  longitude: double.parse(longitudeController.text),
                  name: nameController.text));
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
