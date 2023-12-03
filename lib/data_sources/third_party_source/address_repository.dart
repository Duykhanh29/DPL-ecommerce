import 'dart:convert';

import 'package:dpl_ecommerce/models/city.dart';
import 'package:dpl_ecommerce/models/district.dart';
import 'package:dpl_ecommerce/models/ward.dart';
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
}
