import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_elevate_button.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_form_field.dart';

import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dio/dio.dart';

class AddressForm extends StatefulWidget {
  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final _formKey = GlobalKey<FormState>();
//ghghgh
  String? country;
  String? state;
  String? city;
  double? latitude;
  double? longitude;
  bool isDefaultAddress = false;
  String? name;

 
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
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
            body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Country'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a country';
                  }
                  return null;
                },
                onSaved: (value) {
                  country = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'State'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a state';
                  }
                  return null;
                },
                onSaved: (value) {
                  state = value;
                },
              ),
              
              TextFormField(
                decoration: InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a city';
                  }
                  return null;
                },
                onSaved: (value) {
                  city = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Latitude'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a latitude';
                  }
                  return null;
                },
                onSaved: (value) {
                  latitude = double.tryParse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Longitude'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a longitude';
                  }
                  return null;
                },
                onSaved: (value) {
                  longitude = double.tryParse(value!);
                },
              ),
              
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value;
                },
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
              SizedBox(height: 15),
              
            ],
          ),
        ),
      ),
            bottomNavigationBar: Container(
              height: 40,
              width: 370,
              margin: EdgeInsets.only(left: 16.h, right: 16.h, bottom: 25.v),

              child:ElevatedButton(
                
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();

                    // Thực hiện thêm địa chỉ vào cơ sở dữ liệu hoặc xử lý tương ứng
                    print('Address added successfully');
                  }
                },
                child: Text('Add Address',style: TextStyle(fontSize: 18),),
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

class _formKey {
}
