import 'dart:convert';

import 'package:dio/dio.dart';

import '/data/api_services/ph_location_api.dart';
import '/data/models/models.dart';

class PhLocationRepo {
  late List<ProvinceModel> _provinces = [];
  late List<CityModel> _cities = [];
  late List<MunicipalityModel> _municipalities = [];
  late List<BrgyModel> _brgys = [];

  final PhLocationApiService _phApiService = PhLocationApiService();

  List<ProvinceModel> get provinces =>
      [..._provinces..sort((a, b) => a.name!.compareTo(b.name!))];
  List<CityModel> get cities =>
      [..._cities]..sort((a, b) => a.name.compareTo(b.name));
  List<MunicipalityModel> get municipalities => [..._municipalities];
  List<BrgyModel> get brgys => [..._brgys];

  late Map<String, dynamic> selectedProvinceCode = {};
  late String selectedCityCode = '';
  late String selectedmunicipalityCode = '';

  Future<void> fetchProvinces() async {
    Response provinceResponse;
    Response districtResponse;
    List<ProvinceModel> resultProvinces = [];
    try {
      provinceResponse = await _phApiService.fetchData('/provinces.json');
      districtResponse = await _phApiService.fetchData('/districts.json');
      if (provinceResponse.statusCode == 200) {
        // Add All Provinces
        resultProvinces.addAll(
          List<ProvinceModel>.from(
            provinceResponse.data
                .map((i) => ProvinceModel.fromJson(i))
                .toList(),
          ),
        );

        // Add District to provinces because NCR has no province.
        resultProvinces.addAll(
          List<ProvinceModel>.from(
            districtResponse.data.map((i) {
              i['name'] = "NCR, ${i['name']}";
              i['isDistrict'] = true;
              return ProvinceModel.fromJson(i);
            }).toList(),
          ),
        );

        _provinces = resultProvinces;
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  List<ProvinceModel> searchProvinceByKeyword(String keyword) {
    if (keyword.isNotEmpty) {
      return _provinces
          .where((e) => e.name!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    return _provinces;
  }

  Future<void> fetchCity() async {
    String path;
    if (selectedProvinceCode.isNotEmpty) {
      if (selectedProvinceCode['isDistrict']) {
        path = "/districts/${selectedProvinceCode['code']}/cities.json";
      } else {
        path = "/provinces/${selectedProvinceCode["code"]}/cities.json";
      }
    } else {
      path = '/cities.json';
    }
    Response response;
    try {
      response = await _phApiService.fetchData(path);

      if (response.statusCode == 200) {
        if (response.data.isNotEmpty) {
          _cities = List<CityModel>.from(
            response.data.map(
              (jsonCity) => CityModel.fromJson(jsonCity),
            ),
          );
        }
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  List<CityModel> searchCityByKeyword(String keyword) {
    if (keyword.isNotEmpty) {
      return _cities
          .where((e) => e.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    return _cities;
  }

  Future<void> fetchMunicipality() async {
    String path;

    if (selectedCityCode.isNotEmpty) {
      path = 'city/'
    }
    else if (selectedProvinceCode.isNotEmpty) {
      if (selectedProvinceCode['isDistrict']) {
        path = "/districts/${selectedProvinceCode['code']}/municipalities.json";
      } else {
        path = "/provinces/${selectedProvinceCode["code"]}/municipalities.json";
      }
    } else {
      path = '/municipalities.json';
    }

    Response response;
    try {
      response = await _phApiService.fetchData(path);
      if (response.statusCode == 200) {
        List<dynamic> decodedResult = jsonDecode(response.data);
        if (decodedResult.isNotEmpty) {
          _municipalities = List<MunicipalityModel>.from(
            decodedResult.map(
              (jsonMunicipality) =>
                  MunicipalityModel.fromJson(jsonMunicipality),
            ),
          );
        }
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  List<MunicipalityModel> searchMunicipalityByKeyword(String keyword) {
    if (keyword.isNotEmpty) {
      return _municipalities
          .where((e) => e.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    return _municipalities;
  }

  Future<void> fetchBrgy(String path) async {
    Response response;
    try {
      response = await _phApiService.fetchData(path);
      if (response.statusCode == 200) {
        List<dynamic> decodedResult = jsonDecode(response.data);
        if (decodedResult.isNotEmpty) {
          _brgys = List<BrgyModel>.from(
            decodedResult.map(
              (jsonBrgy) => BrgyModel.fromJson(jsonBrgy),
            ),
          );
        }
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
