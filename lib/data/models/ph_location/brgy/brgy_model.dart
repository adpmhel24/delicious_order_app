import 'package:json_annotation/json_annotation.dart';

part 'brgy_model.g.dart';

@JsonSerializable()
class BrgyModel {
  String code;
  String name;
  String districtCode;
  String provinceCode;
  String regionCode;
  String municipalityCode;

  BrgyModel(
      {required this.code,
      required this.name,
      required this.districtCode,
      required this.provinceCode,
      required this.regionCode,
      required this.municipalityCode});

  factory BrgyModel.fromJson(Map<String, dynamic> json) =>
      _$BrgyModelFromJson(json);

  Map<String, dynamic> toJson() => _$BrgyModelToJson(this);
}
