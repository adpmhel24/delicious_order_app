// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesTypeModel _$SalesTypeModelFromJson(Map<String, dynamic> json) =>
    SalesTypeModel(
      id: json['id'] as int?,
      code: json['code'] as String,
      description: json['description'] as String,
      dateCreated: json['date_created'] as String?,
      dateUpdated: json['date_updated'] as String?,
    );

Map<String, dynamic> _$SalesTypeModelToJson(SalesTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'description': instance.description,
      'date_created': instance.dateCreated,
      'date_updated': instance.dateUpdated,
    };
