import 'package:json_annotation/json_annotation.dart';

part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItem {
  static toNull(_) => null;

  @JsonKey(toJson: toNull, includeIfNull: false)
  final int id;

  @JsonKey(name: "item_code")
  final String itemCode;

  @JsonKey(name: "unit_price")
  double unitPrice;
  double quantity;

  @JsonKey(toJson: toNull, includeIfNull: false)
  double total;

  @JsonKey(name: "disc_amount")
  double? discAmount;
  double? discprcnt;

  String uom;

  @JsonKey(toJson: toNull, includeIfNull: false)
  bool isSelected;

  CartItem({
    required this.id,
    required this.itemCode,
    required this.unitPrice,
    required this.quantity,
    required this.total,
    required this.uom,
    this.discAmount = 0.00,
    this.discprcnt = 0.00,
    this.isSelected = false,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
