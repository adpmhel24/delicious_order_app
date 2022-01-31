import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';
import '/data/repositories/repositories.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepo _cartRepo = AppRepo.cartRepository;
  CartBloc() : super(CartLoading()) {
    on<LoadCart>(onLoadCart);
    on<ClearCart>(onClearCart);
    on<RemoveItemFromCart>(onRemoveFromCart);
    on<UpdateDiscount>(onUpdateDiscount);
    on<UpdateDeliveryFee>(onUpdateDelfee);
    on<UpdateTenderedAmount>(onUpdateTenderedAmnt);

    // on<ToggleIsSelectedCartItem>(onToggleSelectedItem);
    // on<ToggleSelectAllCartItem>(onToggleSelectAllItem);
    // on<RemoveItemIfSelected>(onRemoveItemIfSelected);
  }

  void onLoadCart(LoadCart event, Emitter<CartState> emit) {
    emit(CartLoading());
    try {
      if (_cartRepo.cartItemsCount > 0) {
        emit(CartLoaded(_cartRepo.cartItems));
      } else {
        emit(EmptyCart());
      }
    } on Exception catch (e) {
      emit(CartError(e.toString()));
    }
  }

  void onClearCart(ClearCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    await _cartRepo.clearCart();
    emit(EmptyCart());
  }

  // void onRemoveItemIfSelected(
  //     RemoveItemIfSelected event, Emitter<CartState> emit) {
  //   emit(CartLoading());
  //   _cartRepo.removeItemIfSelected();
  //   if (_cartRepo.cartItems.isEmpty) {
  //     emit(EmptyCart());
  //   }
  //   emit(CartLoaded(_cartRepo.cartItems));
  // }

  void onRemoveFromCart(RemoveItemFromCart event, Emitter<CartState> emit) {
    emit(CartLoading());
    _cartRepo.deleteFromCart(event.cartItem);
    if (_cartRepo.cartItems.isEmpty) {
      emit(EmptyCart());
    }
    emit(CartLoaded(_cartRepo.cartItems));
  }

  void onUpdateDiscount(UpdateDiscount event, Emitter<CartState> emit) {
    _cartRepo.changeDiscount(event.discount);
    emit(CartUpdateDiscountState(_cartRepo.discount.toString()));
  }

  void onUpdateDelfee(UpdateDeliveryFee event, Emitter<CartState> emit) {
    _cartRepo.changeDelfee(event.delfee);
    emit(CartUpdateDelFeeState(_cartRepo.delfee.toString()));
  }

  void onUpdateTenderedAmnt(
    UpdateTenderedAmount event,
    Emitter<CartState> emit,
  ) {
    _cartRepo.changeTenderedAmnt(event.tenderedAmount);
    emit(CartUpdateTenderedAmountState(_cartRepo.tenderedAmnt.toString()));
  }

  // void onToggleSelectedItem(
  //     ToggleIsSelectedCartItem event, Emitter<CartState> emit) {
  //   emit(CartLoading());
  //   _cartRepo.toggleIsSelected(event.index);
  //   emit(CartLoaded(_cartRepo.cartItems));
  // }

  // void onToggleSelectAllItem(
  //     ToggleSelectAllCartItem event, Emitter<CartState> emit) {
  //   emit(CartLoading());
  //   _cartRepo.toggleSelectAllItems();
  //   emit(CartLoaded(_cartRepo.cartItems));
  // }
}
