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

  CustomerAddressModel({
    this.uid = '',
    this.streetAddress,
    this.cityMunicipality,
    this.brgy,
  });

  CustomerAddressModel copyWith({
    String? uid,
    String? streetAddress,
    String? cityMunicipality,
    String? brgy,
  }) {
    return CustomerAddressModel(
        uid: uid ?? this.uid,
        streetAddress: streetAddress ?? this.streetAddress,
        cityMunicipality: cityMunicipality ?? this.cityMunicipality,
        brgy: brgy ?? this.brgy);
  }

  factory CustomerAddressModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerAddressModelToJson(this);
}
