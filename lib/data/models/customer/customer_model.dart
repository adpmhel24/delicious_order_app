import 'package:json_annotation/json_annotation.dart';
import '../models.dart';

part 'customer_model.g.dart';

@JsonSerializable()
class CustomerModel {
  static List<CustomerAddressModel?> customerAddressFromJson(
      List<dynamic> data) {
    if (data.isNotEmpty) {
      return data.map((e) => CustomerAddressModel.fromJson(e!)).toList();
    } else {
      return [];
    }
  }

  int? id;
  late String code;
  late String name;

  @JsonKey(name: "first_name")
  String? firstName;

  @JsonKey(name: "last_name")
  String? lastName;

  @JsonKey(name: "cust_type")
  int? custType;

  String? address;

  String? province;

  @JsonKey(name: "city_municipality")
  String? cityMunicipality;

  String? brgy;
  double? balance;

  @JsonKey(name: "dep_balance")
  double? depBalance;

  @JsonKey(name: "is_confidential")
  bool? isConfidential;

  @JsonKey(name: "is_active")
  bool? isActive;

  @JsonKey(name: "contact_number")
  String? contactNumber;

  @JsonKey(name: "allowed_disc")
  double? allowedDiscount;

  @JsonKey(name: "pickup_disc")
  double? pickupDiscount;

  Map<String, dynamic>? user;

  @JsonKey(fromJson: customerAddressFromJson)
  List<CustomerAddressModel?> details;

  CustomerModel({
    this.id,
    required this.code,
    required this.name,
    this.firstName,
    this.lastName,
    this.custType,
    this.address,
    this.province,
    this.cityMunicipality,
    this.brgy,
    this.balance,
    this.depBalance,
    this.isConfidential,
    this.isActive,
    this.contactNumber,
    this.user,
    this.allowedDiscount,
    this.pickupDiscount,
    required this.details,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}
