// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      id: json['id'] as int,
      itemCode: json['item_code'] as String,
      unitPrice: (json['unit_price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      uom: json['uom'] as String,
      discAmount: (json['disc_amount'] as num?)?.toDouble() ?? 0.00,
      discprcnt: (json['discprcnt'] as num?)?.toDouble() ?? 0.00,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', CartItem.toNull(instance.id));
  val['item_code'] = instance.itemCode;
  val['unit_price'] = instance.unitPrice;
  val['quantity'] = instance.quantity;
  writeNotNull('total', CartItem.toNull(instance.total));
  val['disc_amount'] = instance.discAmount;
  val['discprcnt'] = instance.discprcnt;
  val['uom'] = instance.uom;
  writeNotNull('isSelected', CartItem.toNull(instance.isSelected));
  return val;
}
