import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';
import '/data/repositories/repositories.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepo _cartRepo = AppRepo.cartRepository;
  CartBloc() : super(CartLoading()) {
    on<LoadCart>(onLoadCart);
    on<ClearCart>(onClearCart);
    on<RemoveItemFromCart>(onRemoveFromCart);
    on<UpdateDeliveryFee>(onUpdateDelfee);
    on<UpdateOtherFee>(onUpdateOtherFee);
  }

  void onLoadCart(LoadCart event, Emitter<CartState> emit) {
    emit(CartLoading());
    try {
      if (_cartRepo.cartItemsCount > 0) {
        emit(CartLoaded(_cartRepo.cartItems));
      } else {
        emit(EmptyCart());
      }
    } on HttpException catch (e) {
      emit(CartError(e.message));
    }
  }

  void onClearCart(ClearCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    await _cartRepo.clearCart();
    emit(EmptyCart());
  }

  void onRemoveFromCart(RemoveItemFromCart event, Emitter<CartState> emit) {
    emit(CartLoading());
    _cartRepo.deleteFromCart(event.cartItem);
    if (_cartRepo.cartItems.isEmpty) {
      emit(EmptyCart());
    }
    emit(CartLoaded(_cartRepo.cartItems));
  }

  void onUpdateDelfee(UpdateDeliveryFee event, Emitter<CartState> emit) {
    _cartRepo.changeDelfee(event.delfee);
    emit(CartUpdateDelFeeState(_cartRepo.delfee.toString()));
  }

  void onUpdateOtherFee(
    UpdateOtherFee event,
    Emitter<CartState> emit,
  ) {
    _cartRepo.changeOtherFee(event.otherFee);
    emit(CartUpdateTenderedAmountState(_cartRepo.otherfee.toString()));
  }
}
