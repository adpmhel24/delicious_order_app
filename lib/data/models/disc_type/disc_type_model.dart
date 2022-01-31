import 'package:json_annotation/json_annotation.dart';

part 'disc_type_model.g.dart';

@JsonSerializable()
class DiscTypeModel {
  int id;
  String code;
  String description;
  double? discount;

  DiscTypeModel({
    required this.id,
    required this.code,
    required this.description,
    this.discount,
  });

  factory DiscTypeModel.fromJson(Map<String, dynamic> json) =>
      _$DiscTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$DiscTypeModelToJson(this);
}
