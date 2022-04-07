import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import '../../../../data/models/models.dart';
import '/widget/text_field_validator.dart';

class OrderCustDetailsState extends Equatable {
  final FormzStatus status;
  final CustomerModel? selectedCustomer;
  final CustomerAddressModel? selectedAddress;
  final TextFieldModel customerId;
  final TextFieldModel custCode;
  final TextFieldModel contactNumber;
  final TextFieldModel address;

  const OrderCustDetailsState({
    this.status = FormzStatus.pure,
    this.selectedCustomer,
    this.selectedAddress,
    this.address = const TextFieldModel.pure(),
    this.custCode = const TextFieldModel.pure(),
    this.contactNumber = const TextFieldModel.pure(),
    this.customerId = const TextFieldModel.pure(),
  });

  OrderCustDetailsState copyWith({
    FormzStatus? status,
    CustomerModel? selectedCustomer,
    CustomerAddressModel? selectedAddress,
    TextFieldModel? customerId,
    TextFieldModel? custCode,
    TextFieldModel? contactNumber,
    TextFieldModel? address,
  }) {
    return OrderCustDetailsState(
      status: status ?? this.status,
      selectedCustomer: selectedCustomer ?? this.selectedCustomer,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      customerId: customerId ?? this.customerId,
      address: address ?? this.address,
      custCode: custCode ?? this.custCode,
      contactNumber: contactNumber ?? this.contactNumber,
    );
  }

  OrderCustDetailsState clearData() {
    return const OrderCustDetailsState(
      status: FormzStatus.pure,
      selectedCustomer: null,
      selectedAddress: null,
      address: TextFieldModel.pure(),
      custCode: TextFieldModel.pure(),
      contactNumber: TextFieldModel.pure(),
      customerId: TextFieldModel.pure(),
    );
  }

  @override
  List<Object?> get props => [
        status,
        selectedCustomer,
        selectedAddress,
        address,
        custCode,
        contactNumber,
        customerId,
      ];
}
