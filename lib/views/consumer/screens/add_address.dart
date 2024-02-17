import 'package:dpl_ecommerce/const/app_bar.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/customs/custom_text_form_field.dart';
import 'package:dpl_ecommerce/data_sources/third_party_source/address_repository.dart';
import 'package:dpl_ecommerce/helpers/toast_helper.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/city.dart';
import 'package:dpl_ecommerce/models/district.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/models/ward.dart';
import 'package:dpl_ecommerce/repositories/user_repo.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/address_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:dpl_ecommerce/models/address_response/city_response.dart'
    as newCity;
import 'package:dpl_ecommerce/models/address_response/district_response.dart'
    as newDistrict;
import 'package:dpl_ecommerce/models/address_response/ward_response.dart'
    as newWard;

class AddAddress extends StatefulWidget {
  AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _countryController = TextEditingController();

  final TextEditingController _cityController = TextEditingController();

  final TextEditingController _districtController = TextEditingController();

  final TextEditingController _wardController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _homeNumberController = TextEditingController();
  City? _selected_city;

  District? _selected_district;

  Ward? _selected_ward;

  FocusNode cityFocusNode = FocusNode();

  FocusNode districtFocusNode = FocusNode();

  FocusNode wardFocusNode = FocusNode();

  FocusNode nameFocusNode = FocusNode();

  FocusNode countryFocusNode = FocusNode();
  FocusNode homeNumberFocusNode = FocusNode();

  // new
  newCity.City? selectedCity;
  newDistrict.District? selectedDistrict;
  newWard.Ward? selectedWard;
  UserRepo userRepo = UserRepo();
  bool isDefaultAddress = false;
  onSelectCityDuringAdd(city) {
    if (selectedCity != null && city.id == selectedCity!.id) {
      setState(() {
        _cityController.text = city.name;
      });
      print("${selectedCity!.id}");
      print("object");
      print("${selectedCity!.name}");

      return;
    }
    setState(() {
      selectedCity = city;

      _cityController.text = city.name;
      selectedDistrict = null;
      selectedWard = null;
      _districtController.text = "";
      _wardController.text = "";
    });
  }

  onSelectDistrictDuringAdd(district) {
    if (selectedCity != null &&
        selectedDistrict != null &&
        district.id == selectedDistrict!.id) {
      setState(() {
        _districtController.text = district.name;
      });
      // print("${_selected_city!.id}");
      // print("object");
      // print("${_selected_city!.name}");

      return;
    }
    selectedDistrict = district;
    setState(() {
      _districtController.text = district.name;
      selectedWard = null;
      _wardController.text = "";
    });
  }

  onSelectWardDuringAdd(ward) {
    if (selectedCity != null &&
        selectedDistrict != null &&
        selectedWard != null &&
        ward.id == _selected_ward!.id) {
      setState(() {
        _wardController.text = ward.name;
      });
      print("${_selected_ward!.id}");
      print("object");
      print("${_selected_ward!.name}");

      return;
    }
    selectedWard = ward;
    setState(() {
      _wardController.text = ward.name;
    });
  }

  onPressReg(UserModel user, AddressViewModel addressViewModel) async {
    String name = _nameController.text.trim();
    String country = _countryController.text.trim();
    String homeNumber = _homeNumberController.text.trim();
    // String address = addressController.text.trim();
    // loading();
    City city = City(id: selectedCity!.id, name: selectedCity!.name);
    District district =
        District(id: selectedDistrict!.id, name: selectedDistrict!.name);
    Ward? ward;
    if (selectedWard != null) {
      ward = Ward(id: selectedWard!.id, name: selectedWard!.name);
    }
    AddressInfor addressInfor = AddressInfor(
        city: city,
        district: district,
        country: country,
        isDefaultAddress: isDefaultAddress,
        name: name,
        number: homeNumber,
        ward: ward);
    addressViewModel.addAdd(addressInfor);
    await userRepo.addNewAddress(addressInfor, user);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.addListener(_onNameChanged);
    _countryController.addListener(_onCountryChange);
    _cityController.addListener(_onCityChange);
    _districtController.addListener(_onDistrictChange);
    _wardController.addListener(_onWardChange);
    _homeNumberController.addListener(() {
      setState(() {});
    });
  }

  void _onNameChanged() {
    setState(() {});
  }

  void _onCountryChange() {
    setState(() {});
  }

  void _onConfirmPassChange() {
    setState(() {});
  }

  void _onShopNameChange() {
    setState(() {});
  }

  void _onPhoneChange() {
    setState(() {});
  }

  void _onEmailChange() {
    setState(() {});
  }

  void _onCityChange() {
    setState(() {});
  }

  void _onDistrictChange() {
    setState(() {});
  }

  void _onWardChange() {
    setState(() {});
  }

  void onPressRegFail() {
    ToastHelper.showDialog(
        LangText(context: context).getLocal()!.add_full_infor,
        gravity: ToastGravity.BOTTOM,
        duration: Toast.LENGTH_LONG);
    return;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    final addressProvider = Provider.of<AddressViewModel>(context);
    final user = userProvider.currentUser;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
              centerTitle: true,
              context: context,
              title: LangText(context: context).getLocal()!.add_new_address)
          .show(),
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
            padding: EdgeInsets.all(15.h),
            child: Form(
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  // CustomTextFormField(
                  //   controller: countryController,
                  //   hintText: "Nani",
                  // ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                    child: TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(255),
                      ],
                      focusNode: countryFocusNode,
                      onTap: () {
                        setState(() {
                          countryFocusNode.requestFocus();
                        });
                      },
                      onEditingComplete: () {
                        print("Untap");
                        setState(() {
                          countryFocusNode.unfocus();
                        });
                      },
                      onChanged: (value) {
                        print("On change: $value");
                      },
                      controller: _countryController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 5.h, horizontal: 7.w),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r)),
                          hintText: _countryController.text.isEmpty &&
                                  !countryFocusNode.hasFocus
                              ? LangText(context: context)
                                  .getLocal()!
                                  .country_ucf
                              : null),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: MyTheme.textfield_grey),
                      child: TypeAheadField<newCity.City>(
                        hideKeyboard: true,
                        onSuggestionsBoxToggle: (p0) {
                          print("P0 is: $p0");
                        },
                        suggestionsCallback: (name) async {
                          print("Check again");
                          if (cityFocusNode.hasFocus &&
                              _cityController.text.isNotEmpty) {
                            var cityResponse = await AddressRepository()
                                .getAllCity(); // blank response
                            return cityResponse;
                          }
                          if (selectedCity == null) {
                            var cityResponse = await AddressRepository()
                                .getAllCity(); // blank response
                            return cityResponse;
                          }
                          var cityResponse = await AddressRepository()
                              .getProvinceByID(selectedCity!.id);
                          return [cityResponse];
                        },
                        loadingBuilder: (context) {
                          return SizedBox(
                            height: 50.h,
                            child: Center(
                                child: Text(
                                    AppLocalizations.of(context)!
                                        .loading_cities_ucf,
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
                            height: 50.h,
                            child: Center(
                                child: Text(
                                    AppLocalizations.of(context)!
                                        .no_city_available,
                                    style:
                                        TextStyle(color: MyTheme.medium_grey))),
                          );
                        },
                        onSuggestionSelected: (newCity.City city) {
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
                              hintText: AppLocalizations.of(context)!.city_ucf,
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
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyTheme.textfield_grey),
                      child: TypeAheadField<newDistrict.District>(
                        hideKeyboard: true,
                        suggestionsCallback: (name) async {
                          if (selectedCity == null) {
                            return [];
                          }
                          if (districtFocusNode.hasFocus &&
                              _districtController.text.isNotEmpty) {
                            var districtResponse = await AddressRepository()
                                .getAllDitrictByProvinceID(
                                    selectedCity!.id); // blank response
                            return districtResponse;
                          }
                          if (selectedDistrict == null) {
                            var districtResponse = await AddressRepository()
                                .getAllDitrictByProvinceID(
                                    selectedCity!.id); // blank response
                            return districtResponse;
                          }
                          var districtResponse = await AddressRepository()
                              .getDistrictByID(
                                  districtID: selectedDistrict!.id,
                                  provinceID: selectedCity!.id);
                          return [districtResponse];
                        },
                        loadingBuilder: (context) {
                          return SizedBox(
                            height: 50.h,
                            child: Center(
                                child: Text(
                                    AppLocalizations.of(context)!
                                        .loading_districts_ucf,
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
                            height: 50.h,
                            child: Center(
                                child: Text(
                                    AppLocalizations.of(context)!
                                        .no_district_available,
                                    style:
                                        TextStyle(color: MyTheme.medium_grey))),
                          );
                        },
                        onSuggestionSelected: (newDistrict.District? district) {
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
                              hintText: LangText(context: context)
                                  .getLocal()!
                                  .district_ucf,
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
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 50.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyTheme.textfield_grey),
                      child: Center(
                        child: TypeAheadField<newWard.Ward?>(
                          hideKeyboard: true,
                          suggestionsCallback: (name) async {
                            if (selectedDistrict == null) {
                              return [];
                            }
                            if (wardFocusNode.hasFocus &&
                                _wardController.text.isNotEmpty) {
                              var wardResponse = await AddressRepository()
                                  .getAllWardByDistrictD(
                                      provinceID: selectedCity!.id,
                                      districtID: selectedDistrict!
                                          .id); // blank response
                              return wardResponse;
                            }
                            if (selectedWard == null) {
                              var wardResponse = await AddressRepository()
                                  .getAllWardByDistrictD(
                                      provinceID: selectedCity!.id,
                                      districtID: selectedDistrict!.id);
                              return wardResponse;
                            }
                            var wardResponse = await AddressRepository()
                                .getWardtByID(
                                    provinceID: selectedCity!.id,
                                    districtID: selectedDistrict!.id,
                                    wardID: selectedWard!.id!);
                            return [wardResponse];
                          },
                          loadingBuilder: (context) {
                            return Container(
                              height: 50.h,
                              child: Center(
                                  child: Text(
                                      AppLocalizations.of(context)!
                                          .loading_wards_ucf,
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
                              height: 50.h,
                              child: Center(
                                  child: Text(
                                      AppLocalizations.of(context)!
                                          .no_ward_available,
                                      style: TextStyle(
                                          color: MyTheme.medium_grey))),
                            );
                          },
                          onSuggestionSelected: (newWard.Ward? ward) {
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
                                hintText: LangText(context: context)
                                    .getLocal()!
                                    .ward_ucf,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                suffixIcon: const Icon(Icons.arrow_drop_down)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: TextField(
                      focusNode: homeNumberFocusNode,
                      onTap: () {
                        setState(() {
                          homeNumberFocusNode.requestFocus();
                        });
                      },
                      onEditingComplete: () {
                        print("Untap");
                        setState(() {
                          homeNumberFocusNode.unfocus();
                        });
                      },
                      controller: _homeNumberController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(
                            255), // Giới hạn độ dài tối đa
                      ],
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 5.h, horizontal: 7.w),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r)),
                          hintText: _homeNumberController.text.isEmpty &&
                                  !homeNumberFocusNode.hasFocus
                              ? LangText(context: context)
                                  .getLocal()!
                                  .home_number
                              : null),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: TextField(
                      focusNode: nameFocusNode,
                      onTap: () {
                        setState(() {
                          nameFocusNode.requestFocus();
                        });
                      },
                      onEditingComplete: () {
                        print("Untap");
                        setState(() {
                          nameFocusNode.unfocus();
                        });
                      },
                      controller: _nameController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(
                            255), // Giới hạn độ dài tối đa
                      ],
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 5.h, horizontal: 7.w),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r)),
                          hintText: _nameController.text.isEmpty &&
                                  !nameFocusNode.hasFocus
                              ? LangText(context: context).getLocal()!.my_home
                              : null),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CheckboxListTile(
                    title: Text(
                        LangText(context: context).getLocal()!.default_address),
                    value: isDefaultAddress,
                    onChanged: (value) {
                      setState(() {
                        isDefaultAddress = value!;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  // Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.all(10.h),
        child: ElevatedButton(
          onPressed: () async {
            if (_countryController.text.isEmpty ||
                selectedCity == null ||
                selectedDistrict == null ||
                selectedWard == null ||
                _homeNumberController.text.isEmpty ||
                _nameController.text.isEmpty) {
              onPressRegFail();
            } else {
              await onPressReg(user!, addressProvider);
              Future.delayed(const Duration(seconds: 1)).then((value) {
                Navigator.of(context).pop();
              });
            }
          },
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(5),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
                side: BorderSide(color: MyTheme.accent_color_2, width: 1),
              ),
            ),
          ),
          child: Text(
            LangText(context: context).getLocal()!.add_all_capital,
            style: TextStyle(
                color: MyTheme.accent_color,
                fontWeight: FontWeight.w700,
                fontSize: 18.sp),
          ),
        ),
      ),
    );
  }

  loading() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Row(
            children: [
              const CircularProgressIndicator(),
              SizedBox(
                width: 10.w,
              ),
              Text(AppLocalizations.of(context)!.please_wait_ucf),
            ],
          ));
        });
  }
}
