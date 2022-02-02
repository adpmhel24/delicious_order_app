import 'package:json_annotation/json_annotation.dart';

part 'province_model.g.dart';

@JsonSerializable()
class ProvinceModel {
  String? code;
  String? name;
  String? regionCode;
  bool? isDistrict;

  ProvinceModel({
    this.code,
    this.name,
    this.regionCode,
    this.isDistrict,
  });

  factory ProvinceModel.fromJson(Map<String, dynamic> json) =>
      _$ProvinceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProvinceModelToJson(this);
}
