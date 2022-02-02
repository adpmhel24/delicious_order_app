import 'package:json_annotation/json_annotation.dart';

part 'brgy_model.g.dart';

@JsonSerializable()
class BrgyModel {
  String code;
  String name;

  BrgyModel({
    required this.code,
    required this.name,
  });

  factory BrgyModel.fromJson(Map<String, dynamic> json) =>
      _$BrgyModelFromJson(json);

  Map<String, dynamic> toJson() => _$BrgyModelToJson(this);
}
