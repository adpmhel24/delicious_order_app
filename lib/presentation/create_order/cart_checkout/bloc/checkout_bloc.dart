import 'dart:async';
import 'dart:io';

import 'package:delicious_ordering_app/data/repositories/repositories.dart';
import 'package:delicious_ordering_app/presentation/create_order/cart_checkout/bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../data/models/models.dart';
import '../../../../widget/text_field_validator.dart';
import '../../select_product/bloc/bloc.dart';

class CheckOutBloc extends Bloc<CheckOutEvent, CheckOutState> {
  final CartRepo _cartRepo;
  final OrderRepo _orderRepo = AppRepo.orderRepository;

  final ProductSelectionBloc _prodSelectionBloc;
  late final StreamSubscription _prodSelectionBlocSubscription;

  CheckOutBloc(this._cartRepo, this._prodSelectionBloc)
      : super(const CheckOutState()) {
    on<DeliveryDateChange>(_onDeliveryDateChange);
    on<CheckOutNotesChange>(_onCheckOutNotesChange);
    on<ProceedCheckOut>(_onCheckOut);
    on<DeliveryMethodChange>(_onDeliveryMethodChange);
    on<PaymentMethodChange>(_onPaymentMethodChange);
    on<SalesTypeCodeChange>(_onSalesTypeCodeChange);
    on<DiscTypeCodeChange>(_onDiscTypeCodeChange);
    on<OpenCartScreen>(_onOpenCartScreen);
    on<CartItemsUpdated>(_onCartItemsUpdated);
    on<DeleteItemInCart>(_onDeleteItemInCart);
    on<ClearItemInCart>(_onClearItemInCart);
    on<DeliveryFeeAdded>(_onDeliveryFeeAdded);
    on<OtherFeeAdded>(_onOtherFeeAdded);

    _prodSelectionBlocSubscription =
        _prodSelectionBloc.stream.listen((itemSelectionBloc) {
      if (itemSelectionBloc.status.isSubmissionSuccess) {
        add(CartItemsUpdated(_cartRepo.cartItems));
      }
    });
  }

  void _onDeliveryDateChange(
      DeliveryDateChange event, Emitter<CheckOutState> emit) {
    final deliveryDate = TextFieldModel.dirty(event.deliveryDate);

    emit(
      state.copyWith(
        deliveryDate: deliveryDate,
        status: Formz.validate([
          deliveryDate,
          state.custCode,
          state.deliveryMethod,
          state.paymentMethod,
          state.salesTypeCode,
        ]),
      ),
    );
  }

  void _onCheckOutNotesChange(
      CheckOutNotesChange event, Emitter<CheckOutState> emit) {
    final remarks = TextFieldModel.dirty(event.notes);

    emit(
      state.copyWith(
        remarks: remarks,
        status: Formz.validate([
          state.deliveryDate,
          state.deliveryMethod,
          state.paymentMethod,
          state.salesTypeCode,
        ]),
      ),
    );
  }

  void _onCartItemsUpdated(
      CartItemsUpdated event, Emitter<CheckOutState> emit) {
    if (event.cartItems.isNotEmpty) {
      List<Map<String, dynamic>> items = [];

      for (var item in event.cartItems) {
        Map<String, dynamic> data = {
          "id": item.id,
          "item_code": item.itemCode,
          "uom": item.uom,
          "quantity": item.quantity,
          "unit_price": item.unitPrice,
          "disc_amount": item.discAmount,
          "discprcnt": item.discprcnt,
          "total": item.total,
        };
        items.add(data);
      }

      List<CartItem> cartItems = List<CartItem>.from(
        items.map((e) {
          return CartItem.fromJson(e);
        }).toList(),
      );

      double discount = 0;
      if (state.deliveryMethod.value.toLowerCase() == 'pickup') {
        discount = (state.selectedCustomer?.allowedDiscount ?? 0) +
            (state.selectedCustomer?.pickupDiscount ?? 0);
      } else {
        discount = (state.selectedCustomer?.allowedDiscount ?? 0);
      }

      if (discount > 0) {
        for (var cartItem in cartItems) {
          double gross = cartItem.quantity * cartItem.unitPrice;
          cartItem.discprcnt = discount == 0 && cartItem.discprcnt != 0
              ? cartItem.discprcnt
              : discount;

          var disc = double.parse(
              ((cartItem.discprcnt ?? 0) / 100).toStringAsFixed(3));

          double discAmount = double.parse((gross * disc).toStringAsFixed(2));
          cartItem.discAmount = discAmount;
          cartItem.total =
              double.parse((gross - discAmount).toStringAsFixed(2));
        }
      }

      emit(
        state.copyWith(
          cartItems: cartItems,
          status: Formz.validate([
            state.custCode,
            state.salesTypeCode,
            state.paymentMethod,
            state.deliveryMethod,
            state.deliveryDate,
          ]),
        ),
      );
    } else {
      emit(
        state.copyWith(
          cartItems: List<CartItem>.from([]),
          status: Formz.validate([
            state.custCode,
            state.salesTypeCode,
            state.paymentMethod,
            state.deliveryMethod,
            state.deliveryDate,
          ]),
        ),
      );
    }
  }

  void _onDeliveryMethodChange(
      DeliveryMethodChange event, Emitter<CheckOutState> emit) {
    final deliveryMethod = TextFieldModel.dirty(event.deliveryMethod);

    final List<CartItem> cartItems = state.cartItems.toList();
    double deliveryFee = 0;

    // double discount = 0;
    if (event.deliveryMethod.toLowerCase() == 'pickup') {
      // discount = (state.selectedCustomer?.allowedDiscount ?? 0) +
      //     (state.selectedCustomer?.pickupDiscount ?? 0);
      deliveryFee = 0;
    } else {
      // discount = (state.selectedCustomer?.allowedDiscount ?? 0);
      deliveryFee = state.selectedAddress?.deliveryFee ?? 0;
    }

    // for (final cartItem in cartItems) {
    //   double gross = cartItem.quantity * cartItem.unitPrice;
    //   cartItem.discprcnt = discount;
    //   var disc =
    //       double.parse(((cartItem.discprcnt ?? 0) / 100).toStringAsFixed(2));
    //   double discAmount = double.parse((gross * disc).toStringAsFixed(2));
    //   cartItem.discAmount = discAmount;
    //   cartItem.total = double.parse((gross - discAmount).toStringAsFixed(2));
    // }
    emit(
      state.copyWith(
        deliveryMethod: deliveryMethod,
        // cartItems: cartItems,
        deliveryFee: TextFieldModel.dirty(deliveryFee.toString()),
        status: Formz.validate([
          state.custCode,
          deliveryMethod,
          state.deliveryDate,
          state.paymentMethod,
          state.salesTypeCode,
        ]),
      ),
    );

    add(CartItemsUpdated(cartItems));
  }

  void _onPaymentMethodChange(
      PaymentMethodChange event, Emitter<CheckOutState> emit) {
    final paymentMethod = TextFieldModel.dirty(event.paymentMethod);
    emit(
      state.copyWith(
        paymentMethod: paymentMethod,
        status: Formz.validate([
          paymentMethod,
          state.deliveryMethod,
          state.deliveryDate,
          state.salesTypeCode,
        ]),
      ),
    );
  }

  void _onSalesTypeCodeChange(
      SalesTypeCodeChange event, Emitter<CheckOutState> emit) {
    final salesTypeCode = TextFieldModel.dirty(event.salesTypeCode);
    emit(
      state.copyWith(
        salesTypeCode: salesTypeCode,
        status: Formz.validate(
          [
            state.custCode,
            salesTypeCode,
            state.paymentMethod,
            state.deliveryMethod,
            state.deliveryDate,
          ],
        ),
      ),
    );
  }

  void _onDiscTypeCodeChange(
      DiscTypeCodeChange event, Emitter<CheckOutState> emit) {
    final discTypeCode = TextFieldModel.dirty(event.discType);
    emit(
      state.copyWith(
        discTypeCode: discTypeCode,
        status: Formz.validate([
          state.custCode,
          state.salesTypeCode,
          state.paymentMethod,
          state.deliveryMethod,
          state.deliveryDate,
        ]),
      ),
    );
  }

  void _onDeliveryFeeAdded(
      DeliveryFeeAdded event, Emitter<CheckOutState> emit) {
    final deliveryFee =
        TextFieldModel.dirty(event.deliveryFee.toStringAsFixed(2));
    emit(
      state.copyWith(
        deliveryFee: deliveryFee,
        status: Formz.validate([
          state.custCode,
          state.salesTypeCode,
          state.paymentMethod,
          state.deliveryMethod,
          state.deliveryDate,
        ]),
      ),
    );
  }

  void _onOtherFeeAdded(OtherFeeAdded event, Emitter<CheckOutState> emit) {
    final otherFee = TextFieldModel.dirty(event.otherFee.toStringAsFixed(2));
    emit(
      state.copyWith(
        otherFee: otherFee,
        status: Formz.validate([
          state.custCode,
          state.salesTypeCode,
          state.paymentMethod,
          state.deliveryMethod,
          state.deliveryDate,
        ]),
      ),
    );
  }

  void _onDeleteItemInCart(
      DeleteItemInCart event, Emitter<CheckOutState> emit) {
    List<Map<String, dynamic>> items = [];

    // Make a copy of state cart items.
    for (var item in state.cartItems) {
      Map<String, dynamic> data = {
        "id": item.id,
        "item_code": item.itemCode,
        "uom": item.uom,
        "quantity": item.quantity,
        "unit_price": item.unitPrice,
        "disc_amount": item.discAmount,
        "discprcnt": item.discprcnt,
        "total": item.total,
      };
      items.add(data);
    }

    final List<CartItem> cartItems = List<CartItem>.from(
      items.map((e) {
        return CartItem.fromJson(e);
      }).toList(),
    );

    int index = cartItems.indexWhere((e) => e.id == event.cartItem.id);
    cartItems.removeAt(index);

    // Remove Item In Cart
    _cartRepo.removeByProductId(event.cartItem.id);
    add(CartItemsUpdated(cartItems));
  }

  void _onClearItemInCart(ClearItemInCart event, Emitter<CheckOutState> emit) {
    _cartRepo.clearCart();

    add(CartItemsUpdated(List<CartItem>.from([])));
  }

  void _onOpenCartScreen(OpenCartScreen event, Emitter<CheckOutState> emit) {
    final selectedCustomer = event.selectedCustomer;
    final selectedAddress = event.selectedAddress;

    final shippingAddress = """${selectedAddress?.streetAddress ?? ''}
${selectedAddress?.brgy == null ? '' : 'Brgy. ${selectedAddress?.brgy ?? ''}'}
${selectedAddress?.cityMunicipality ?? ''} """;

    final custCode = TextFieldModel.dirty(selectedCustomer?.code ?? "");
    final address = TextFieldModel.dirty(shippingAddress);
    List<Map<String, dynamic>> items = [];

    for (var item in _cartRepo.cartItems) {
      Map<String, dynamic> data = {
        "id": item.id,
        "item_code": item.itemCode,
        "uom": item.uom,
        "quantity": item.quantity,
        "unit_price": item.unitPrice,
        "disc_amount": item.discAmount,
        "discprcnt": item.discprcnt,
        "total": item.total,
      };
      items.add(data);
    }

    final List<CartItem> cartItems = List<CartItem>.from(items.map((e) {
      return CartItem.fromJson(e);
    }).toList());

    emit(
      state.copyWith(
        selectedCustomer: selectedCustomer,
        selectedAddress: selectedAddress,
        address: address,
        custCode: custCode,
        status: Formz.validate([
          custCode,
          state.salesTypeCode,
          state.paymentMethod,
          state.deliveryMethod,
          state.deliveryDate,
        ]),
      ),
    );
    add(CartItemsUpdated(cartItems));
  }

  void _onCheckOut(ProceedCheckOut event, Emitter<CheckOutState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    CheckOutModel checkOutModel = CheckOutModel(
      transdate: DateTime.now(),
      deliveryDate: DateTime.parse(state.deliveryDate.value),
      custCode: state.custCode.value,
      address: state.address.value,
      paymentMethod: state.paymentMethod.value,
      deliveryMethod: state.deliveryMethod.value,
      salestype: state.salesTypeCode.value,
      delfee: double.parse(state.deliveryFee.value.isNotEmpty
          ? state.deliveryFee.value
          : '0.00'),
      otherfee: double.parse(
          state.otherFee.value.isNotEmpty ? state.otherFee.value : '0.00'),
      disctype: state.discTypeCode.value,
      remarks: state.remarks.value,
      contactNumber: state.selectedCustomer?.contactNumber ?? '',
      rows: state.cartItems.map((e) => e.toJson()).toList(),
    );
    try {
      String message = await _orderRepo.postNewOrder(checkOutModel.toJson());
      emit(
        state.copyWith(
          message: TextFieldModel.dirty(message),
          status: FormzStatus.submissionSuccess,
        ),
      );
      _cartRepo.clearCart();
      emit(
        state.copyWith(
          status: FormzStatus.pure,
          custCode: const TextFieldModel.pure(),
          deliveryDate: const TextFieldModel.pure(),
          deliveryMethod: const TextFieldModel.pure(),
          paymentMethod: const TextFieldModel.pure(),
          salesTypeCode: const TextFieldModel.pure(),
          discTypeCode: const TextFieldModel.pure(),
          remarks: const TextFieldModel.pure(),
          address: const TextFieldModel.pure(),
          deliveryFee: const TextFieldModel.pure(),
          otherFee: const TextFieldModel.pure(),
          selectedCustomer: null,
          selectedAddress: null,
          cartItems: const [],
          message: const TextFieldModel.pure(),
        ),
      );
    } on HttpException catch (e) {
      emit(
        state.copyWith(
          message: TextFieldModel.dirty(e.message),
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _prodSelectionBlocSubscription.cancel();
    return super.close();
  }
}
