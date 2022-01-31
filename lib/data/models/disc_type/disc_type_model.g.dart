// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disc_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscTypeModel _$DiscTypeModelFromJson(Map<String, dynamic> json) =>
    DiscTypeModel(
      id: json['id'] as int,
      code: json['code'] as String,
      description: json['description'] as String,
      discount: (json['discount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DiscTypeModelToJson(DiscTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'description': instance.description,
      'discount': instance.discount,
    };
