// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckOutModel _$CheckOutModelFromJson(Map<String, dynamic> json) =>
    CheckOutModel(
      transdate: json['transdate'] == null
          ? null
          : DateTime.parse(json['transdate'] as String),
      deliveryDate: json['delivery_date'] == null
          ? null
          : DateTime.parse(json['delivery_date'] as String),
      custCode: json['cust_code'] as String?,
      delfee: (json['delfee'] as num?)?.toDouble() ?? 0.00,
      otherfee: (json['otherfee'] as num?)?.toDouble() ?? 0.00,
      address: json['address'] as String?,
      remarks: json['remarks'] as String?,
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      contactNumber: json['contact_number'] as String?,
      customerId: json['customer_id'] as int? ?? -1,
      paymentMethod: json['payment_method'] as String?,
      deliveryMethod: json['delivery_method'] as String?,
    )..custType = json['cust_type'] as String?;

Map<String, dynamic> _$CheckOutModelToJson(CheckOutModel instance) {
  final val = <String, dynamic>{
    'transdate': instance.transdate?.toIso8601String(),
    'delivery_date': instance.deliveryDate?.toIso8601String(),
    'cust_code': instance.custCode,
    'address': instance.address,
    'remarks': instance.remarks,
    'delfee': instance.delfee,
    'otherfee': instance.otherfee,
    'contact_number': instance.contactNumber,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('cust_type', CheckOutModel.toNull(instance.custType));
  writeNotNull('customer_id', CheckOutModel.toNull(instance.customerId));
  val['payment_method'] = instance.paymentMethod;
  val['delivery_method'] = instance.deliveryMethod;
  val['rows'] = instance.rows;
  return val;
}
