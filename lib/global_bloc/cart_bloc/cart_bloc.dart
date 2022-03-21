import 'package:delicious_ordering_app/data/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<ItemAddedInCart>(onItemAddedInCart);
    on<ClearCart>(onClearCart);
    on<RemoveItemFromCart>(onRemoveFromCart);
  }

  void onItemAddedInCart(ItemAddedInCart event, Emitter<CartState> emit) {
    List<CartItem> _stateCartItems = state.cartItems;

    _stateCartItems.add(event.cartItem);

    emit(state.copyWith(cartItems: _stateCartItems));
  }

  void onClearCart(ClearCart event, Emitter<CartState> emit) async {
    emit(state.copyWith(cartItems: []));
  }

  void onRemoveFromCart(RemoveItemFromCart event, Emitter<CartState> emit) {
    List<CartItem> _stateCartItems = state.cartItems;
    int index = _stateCartItems.indexWhere((e) => e.id == event.cartItem.id);
    _stateCartItems.removeAt(index);

    emit(state.copyWith(cartItems: _stateCartItems));
  }
}
