import 'package:json_annotation/json_annotation.dart';

part 'customer_type_model.g.dart';

@JsonSerializable()
class CustomerTypeModel {
  static toNull(_) => null;

  @JsonKey(toJson: toNull, includeIfNull: false)
  int id;
  String code;
  String name;

  CustomerTypeModel({
    required this.id,
    required this.code,
    required this.name,
  });

  factory CustomerTypeModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerTypeModelToJson(this);
}
