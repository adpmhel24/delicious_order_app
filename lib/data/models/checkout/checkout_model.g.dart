// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckOutModel _$CheckOutModelFromJson(Map<String, dynamic> json) =>
    CheckOutModel(
      transdate: DateTime.parse(json['transdate'] as String),
      deliveryDate: DateTime.parse(json['delivery_date'] as String),
      custCode: json['cust_code'] as String,
      delfee: (json['delfee'] as num?)?.toDouble() ?? 0.00,
      otherfee: (json['otherfee'] as num?)?.toDouble() ?? 0.00,
      address: json['address'] as String,
      remarks: json['remarks'] as String? ?? '',
      contactNumber: json['contact_number'] as String? ?? '',
      paymentMethod: json['payment_method'] as String,
      deliveryMethod: json['delivery_method'] as String,
      salestype: json['salestype'] as String,
      rows: (json['rows'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      disctype: json['disctype'] as String?,
    )..custName = json['cust_name'] as String?;

Map<String, dynamic> _$CheckOutModelToJson(CheckOutModel instance) {
  final val = <String, dynamic>{
    'transdate': instance.transdate.toIso8601String(),
    'delivery_date': instance.deliveryDate.toIso8601String(),
    'cust_code': instance.custCode,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('cust_name', CheckOutModel.toNull(instance.custName));
  val['address'] = instance.address;
  val['remarks'] = instance.remarks;
  val['delfee'] = instance.delfee;
  val['otherfee'] = instance.otherfee;
  val['contact_number'] = instance.contactNumber;
  val['payment_method'] = instance.paymentMethod;
  val['delivery_method'] = instance.deliveryMethod;
  val['disctype'] = instance.disctype;
  val['salestype'] = instance.salestype;
  val['rows'] = instance.rows;
  return val;
}
