// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brgy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrgyModel _$BrgyModelFromJson(Map<String, dynamic> json) => BrgyModel(
      code: json['code'] as String,
      name: json['name'] as String,
      districtCode: json['districtCode'] as String,
      provinceCode: json['provinceCode'] as String,
      regionCode: json['regionCode'] as String,
      municipalityCode: json['municipalityCode'] as String,
    );

Map<String, dynamic> _$BrgyModelToJson(BrgyModel instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'districtCode': instance.districtCode,
      'provinceCode': instance.provinceCode,
      'regionCode': instance.regionCode,
      'municipalityCode': instance.municipalityCode,
    };
