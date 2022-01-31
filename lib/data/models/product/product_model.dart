class ProductModel {
  int? id;
  late String itemCode;
  late String itemName;
  String? uom;
  String? itemGroup;
  double? price;
  int? uomGroup;
  // String? dateCreated;
  // String? dateUpdated;
  String? premixCode;
  bool isSelected = false;

  ProductModel({
    this.id,
    required this.itemCode,
    required this.itemName,
    this.uom,
    this.itemGroup,
    this.price,
    required this.uomGroup,

    // this.dateCreated,
    // this.dateUpdated,
    this.premixCode,
    this.isSelected = false,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemCode = json['item_code'].toString();
    itemName = json['item_name'].toString();
    uom = json['uom'];
    itemGroup = json['item_group'];
    price = json['price'];
    uomGroup = json['uom_group'];
    // dateCreated = json['date_created'];
    // dateUpdated = json['date_updated'];
    premixCode = json['premix_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item_code'] = itemCode;
    data['item_name'] = itemName;
    data['uom'] = uom;
    data['item_group'] = itemGroup;
    data['price'] = price;
    data['uom_group'] = uomGroup;
    // data['date_created'] = dateCreated;
    // data['date_updated'] = dateUpdated;
    data['premix_code'] = premixCode;
    return data;
  }
}
