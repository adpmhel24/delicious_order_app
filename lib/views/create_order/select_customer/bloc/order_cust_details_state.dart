import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import '/widget/text_field_validator.dart';

class OrderCustDetailsState extends Equatable {
  final FormzStatus status;
  final TextFieldModel customerId;
  final TextFieldModel custType;
  final TextFieldModel custCode;
  final TextFieldModel contactNumber;
  final TextFieldModel address;

  const OrderCustDetailsState({
    this.status = FormzStatus.pure,
    this.custType = const TextFieldModel.pure(),
    this.custCode = const TextFieldModel.pure(),
    this.contactNumber = const TextFieldModel.pure(),
    this.address = const TextFieldModel.pure(),
    this.customerId = const TextFieldModel.pure(),
  });

  OrderCustDetailsState copyWith({
    FormzStatus? status,
    TextFieldModel? customerId,
    TextFieldModel? custType,
    TextFieldModel? custCode,
    TextFieldModel? contactNumber,
    TextFieldModel? address,
  }) {
    return OrderCustDetailsState(
      status: status ?? this.status,
      customerId: customerId ?? this.customerId,
      custType: custType ?? this.custType,
      custCode: custCode ?? this.custCode,
      contactNumber: contactNumber ?? this.contactNumber,
      address: address ?? this.address,
    );
  }

  @override
  List<Object> get props => [
        status,
        custType,
        custCode,
        contactNumber,
        address,
        customerId,
      ];
}
