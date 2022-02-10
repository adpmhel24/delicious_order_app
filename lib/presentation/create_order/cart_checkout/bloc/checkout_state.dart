import 'package:equatable/equatable.dart';

class CheckOutState extends Equatable {
  final bool isInit;
  final bool isValidDeliveryDate;
  final bool isDeliveryMethodValid;
  final bool isPaymentMethodValid;
  final bool isSalesTypeCodeValid;
  final String remarks;
  final bool isSubmitting;
  final bool isError;
  final bool isSuccess;
  final String message;

  const CheckOutState({
    required this.isInit,
    required this.isValidDeliveryDate,
    required this.isDeliveryMethodValid,
    required this.isPaymentMethodValid,
    required this.isSubmitting,
    required this.isError,
    required this.isSuccess,
    required this.isSalesTypeCodeValid,
    this.remarks = '',
    this.message = '',
  });

  bool get isFormValid =>
      isValidDeliveryDate && isDeliveryMethodValid && isPaymentMethodValid;

  factory CheckOutState.empty() {
    return const CheckOutState(
        isInit: true,
        isDeliveryMethodValid: false,
        isPaymentMethodValid: false,
        isValidDeliveryDate: false,
        isSalesTypeCodeValid: false,
        isSubmitting: false,
        isError: false,
        isSuccess: false);
  }

  factory CheckOutState.submitting() {
    return const CheckOutState(
      isInit: false,
      isValidDeliveryDate: true,
      isDeliveryMethodValid: true,
      isPaymentMethodValid: true,
      isSalesTypeCodeValid: true,
      isSubmitting: true,
      isError: false,
      isSuccess: false,
    );
  }

  factory CheckOutState.error(String message) {
    return CheckOutState(
      isInit: false,
      isValidDeliveryDate: true,
      isDeliveryMethodValid: true,
      isPaymentMethodValid: true,
      isSalesTypeCodeValid: true,
      isSubmitting: false,
      isError: true,
      isSuccess: false,
      message: message,
    );
  }

  factory CheckOutState.success(String message) {
    return CheckOutState(
      isInit: false,
      isValidDeliveryDate: true,
      isDeliveryMethodValid: true,
      isPaymentMethodValid: true,
      isSalesTypeCodeValid: true,
      isSubmitting: false,
      isError: false,
      isSuccess: true,
      message: message,
    );
  }

  CheckOutState update({
    bool? isValidDeliveryDate,
    bool? isDeliveryMethodValid,
    bool? isPaymentMethodValid,
    bool? isSalesTypeCodeValid,
    String? remarks,
  }) {
    return copyWith(
      isInit: false,
      isValidDeliveryDate: isValidDeliveryDate,
      isDeliveryMethodValid: isDeliveryMethodValid,
      isPaymentMethodValid: isPaymentMethodValid,
      isSalesTypeCodeValid: isSalesTypeCodeValid,
      remarks: remarks,
    );
  }

  CheckOutState copyWith({
    bool? isInit,
    bool? isValidDeliveryDate,
    bool? isDeliveryMethodValid,
    bool? isPaymentMethodValid,
    bool? isSalesTypeCodeValid,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isError,
    String? message,
    String? remarks,
  }) {
    return CheckOutState(
      isInit: isInit ?? this.isInit,
      isValidDeliveryDate: isValidDeliveryDate ?? this.isValidDeliveryDate,
      isDeliveryMethodValid:
          isDeliveryMethodValid ?? this.isDeliveryMethodValid,
      isPaymentMethodValid: isPaymentMethodValid ?? this.isPaymentMethodValid,
      isSalesTypeCodeValid: isSalesTypeCodeValid ?? this.isSalesTypeCodeValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      message: message ?? this.message,
      remarks: remarks ?? this.remarks,
    );
  }

  @override
  List<Object> get props => [
        isInit,
        isValidDeliveryDate,
        remarks,
        isSubmitting,
        isError,
        isSuccess,
        isDeliveryMethodValid,
        isPaymentMethodValid,
        isSalesTypeCodeValid,
      ];
}
