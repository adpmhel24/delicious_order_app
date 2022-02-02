import 'dart:io';

import 'package:dio/dio.dart';

import '/data/api_services/ph_location_api.dart';
import '/data/models/models.dart';

class PhLocationRepo {
  late List<ProvinceModel> _provinces = [];
  late List<CityMunicipalityModel> _citiesMunicipalities = [];
  late List<BrgyModel> _brgys = [];

  final PhLocationApiService _phApiService = PhLocationApiService();

  List<ProvinceModel> get provinces =>
      [..._provinces..sort((a, b) => a.name!.compareTo(b.name!))];
  List<CityMunicipalityModel> get cities =>
      [..._citiesMunicipalities]..sort((a, b) => a.name.compareTo(b.name));
  List<BrgyModel> get brgys =>
      [..._brgys..sort((a, b) => a.name.compareTo(b.name))];

  late Map<String, dynamic> selectedProvinceCode = {};
  late String selectedCityMunicipalityCode = '';

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
    } on HttpException catch (e) {
      throw HttpException(e.message);
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

  Future<void> fetchCitiesMunicipalities() async {
    String path;
    if (selectedProvinceCode.isNotEmpty) {
      if (selectedProvinceCode['isDistrict']) {
        path =
            "/districts/${selectedProvinceCode['code']}/cities-municipalities.json";
      } else {
        path =
            "/provinces/${selectedProvinceCode["code"]}/cities-municipalities.json";
      }
    } else {
      path = '/cities-municipalities.json';
    }
    Response response;
    try {
      response = await _phApiService.fetchData(path);

      if (response.statusCode == 200) {
        if (response.data.isNotEmpty) {
          _citiesMunicipalities = List<CityMunicipalityModel>.from(
            response.data.map(
              (jsonCityMunicipality) =>
                  CityMunicipalityModel.fromJson(jsonCityMunicipality),
            ),
          );
        }
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  List<CityMunicipalityModel> searchCityMunicipalityByKeyword(String keyword) {
    if (keyword.isNotEmpty) {
      return _citiesMunicipalities
          .where((e) => e.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    return _citiesMunicipalities;
  }

  Future<void> fetchBrgys() async {
    String path;
    if (selectedCityMunicipalityCode.isNotEmpty) {
      path =
          '/cities-municipalities/$selectedCityMunicipalityCode/barangays.json';
    } else if (selectedProvinceCode.isNotEmpty) {
      path = "/provinces/${selectedProvinceCode["code"]}/barangays.json";
    } else {
      path = '/barangays.json';
    }

    Response response;
    try {
      response = await _phApiService.fetchData(path);
      if (response.statusCode == 200) {
        if (response.data.isNotEmpty) {
          _brgys = List<BrgyModel>.from(
            response.data.map(
              (jsonBrgy) => BrgyModel.fromJson(jsonBrgy),
            ),
          );
        }
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  List<BrgyModel> searchBarangaysByKeyword(String keyword) {
    if (keyword.isNotEmpty) {
      return _brgys
          .where((e) => e.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    return _brgys;
  }

  void clear() {
    selectedProvinceCode.clear();
    selectedCityMunicipalityCode = '';
  }
}
