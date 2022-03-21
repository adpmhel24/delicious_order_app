import 'package:json_annotation/json_annotation.dart';

part 'checkout_model.g.dart';

@JsonSerializable()
class CheckOutModel {
  static toNull(_) => null;

  DateTime transdate;

  @JsonKey(name: "delivery_date")
  DateTime deliveryDate;

  @JsonKey(name: "cust_code")
  String custCode;

  @JsonKey(name: 'cust_name', toJson: toNull, includeIfNull: false)
  String? custName;

  String address;
  String remarks;

  double delfee;
  double otherfee;

  @JsonKey(name: 'contact_number')
  String contactNumber;

  @JsonKey(name: 'payment_method')
  String paymentMethod;

  @JsonKey(name: 'delivery_method')
  String deliveryMethod;

  String? disctype;
  String salestype;

  List<Map<String, dynamic>> rows;

  CheckOutModel({
    required this.transdate,
    required this.deliveryDate,
    required this.custCode,
    this.delfee = 0.00,
    this.otherfee = 0.00,
    required this.address,
    this.remarks = '',
    this.contactNumber = '',
    required this.paymentMethod,
    required this.deliveryMethod,
    required this.salestype,
    required this.rows,
    this.disctype,
  });

  factory CheckOutModel.fromJson(Map<String, dynamic> json) =>
      _$CheckOutModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckOutModelToJson(this);
}
