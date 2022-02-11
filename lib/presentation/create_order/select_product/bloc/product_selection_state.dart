import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'field_validator.dart';

class ProductSelectionState extends Equatable {
  const ProductSelectionState(
      {this.status = FormzStatus.pure,
      this.quantity = const InputField.pure(),
      this.price = const InputField.pure(),
      this.discPercentage = const InputField.pure(),
      this.discAmount = const InputField.pure(),
      this.total = const InputField.pure(),
      this.isUndo = false,
      this.message = 'Ordering failed!'});

  final FormzStatus status;
  final InputField quantity;
  final InputField price;
  final InputField total;
  final InputField discPercentage;
  final InputField discAmount;
  final String message;
  final bool isUndo;

  ProductSelectionState copyWith({
    FormzStatus? status,
    InputField? quantity,
    InputField? price,
    InputField? discPercentage,
    InputField? discAmount,
    InputField? total,
    String? message,
    bool? isUndo,
  }) {
    return ProductSelectionState(
      status: status ?? this.status,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      discPercentage: discPercentage ?? this.discPercentage,
      discAmount: discAmount ?? this.discAmount,
      total: total ?? this.total,
      message: message ?? this.message,
      isUndo: isUndo ?? this.isUndo,
    );
  }

  @override
  List<Object> get props => [
        status,
        quantity,
        discPercentage,
        discAmount,
        price,
        message,
        total,
        isUndo
      ];
}
