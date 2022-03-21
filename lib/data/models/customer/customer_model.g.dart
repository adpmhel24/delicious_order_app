// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel(
      id: json['id'] as int?,
      code: json['code'] as String,
      name: json['name'] as String,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      custType: json['cust_type'] as int?,
      address: json['address'] as String?,
      province: json['province'] as String?,
      cityMunicipality: json['city_municipality'] as String?,
      brgy: json['brgy'] as String?,
      balance: (json['balance'] as num?)?.toDouble(),
      depBalance: (json['dep_balance'] as num?)?.toDouble(),
      isConfidential: json['is_confidential'] as bool?,
      isActive: json['is_active'] as bool?,
      contactNumber: json['contact_number'] as String?,
      user: json['user'] as Map<String, dynamic>?,
      allowedDiscount: (json['allowed_disc'] as num?)?.toDouble(),
      pickupDiscount: (json['pickup_disc'] as num?)?.toDouble(),
      details: CustomerModel.customerAddressFromJson(json['details'] as List),
    );

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'cust_type': instance.custType,
      'address': instance.address,
      'province': instance.province,
      'city_municipality': instance.cityMunicipality,
      'brgy': instance.brgy,
      'balance': instance.balance,
      'dep_balance': instance.depBalance,
      'is_confidential': instance.isConfidential,
      'is_active': instance.isActive,
      'contact_number': instance.contactNumber,
      'allowed_disc': instance.allowedDiscount,
      'pickup_disc': instance.pickupDiscount,
      'user': instance.user,
      'details': instance.details,
    };
