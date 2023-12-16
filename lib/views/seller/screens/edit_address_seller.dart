// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dpl_ecommerce/data_sources/third_party_source/address_repository.dart';
import 'package:dpl_ecommerce/helpers/toast_helper.dart';
import 'package:dpl_ecommerce/models/city.dart';
import 'package:dpl_ecommerce/models/district.dart';
import 'package:dpl_ecommerce/models/ward.dart';
import 'package:dpl_ecommerce/repositories/user_repo.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/customs/custom_elevate_button.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_form_field.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';

class EditAddressSeller extends StatefulWidget {
  AddressInfor addressInfor;
  EditAddressSeller({
    Key? key,
    required this.addressInfor,
  }) : super(key: key);
  @override
  _EditAddressSellerState createState() => _EditAddressSellerState();
}

class _EditAddressSellerState extends State<EditAddressSeller> {
  UserRepo userRepo = UserRepo();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _countryController = TextEditingController();

  TextEditingController _cityController = TextEditingController();

  TextEditingController _districtController = TextEditingController();

  TextEditingController _wardController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  TextEditingController _homeNumberController = TextEditingController();

  City? _selected_city;

  District? _selected_district;

  Ward? _selected_ward;
  bool isDefaultAddress = false;
  FocusNode cityFocusNode = FocusNode();

  FocusNode districtFocusNode = FocusNode();

  FocusNode wardFocusNode = FocusNode();

  FocusNode nameFocusNode = FocusNode();

  FocusNode countryFocusNode = FocusNode();
  FocusNode homeNumberFocusNode = FocusNode();
  onSelectCityDuringAdd(city) {
    if (_selected_city != null && city.id == _selected_city!.id) {
      setState(() {
        _cityController.text = city.name;
      });
      print("${_selected_city!.id}");
      print("object");
      print("${_selected_city!.name}");

      return;
    }
    setState(() {
      _selected_city = city;

      _cityController.text = city.name;
      _selected_district = null;
      _selected_ward = null;
      _districtController.text = "";
      _wardController.text = "";
    });
  }

  onSelectDistrictDuringAdd(district) {
    if (_selected_city != null &&
        _selected_district != null &&
        district.id == _selected_district!.id) {
      setState(() {
        _districtController.text = district.name;
      });
      print("${_selected_city!.id}");
      print("object");
      print("${_selected_city!.name}");

      return;
    }
    _selected_district = district;
    setState(() {
      _districtController.text = district.name;
      _selected_ward = null;
      _wardController.text = "";
    });
  }

  onSelectWardDuringAdd(ward) {
    if (_selected_city != null &&
        _selected_district != null &&
        _selected_ward != null &&
        ward.id == _selected_ward!.id) {
      setState(() {
        _wardController.text = ward.name;
      });
      print("${_selected_ward!.id}");
      print("object");
      print("${_selected_ward!.name}");

      return;
    }
    _selected_ward = ward;
    setState(() {
      _wardController.text = ward.name;
    });
  }

  onPressReg(UserModel user) async {
    String name = _nameController.text.trim();
    String country = _countryController.text.trim();
    String homeNumber = _homeNumberController.text.trim();
    // String address = addressController.text.trim();
    AddressInfor addressInfor = AddressInfor(
        id: widget.addressInfor.id,
        city: _selected_city,
        district: _selected_district,
        country: country,
        isDefaultAddress: isDefaultAddress,
        name: name,
        number: homeNumber,
        ward: _selected_ward);
    await userRepo.updateAddress(addressInfor, user);
  }

  void onPressRegFail() {
    ToastHelper.showDialog("Add full infor",
        gravity: ToastGravity.BOTTOM, duration: Toast.LENGTH_LONG);
    return;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.clear();
    _countryController.clear();
    _cityController.clear();
    _districtController.clear();
    _wardController.clear();
    _homeNumberController.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() {
    _selected_city = widget.addressInfor.city;
    _selected_district = widget.addressInfor.district;
    _selected_ward = widget.addressInfor.ward;
    isDefaultAddress = widget.addressInfor.isDefaultAddress;
    _cityController.text = widget.addressInfor.city!.name!;
    _districtController.text = widget.addressInfor.district!.name!;
    _wardController.text = widget.addressInfor.ward!.name!;
    _countryController.text = widget.addressInfor.country ?? "";
    _homeNumberController.text = widget.addressInfor.number ?? "";
    _nameController.text = widget.addressInfor.name!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    userProvider.initialize();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Address",
          textAlign: TextAlign.center,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          if (cityFocusNode.hasFocus) {
            setState(() {
              cityFocusNode.unfocus();
            });
          }
          if (districtFocusNode.hasFocus) {
            setState(() {
              districtFocusNode.unfocus();
            });
          }
          if (wardFocusNode.hasFocus) {
            setState(() {
              wardFocusNode.unfocus();
            });
          }
          if (countryFocusNode.hasFocus) {
            setState(() {
              countryFocusNode.unfocus();
            });
          }
          if (homeNumberFocusNode.hasFocus) {
            setState(() {
              homeNumberFocusNode.unfocus();
            });
          }
          if (nameFocusNode.hasFocus) {
            setState(() {
              nameFocusNode.unfocus();
            });
          }
        },
        child: SingleChildScrollView(
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
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                      child: Text("Country")),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                    child: TextFormField(
                      controller: _countryController,
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
                      onSaved: (value) {},
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                      child: Text("City")),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: MyTheme.textfield_grey),
                      child: TypeAheadField<City>(
                        hideKeyboard: true,
                        onSuggestionsBoxToggle: (p0) {
                          print("P0 is: $p0");
                        },
                        suggestionsCallback: (name) async {
                          print("Check again");
                          if (cityFocusNode.hasFocus &&
                              _cityController.text.isNotEmpty) {
                            var cityResponse = await AddressRepository()
                                .getCityList(); // blank response
                            return cityResponse;
                          }
                          if (_selected_city == null) {
                            var cityResponse = await AddressRepository()
                                .getCityList(); // blank response
                            return cityResponse;
                          }
                          var cityResponse = await AddressRepository()
                              .getCityByCode(_selected_city!.id!);
                          return [cityResponse!];
                        },
                        loadingBuilder: (context) {
                          return SizedBox(
                            height: 50,
                            child: Center(
                                child: Text(
                                    // AppLocalizations.of(context)!
                                    //     .
                                    "loading_cities_ucf",
                                    style:
                                        TextStyle(color: MyTheme.medium_grey))),
                          );
                        },
                        itemBuilder: (context, dynamic city) {
                          //print(suggestion.toString());
                          return ListTile(
                            dense: true,
                            title: Text(
                              city.name,
                              style: const TextStyle(color: MyTheme.font_grey),
                            ),
                          );
                        },
                        noItemsFoundBuilder: (context) {
                          return SizedBox(
                            height: 50,
                            child: Center(
                                child: Text(
                                    // AppLocalizations.of(context)!.
                                    " no_city_available",
                                    style:
                                        TextStyle(color: MyTheme.medium_grey))),
                          );
                        },
                        onSuggestionSelected: (City city) {
                          print("Check again");
                          onSelectCityDuringAdd(
                            city,
                          );
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                          focusNode: cityFocusNode,

                          onTap: () {
                            setState(() {
                              cityFocusNode.requestFocus();
                            });
                          },
                          onEditingComplete: () {
                            setState(() {
                              cityFocusNode.unfocus();
                            });
                          },
                          //autofocus: true,
                          controller: _cityController,
                          style: const TextStyle(fontSize: 12),
                          onSubmitted: (txt) {
                            // keep blank
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.h, horizontal: 7.w),
                              hintText: "city",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: const Icon(Icons.arrow_drop_down)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                      child: Text("District")),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyTheme.textfield_grey),
                      child: TypeAheadField<District?>(
                        hideKeyboard: true,
                        suggestionsCallback: (name) async {
                          if (_selected_city == null) {
                            return [];
                          }
                          if (districtFocusNode.hasFocus &&
                              _districtController.text.isNotEmpty) {
                            var districtResponse = await AddressRepository()
                                .getDistrictListByCityCode(
                                    _selected_city!.id!); // blank response
                            return districtResponse;
                          }
                          if (_selected_district == null) {
                            var districtResponse = await AddressRepository()
                                .getDistrictListByCityCode(
                                    _selected_city!.id!); // blank response
                            return districtResponse;
                          }
                          var districtResponse = await AddressRepository()
                              .getDistrictByCode(_selected_district!.id!);
                          return [districtResponse];
                        },
                        loadingBuilder: (context) {
                          return SizedBox(
                            height: 50,
                            child: Center(
                                child: Text(
                                    // AppLocalizations.of(context)!
                                    //     .
                                    "loading_districts_ucf",
                                    style:
                                        TextStyle(color: MyTheme.medium_grey))),
                          );
                        },
                        itemBuilder: (context, dynamic city) {
                          //print(suggestion.toString());
                          return ListTile(
                            dense: true,
                            title: Text(
                              city.name,
                              style: TextStyle(color: MyTheme.font_grey),
                            ),
                          );
                        },
                        noItemsFoundBuilder: (context) {
                          return SizedBox(
                            height: 50,
                            child: Center(
                                child: Text(
                                    // AppLocalizations.of(context)!
                                    //     .
                                    "no_district_available",
                                    style:
                                        TextStyle(color: MyTheme.medium_grey))),
                          );
                        },
                        onSuggestionSelected: (District? district) {
                          onSelectDistrictDuringAdd(
                            district,
                          );
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                          focusNode: districtFocusNode,
                          onTap: () {
                            setState(() {
                              districtFocusNode.requestFocus();
                            });
                          },
                          onEditingComplete: () {
                            setState(() {
                              districtFocusNode.unfocus();
                            });
                          },
                          //autofocus: true,
                          controller: _districtController,
                          style: const TextStyle(fontSize: 12),
                          onSubmitted: (txt) {
                            // keep blank
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.h, horizontal: 7.w),
                              hintText:
                                  // LangText(context: context).getLocal()!.
                                  "district",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: const Icon(Icons.arrow_drop_down)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                      child: Text("Ward")),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyTheme.textfield_grey),
                      child: Center(
                        child: TypeAheadField<Ward?>(
                          hideKeyboard: true,
                          suggestionsCallback: (name) async {
                            if (_selected_district == null) {
                              return [];
                            }
                            if (wardFocusNode.hasFocus &&
                                _wardController.text.isNotEmpty) {
                              var wardResponse = await AddressRepository()
                                  .getWardListByDistrictCode(_selected_district!
                                      .id!); // blank response
                              return wardResponse;
                            }
                            if (_selected_ward == null) {
                              var wardResponse = await AddressRepository()
                                  .getWardListByDistrictCode(_selected_district!
                                      .id!); // blank response
                              return wardResponse;
                            }
                            var wardResponse = await AddressRepository()
                                .getWardByCode(_selected_ward!.id!);
                            return [wardResponse!];
                          },
                          loadingBuilder: (context) {
                            return Container(
                              height: 50,
                              child: Center(
                                  child: Text(
                                      // AppLocalizations.of(context)!
                                      //     .
                                      "loading_wards_ucf",
                                      style: TextStyle(
                                          color: MyTheme.medium_grey))),
                            );
                          },
                          itemBuilder: (context, dynamic city) {
                            //print(suggestion.toString());
                            return ListTile(
                              dense: true,
                              title: Text(
                                city.name,
                                style:
                                    const TextStyle(color: MyTheme.font_grey),
                              ),
                            );
                          },
                          noItemsFoundBuilder: (context) {
                            return Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: Center(
                                  child: Text(
                                      // AppLocalizations.of(context)!
                                      //     .
                                      "no_ward_available",
                                      style: TextStyle(
                                          color: MyTheme.medium_grey))),
                            );
                          },
                          onSuggestionSelected: (Ward? ward) {
                            onSelectWardDuringAdd(
                              ward,
                            );
                          },
                          textFieldConfiguration: TextFieldConfiguration(
                            focusNode: wardFocusNode,
                            onTap: () {
                              setState(() {
                                wardFocusNode.requestFocus();
                              });
                            },
                            onEditingComplete: () {
                              setState(() {
                                wardFocusNode.unfocus();
                              });
                            },

                            //autofocus: true,
                            controller: _wardController,
                            style: const TextStyle(fontSize: 12),
                            onSubmitted: (txt) {
                              // keep blank
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 7.w),
                                hintText:
                                    // LangText(context: context).getLocal()!.
                                    "ward",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                suffixIcon: const Icon(Icons.arrow_drop_down)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                      child: Text("Apartment number")),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                    child: TextFormField(
                      controller: _homeNumberController,
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
                      onSaved: (value) {},
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                    child: Text("Name"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                    child: TextFormField(
                      controller: _nameController,
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
                      onSaved: (value) {},
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
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
            if (_formKey.currentState?.validate() ?? false) {
              _formKey.currentState?.save();

              print("default: $isDefaultAddress");
              // await userProvider.addNewAddress(AddressInfor(
              //     city: cityController.text,
              //     country: countryController.text,
              //     district: districtController.text,
              //     isDefaultAddress: isDefaultAddress,
              //     latitude: double.parse(latitudeController.text),
              //     longitude: double.parse(longitudeController.text),
              //     name: nameController.text));
              if (_selected_city != null &&
                  _selected_district != null &&
                  _selected_ward != null &&
                  _nameController.text.isNotEmpty &&
                  _countryController.text.isNotEmpty &&
                  _homeNumberController.text.isNotEmpty) {
                await onPressReg(userProvider.currentUser!);
                Future.delayed(const Duration(seconds: 1)).then((value) {
                  Navigator.pop(context);
                });
                print('Address added successfully');
              } else {
                onPressRegFail();
              }
            } else {
              onPressRegFail();
            }
          },
          child: Text(
            'Update',
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
