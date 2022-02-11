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

  @JsonKey(name: "order_status")
  int? orderStatus;

  @JsonKey(name: "payment_status")
  int? paymentStatus;

  String? transtype;
  double doctotal;

  @JsonKey(name: "row_discount")
  double rowDiscount;

  double gross;
  double delfee;
  double otherfee;
  double tenderamt;

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
      this.orderStatus,
      this.paymentStatus,
      this.transtype,
      required this.doctotal,
      required this.rowDiscount,
      this.gross = 0.00,
      required this.delfee,
      this.tenderamt = 0.00,
      required this.deliveryDate,
      this.address,
      this.disctype,
      this.discprcnt = 0.00,
      this.otherfee = 0.00,
      required this.rows});

  String getOrderStatus() {
    if (orderStatus == 0) {
      return "For Confirmation";
    } else if (orderStatus == 1 || orderStatus == 2) {
      return "Confirmed";
    }
    return "Delivered";
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
