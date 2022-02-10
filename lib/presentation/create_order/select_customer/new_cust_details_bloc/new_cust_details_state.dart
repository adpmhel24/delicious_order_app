import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../../widget/text_field_validator.dart';

class NewCustDetailsState extends Equatable {
  final FormzStatus status;
  final TextFieldModel cityMunicipality;
  final TextFieldModel brgy;
  final TextFieldModel streetAddress;
  final TextFieldModel otherDetails;
  final String message;

  const NewCustDetailsState({
    this.status = FormzStatus.pure,
    this.cityMunicipality = const TextFieldModel.pure(),
    this.brgy = const TextFieldModel.pure(),
    this.streetAddress = const TextFieldModel.pure(),
    this.otherDetails = const TextFieldModel.pure(),
    this.message = '',
  });

  NewCustDetailsState copyWith({
    FormzStatus? status,
    TextFieldModel? cityMunicipality,
    TextFieldModel? brgy,
    TextFieldModel? streetAddress,
    TextFieldModel? otherDetails,
    String? message,
  }) {
    return NewCustDetailsState(
      status: status ?? this.status,
      cityMunicipality: cityMunicipality ?? this.cityMunicipality,
      brgy: brgy ?? this.brgy,
      streetAddress: streetAddress ?? this.streetAddress,
      otherDetails: otherDetails ?? this.otherDetails,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        status,
        cityMunicipality,
        brgy,
        streetAddress,
        otherDetails,
      ];
}
