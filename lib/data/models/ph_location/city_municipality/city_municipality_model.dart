import 'package:json_annotation/json_annotation.dart';

part 'city_municipality_model.g.dart';

@JsonSerializable()
class CityMunicipalityModel {
  String code;
  String name;
  bool? isCapital;
  bool? isCity;
  bool? isMunicipality;

  CityMunicipalityModel({
    required this.code,
    required this.name,
    required this.isCapital,
    required this.isCity,
    required this.isMunicipality,
  });

  factory CityMunicipalityModel.fromJson(Map<String, dynamic> json) =>
      _$CityMunicipalityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityMunicipalityModelToJson(this);
}
