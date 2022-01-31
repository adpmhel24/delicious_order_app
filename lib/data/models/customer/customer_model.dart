class CustomerModel {
  int? id;
  late String code;
  late String name;
  int? custType;
  String? address;
  String? dateCreated;
  String? dateUpdated;
  int? createdBy;
  int? updatedBy;
  double? balance;
  double? depBalance;
  bool? isConfidential;
  bool? isActive;
  String? contactNumber;

  CustomerModel({
    this.id,
    required this.code,
    required this.name,
    this.custType,
    this.address,
    this.dateCreated,
    this.dateUpdated,
    this.createdBy,
    this.updatedBy,
    this.balance,
    this.depBalance,
    this.isConfidential,
    this.isActive,
    this.contactNumber,
  });

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    custType = json['cust_type'];
    address = json['address'];
    dateCreated = json['date_created'];
    dateUpdated = json['date_updated'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    balance = json['balance'];
    depBalance = json['dep_balance'];
    isConfidential = json['is_confidential'];
    isActive = json['is_active'];
    contactNumber = json['contact_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['cust_type'] = custType;
    data['address'] = address;
    data['date_created'] = dateCreated;
    data['date_updated'] = dateUpdated;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['balance'] = balance;
    data['dep_balance'] = depBalance;
    data['is_confidential'] = isConfidential;
    data['is_active'] = isActive;
    data['contact_number'] = contactNumber;
    return data;
  }
}
