import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({super.key});

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
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
    // final userProvider = Provider.of<UserViewModel>(context, listen: false);
    return Scaffold(
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
              TextField(
                controller: countryController,
                decoration: InputDecoration(labelText: 'Country'),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter a country';
                //   }
                //   return null;
                // },
                // onSaved: (value) {
                //   country = value;
                // },
              ),
              TextFormField(
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
                controller: districtController,
              ),

              TextFormField(
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
                controller: cityController,
              ),
              TextFormField(
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
                controller: latitudeController,
              ),
              TextFormField(
                onTap: () {
                  print("On tap");
                },
                keyboardType: TextInputType.number,
                controller: longitudeController,
                decoration: InputDecoration(labelText: 'Longitude'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a longitude';
                  }
                  return null;
                },
                // onSaved: (value) {
                //   longitude = double.tryParse(value!);
                // },
              ),

              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                controller: nameController,
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
              // _formKey.currentState?.save();
              // print("City: $city");
              // print("Country: $country");
              // print("District: $state");
              // print("Lat: $latitude");
              // print("Long: $longitude");
              // print("Name: $name");
              print("default: $isDefaultAddress");
              // await userProvider.addNewAddress(AddressInfor(
              //     city: cityController.text,
              //     country: countryController.text,
              //     district: districtController.text,
              //     isDefaultAddress: isDefaultAddress,
              //     latitude: double.parse(latitudeController.text),
              //     longitude: double.parse(longitudeController.text),
              //     name: nameController.text));
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
}
