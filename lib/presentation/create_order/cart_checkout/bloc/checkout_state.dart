import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../../data/models/models.dart';
import '../../../../widget/text_field_validator.dart';

class CheckOutState extends Equatable {
  final FormzStatus status;
  final TextFieldModel custCode;
  final TextFieldModel deliveryDate;
  final TextFieldModel deliveryMethod;
  final TextFieldModel paymentMethod;
  final TextFieldModel salesTypeCode;
  final TextFieldModel discTypeCode;
  final TextFieldModel remarks;
  final TextFieldModel address;
  final TextFieldModel deliveryFee;
  final TextFieldModel otherFee;
  final CustomerModel? selectedCustomer;
  final CustomerAddressModel? selectedAddress;
  final List<CartItem> cartItems;
  final TextFieldModel message;

  const CheckOutState({
    this.status = FormzStatus.pure,
    this.custCode = const TextFieldModel.pure(),
    this.deliveryDate = const TextFieldModel.pure(),
    this.deliveryMethod = const TextFieldModel.pure(),
    this.paymentMethod = const TextFieldModel.pure(),
    this.salesTypeCode = const TextFieldModel.pure(),
    this.discTypeCode = const TextFieldModel.pure(),
    this.remarks = const TextFieldModel.pure(),
    this.address = const TextFieldModel.pure(),
    this.deliveryFee = const TextFieldModel.pure(),
    this.otherFee = const TextFieldModel.pure(),
    this.selectedCustomer,
    this.selectedAddress,
    this.cartItems = const [],
    this.message = const TextFieldModel.pure(),
  });

  double get total {
    double totalAmount = 0;
    for (var e in cartItems) {
      totalAmount += e.total;
    }
    return totalAmount;
  }

  double get orderTotal {
    double _orderTotal = 0;
    for (var e in cartItems) {
      _orderTotal += e.total;
    }
    _orderTotal += double.parse(
            deliveryFee.value.isNotEmpty ? deliveryFee.value : '0.00') +
        double.parse(otherFee.value.isNotEmpty ? otherFee.value : '0.00');
    return _orderTotal;
  }

  CheckOutState copyWith({
    FormzStatus? status,
    TextFieldModel? custCode,
    TextFieldModel? deliveryDate,
    TextFieldModel? deliveryMethod,
    TextFieldModel? paymentMethod,
    TextFieldModel? salesTypeCode,
    TextFieldModel? discTypeCode,
    TextFieldModel? deliveryFee,
    TextFieldModel? otherFee,
    TextFieldModel? remarks,
    TextFieldModel? address,
    List<CartItem>? cartItems,
    CustomerModel? selectedCustomer,
    CustomerAddressModel? selectedAddress,
    TextFieldModel? message,
  }) {
    return CheckOutState(
      status: status ?? this.status,
      custCode: custCode ?? this.custCode,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      salesTypeCode: salesTypeCode ?? this.salesTypeCode,
      discTypeCode: discTypeCode ?? this.discTypeCode,
      cartItems: cartItems ?? this.cartItems,
      selectedCustomer: selectedCustomer ?? this.selectedCustomer,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      otherFee: otherFee ?? this.otherFee,
      message: message ?? this.message,
      remarks: remarks ?? this.remarks,
      address: address ?? this.address,
    );
  }

  @override
  List<Object?> get props => [
        status,
        custCode,
        deliveryDate,
        deliveryMethod,
        paymentMethod,
        salesTypeCode,
        discTypeCode,
        cartItems,
        selectedCustomer,
        selectedAddress,
        deliveryFee,
        otherFee,
        message,
        remarks,
        address,
      ];
}
