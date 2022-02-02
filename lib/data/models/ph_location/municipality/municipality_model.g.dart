// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'municipality_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MunicipalityModel _$MunicipalityModelFromJson(Map<String, dynamic> json) =>
    MunicipalityModel(
      code: json['code'] as String,
      name: json['name'] as String,
      districtCode: json['districtCode'] as String,
      provinceCode: json['provinceCode'] as String,
      regionCode: json['regionCode'] as String,
    );

Map<String, dynamic> _$MunicipalityModelToJson(MunicipalityModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'districtCode': instance.districtCode,
      'provinceCode': instance.provinceCode,
      'regionCode': instance.regionCode,
    };
