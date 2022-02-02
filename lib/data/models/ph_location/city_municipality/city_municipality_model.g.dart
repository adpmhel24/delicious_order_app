// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_municipality_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityMunicipalityModel _$CityMunicipalityModelFromJson(
        Map<String, dynamic> json) =>
    CityMunicipalityModel(
      code: json['code'] as String,
      name: json['name'] as String,
      isCapital: json['isCapital'] as bool?,
      isCity: json['isCity'] as bool?,
      isMunicipality: json['isMunicipality'] as bool?,
    );

Map<String, dynamic> _$CityMunicipalityModelToJson(
        CityMunicipalityModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'isCapital': instance.isCapital,
      'isCity': instance.isCity,
      'isMunicipality': instance.isMunicipality,
    };
