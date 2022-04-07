import 'dart:async';

import 'package:delicious_ordering_app/data/models/customer/customer_model.dart';
import 'package:delicious_ordering_app/data/models/customer_address/customer_address_model.dart';
import 'package:delicious_ordering_app/presentation/create_order/cart_checkout/bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global_bloc/customer_bloc/bloc.dart';
import './bloc.dart';
import '/widget/text_field_validator.dart';

class OrderCustDetailsBloc
    extends Bloc<OrderCustDetailsEvent, OrderCustDetailsState> {
  final CustomerBloc _customerBloc;
  final CheckOutBloc _checkOutBloc;
  late final StreamSubscription _customerBlocSubscription;
  late final StreamSubscription _checkOutBlocSubscription;
  OrderCustDetailsBloc(this._customerBloc, this._checkOutBloc)
      : super(const OrderCustDetailsState()) {
    on<ChangedCustomerSelected>(_onChangedCustomerSelected);
    on<ChangedAddressSelected>(onAddressChange);
    on<ClearData>(_onClearData);
    _customerBlocSubscription = _customerBloc.stream.listen((state) {
      if (state.status == CustomerBlocStatus.success &&
          state.lastUpdateCustomer != null) {
        add(ChangedCustomerSelected(
            selectedCustomer: state.lastUpdateCustomer));
      }
    });

    _checkOutBlocSubscription =
        _checkOutBloc.stream.listen((checkOutBlocState) {
      if (checkOutBlocState.status.isSubmissionSuccess) {
        add(ClearData());
      }
    });
  }

  void _onChangedCustomerSelected(
      ChangedCustomerSelected event, Emitter<OrderCustDetailsState> emit) {
    CustomerModel? selectedCustomer = event.selectedCustomer;
    CustomerAddressModel? selectedAddress;
    String custId = selectedCustomer?.id.toString() ?? '';
    String defaultAddress;
    if (selectedCustomer?.details != null &&
        selectedCustomer!.details.isNotEmpty) {
      final int defaultAddressIndx = selectedCustomer.details.indexWhere(
          (element) => element?.isDefault != null && element!.isDefault!);
      if (defaultAddressIndx >= 0) {
        selectedAddress = selectedCustomer.details[defaultAddressIndx];
        defaultAddress =
            """${selectedCustomer.details[defaultAddressIndx]?.streetAddress ?? ''}
${selectedCustomer.details[defaultAddressIndx]?.brgy == null ? '' : 'Brgy. ${selectedCustomer.details[defaultAddressIndx]!.brgy}'}
${selectedCustomer.details[defaultAddressIndx]?.cityMunicipality ?? ''}
""";
      } else {
        selectedAddress = selectedCustomer.details[0];
        defaultAddress = """${selectedCustomer.details[0]?.streetAddress ?? ''}
${selectedCustomer.details[0]?.brgy == null ? '' : 'Brgy. ${selectedCustomer.details[0]!.brgy}'}
${selectedCustomer.details[0]?.cityMunicipality ?? ''}
""";
      }
    } else {
      defaultAddress = '';
    }

    final customerId = TextFieldModel.dirty(custId);
    final custCode = TextFieldModel.dirty(selectedCustomer?.code ?? '');
    final contactNumber =
        TextFieldModel.dirty(selectedCustomer?.contactNumber ?? '');

    final address = TextFieldModel.dirty(defaultAddress);
    emit(
      state.copyWith(
        selectedCustomer: selectedCustomer,
        customerId: customerId,
        custCode: custCode,
        contactNumber: contactNumber,
        address: address,
        selectedAddress: selectedAddress,
        status: Formz.validate([custCode]),
      ),
    );
  }

  void onAddressChange(
      ChangedAddressSelected event, Emitter<OrderCustDetailsState> emit) {
    String completeAddress = """${event.selectedAddress?.streetAddress ?? ''}
${event.selectedAddress?.brgy == null ? '' : 'Brgy. ${event.selectedAddress?.brgy}'}
${event.selectedAddress?.cityMunicipality ?? ''}
""";
    final address = TextFieldModel.dirty(completeAddress);

    emit(state.copyWith(
      address: address,
      selectedAddress: event.selectedAddress,
      status: Formz.validate([
        state.custCode,
      ]),
    ));
  }

  void _onClearData(ClearData event, Emitter<OrderCustDetailsState> emit) {
    emit(state.clearData());
  }

  @override
  Future<void> close() {
    _customerBlocSubscription.cancel();
    _checkOutBlocSubscription.cancel();
    return super.close();
  }
}
