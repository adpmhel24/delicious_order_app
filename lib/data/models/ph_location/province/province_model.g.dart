// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'province_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProvinceModel _$ProvinceModelFromJson(Map<String, dynamic> json) =>
    ProvinceModel(
      code: json['code'] as String?,
      name: json['name'] as String?,
      regionCode: json['regionCode'] as String?,
      isDistrict: json['isDistrict'] as bool?,
    );

Map<String, dynamic> _$ProvinceModelToJson(ProvinceModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'regionCode': instance.regionCode,
      'isDistrict': instance.isDistrict,
    };
