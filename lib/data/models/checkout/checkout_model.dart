import 'package:json_annotation/json_annotation.dart';

part 'checkout_model.g.dart';

@JsonSerializable()
class CheckOutModel {
  static toNull(_) => null;

  DateTime? transdate;

  @JsonKey(name: "delivery_date")
  DateTime? deliveryDate;

  @JsonKey(name: "cust_code")
  String? custCode;

  @JsonKey(name: 'cust_name', toJson: toNull, includeIfNull: false)
  String? custName;

  String? address;
  String? remarks;

  double? delfee;
  double? otherfee;

  @JsonKey(name: 'contact_number')
  String? contactNumber;

  @JsonKey(name: 'cust_type', toJson: toNull, includeIfNull: false)
  String? custType;

  @JsonKey(name: 'customer_id', toJson: toNull, includeIfNull: false)
  int? customerId;

  @JsonKey(name: 'payment_method')
  String? paymentMethod;

  @JsonKey(name: 'delivery_method')
  String? deliveryMethod;

  String? salestype;
  String? disctype;

  List<Map<String, dynamic>>? rows;

  CheckOutModel({
    this.transdate,
    this.deliveryDate,
    this.custCode,
    this.delfee = 0.00,
    this.otherfee = 0.00,
    this.address,
    this.remarks,
    this.rows,
    this.contactNumber,
    this.customerId = -1,
    this.paymentMethod,
    this.deliveryMethod,
    this.salestype,
  });

  factory CheckOutModel.fromJson(Map<String, dynamic> json) =>
      _$CheckOutModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckOutModelToJson(this);
}
