import 'package:json_annotation/json_annotation.dart';

part 'sales_type_model.g.dart';

@JsonSerializable()
class SalesTypeModel {
  int? id;
  late String code;
  late String description;

  @JsonKey(name: "date_created")
  String? dateCreated;

  @JsonKey(name: "date_updated")
  String? dateUpdated;

  SalesTypeModel(
      {this.id,
      required this.code,
      required this.description,
      this.dateCreated,
      this.dateUpdated});

  factory SalesTypeModel.fromJson(Map<String, dynamic> json) =>
      _$SalesTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$SalesTypeModelToJson(this);
}
