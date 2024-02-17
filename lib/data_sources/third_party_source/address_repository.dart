import 'dart:convert';

import 'package:dpl_ecommerce/models/address_response/city_response.dart'
    as newCity;
import 'package:dpl_ecommerce/models/address_response/district_response.dart'
    as newDistrict;
import 'package:dpl_ecommerce/models/address_response/ward_response.dart'
    as newWard;
import 'package:dpl_ecommerce/models/city.dart';
import 'package:dpl_ecommerce/models/district.dart';
import 'package:dpl_ecommerce/models/ward.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class AddressRepository {
  final baseURL = 'https://provinces.open-api.vn';
  Future<List<City>> getCityList() async {
    List<City> result = [];
    String url = '$baseURL/api/p/';
    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "App-Language": "vi",
    });
    if (response.statusCode == 200) {
      final dataBody = utf8.decode(response.bodyBytes);
      final data = json.decode(dataBody) as List;
      result = data.map((e) => City.fromJson(e)).toList();
    }
    print("$result");
    return result;
  }

  Future<City?> getCityByCode(int code) async {
    City? result;
    String url = '$baseURL/api/p/$code';
    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "App-Language": "vi",
    });
    if (response.statusCode == 200) {
      final dataBody = utf8.decode(response.bodyBytes);
      // final data = dataBody as Map<String, dynamic>;
      final data = jsonDecode(dataBody) as Map<String, dynamic>;
      result = City(id: data['code'], name: data['name']);
    }
    return result!;
  }

  Future<List<District>> getDistrictListByCityCode(int code) async {
    List<District> result = [];
    String url = '$baseURL/api/p/$code/?depth=2';
    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "App-Language": "vi",
    });
    if (response.statusCode == 200) {
      final dataBody = utf8.decode(response.bodyBytes);
      final data = jsonDecode(dataBody) as Map<String, dynamic>;
      final districts = data['districts'] as List;

      result = districts.map((e) => District.fromJson(e)).toList();
    }
    return result;
  }

  Future<District?> getDistrictByCode(int code) async {
    District? result;
    String url = '$baseURL/api/d/$code';
    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "App-Language": "vi",
    });
    if (response.statusCode == 200) {
      final dataBody = utf8.decode(response.bodyBytes);
      final data = jsonDecode(dataBody) as Map<String, dynamic>;
      result = District(id: data['code'], name: data['name']);
    }
    return result!;
  }

  Future<List<Ward>> getWardListByDistrictCode(int code) async {
    List<Ward> result = [];
    String url = '$baseURL/api/d/$code/?depth=2';
    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "App-Language": "vi",
    });
    if (response.statusCode == 200) {
      final dataBody = utf8.decode(response.bodyBytes);
      final data = jsonDecode(dataBody) as Map<String, dynamic>;
      final wards = data['wards'] as List;

      result = wards.map((e) => Ward.fromJson(e)).toList();
    }
    return result;
  }

  Future<Ward?> getWardByCode(int code) async {
    Ward? result;
    String url = '$baseURL/api/w/$code';
    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "App-Language": "vi",
    });
    if (response.statusCode == 200) {
      final dataBody = utf8.decode(response.bodyBytes);
      final data = jsonDecode(dataBody) as Map<String, dynamic>;
      result = Ward(id: data['code'], name: data['name']);
    }
    return result!;
  }

  // new API
  // new address API

  Future<List<dynamic>> loadData() async {
    String response = await rootBundle.loadString('assets/json/addresses.json');
    print("response: $response");
    return await json.decode(response);
  }

  Future<List<newCity.City>> getAllCity() async {
    final data = await loadData();
    return data.map((e) => newCity.City.fromJson(e)).toList();
  }

  Future<newCity.City> getProvinceByID(String id) async {
    final data = await getAllCity();
    return data.firstWhere((element) => element.id == id);
  }

  Future<List<newDistrict.District>> getAllDitrictByProvinceID(
      String provinceID) async {
    final data = await getAllCity();
    final provinceData = data.firstWhere((element) => element.id == provinceID);
    return provinceData.districts;
  }

  Future<newDistrict.District> getDistrictByID(
      {required String provinceID, required String districtID}) async {
    final data = await getAllDitrictByProvinceID(provinceID);
    return data.firstWhere((element) => element.id == districtID);
  }

  Future<List<newWard.Ward>> getAllWardByDistrictD(
      {required String provinceID, required String districtID}) async {
    final data = await getAllDitrictByProvinceID(provinceID);
    final districtData = data.firstWhere((element) => element.id == districtID);
    return districtData.wards;
  }

  Future<newWard.Ward> getWardtByID(
      {required String provinceID,
      required String districtID,
      required String wardID}) async {
    final data = await getAllWardByDistrictD(
        provinceID: provinceID, districtID: districtID);
    return data.firstWhere((element) => element.id == wardID);
  }

  // convert city
  Future<City> convertProvinceToCity(newCity.City province) async {
    City city = City(id: province.id, name: province.name);
    return city;
  }

  Future<District> convertDistrict(newDistrict.District district1) async {
    District district = District(id: district1.id, name: district1.name);
    return district;
  }

  Future<Ward> convertWard(newWard.Ward ward1) async {
    Ward ward = Ward(id: ward1.id, name: ward1.name);
    return ward;
  }
}
