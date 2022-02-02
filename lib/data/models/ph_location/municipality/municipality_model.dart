import 'package:json_annotation/json_annotation.dart';

part 'municipality_model.g.dart';

@JsonSerializable()
class MunicipalityModel {
  String code;
  String name;
  String districtCode;
  String provinceCode;
  String regionCode;

  MunicipalityModel(
      {required this.code,
      required this.name,
      required this.districtCode,
      required this.provinceCode,
      required this.regionCode});

  factory MunicipalityModel.fromJson(Map<String, dynamic> json) =>
      _$MunicipalityModelFromJson(json);

  Map<String, dynamic> toJson() => _$MunicipalityModelToJson(this);
}
