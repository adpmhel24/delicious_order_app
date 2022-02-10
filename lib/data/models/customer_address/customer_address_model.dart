import 'package:json_annotation/json_annotation.dart';

part 'customer_address_model.g.dart';

@JsonSerializable()
class CustomerAddressModel {
  static toNull(_) => null;
  @JsonKey(toJson: toNull, includeIfNull: false)
  String? uid;

  @JsonKey(name: "street_address")
  String? streetAddress;

  @JsonKey(name: "city_municipality")
  String? cityMunicipality;

  String? brgy;

  @JsonKey(name: "other_details")
  String? otherDetails;

  CustomerAddressModel({
    this.uid = '',
    this.streetAddress,
    this.cityMunicipality,
    this.brgy,
    this.otherDetails,
  });

  factory CustomerAddressModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerAddressModelToJson(this);
}
