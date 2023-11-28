import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
//ghghgh
  String? country;
  String? state;
  String? city;
  String? number;
  String? district;
  String? commune;
  bool isDefaultAddress = false;
  String? name;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   backgroundColor: Colors.blue,
        //   title: Text(
        //     "Address",
        //     textAlign: TextAlign.center,
        //   ),
        //   centerTitle: true,

        //   //leading: Icon(Icons.menu),
        // ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                   Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Create an account',
                      style: TextStyle(
                        //color: AppColors.blue700,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Connect with your friends today!',
                      style: TextStyle(
                        //color: AppColors.blue700,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 312.h,
                            height: 80.w,
                    child: TextFormField(
                     decoration: InputDecoration(
                     
                                border: OutlineInputBorder(
                                   borderSide: new BorderSide(
                                   //color: appTheme.gray300,
                                  ),
                                   borderRadius: BorderRadius.circular(10.r),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: new BorderSide(
                                   //color: appTheme.gray300,
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                filled: true,
                                //fillColor: appTheme.gray300,
                                //hoverColor: appTheme.gray300,
                                hintText: 'Enter Your Username',
                                hintStyle: TextStyle(
                                  color: appTheme.black900,
                                  fontSize: 16,
                                ),
                              ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Your Username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        country = value;
                      },
                    ),
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
                    decoration: InputDecoration(labelText: 'District'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a district';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      district = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Commune'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a commune';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      commune = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Apartment number'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a apartment number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      number = value;
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


}

