import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  int? id;
  DateTime transdate;
  String? remarks;

  @JsonKey(name: "cust_code")
  String? custCode;
  String? docstatus;

  @JsonKey(name: "delivery_status")
  int? deliveryStatus;

  @JsonKey(name: "payment_status")
  int? paymentStatus;

  String? transtype;
  double doctotal;
  double? gross;
  double delfee;
  double? tenderamt;

  @JsonKey(name: "delivery_date")
  DateTime deliveryDate;
  String? address;

  String? disctype;
  double? discprcnt;

  List<Map<String, dynamic>>? rows;

  OrderModel(
      {this.id,
      required this.transdate,
      this.remarks,
      this.custCode,
      this.docstatus,
      this.deliveryStatus,
      this.paymentStatus,
      this.transtype,
      required this.doctotal,
      this.gross,
      required this.delfee,
      this.tenderamt,
      required this.deliveryDate,
      this.address,
      this.disctype,
      this.discprcnt,
      required this.rows});

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
