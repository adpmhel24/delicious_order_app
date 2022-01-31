// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerTypeModel _$CustomerTypeModelFromJson(Map<String, dynamic> json) =>
    CustomerTypeModel(
      id: json['id'] as int,
      code: json['code'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$CustomerTypeModelToJson(CustomerTypeModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', CustomerTypeModel.toNull(instance.id));
  val['code'] = instance.code;
  val['name'] = instance.name;
  return val;
}
