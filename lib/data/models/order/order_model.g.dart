// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as int?,
      transdate: DateTime.parse(json['transdate'] as String),
      remarks: json['remarks'] as String?,
      custCode: json['cust_code'] as String?,
      docstatus: json['docstatus'] as String?,
      orderStatus: json['order_status'] as int?,
      paymentStatus: json['payment_status'] as int?,
      transtype: json['transtype'] as String?,
      doctotal: (json['doctotal'] as num).toDouble(),
      rowDiscount: (json['row_discount'] as num).toDouble(),
      gross: (json['gross'] as num?)?.toDouble() ?? 0.00,
      delfee: (json['delfee'] as num).toDouble(),
      tenderamt: (json['tenderamt'] as num?)?.toDouble() ?? 0.00,
      deliveryDate: DateTime.parse(json['delivery_date'] as String),
      address: json['address'] as String?,
      disctype: json['disctype'] as String?,
      discprcnt: (json['discprcnt'] as num?)?.toDouble() ?? 0.00,
      otherfee: (json['otherfee'] as num?)?.toDouble() ?? 0.00,
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transdate': instance.transdate.toIso8601String(),
      'remarks': instance.remarks,
      'cust_code': instance.custCode,
      'docstatus': instance.docstatus,
      'order_status': instance.orderStatus,
      'payment_status': instance.paymentStatus,
      'transtype': instance.transtype,
      'doctotal': instance.doctotal,
      'row_discount': instance.rowDiscount,
      'gross': instance.gross,
      'delfee': instance.delfee,
      'otherfee': instance.otherfee,
      'tenderamt': instance.tenderamt,
      'delivery_date': instance.deliveryDate.toIso8601String(),
      'address': instance.address,
      'disctype': instance.disctype,
      'discprcnt': instance.discprcnt,
      'rows': instance.rows,
    };
