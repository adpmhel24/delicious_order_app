import '../models/models.dart';

class CartRepo {
  final List<CartItem> _cartItems = [];

  // Add To Cart
  void addToCart(CartItem cartItem) {
    var index = _cartItems.indexWhere((element) =>
        element.id == cartItem.id && element.unitPrice == cartItem.unitPrice);

    if (index >= 0) {
      _cartItems[index].quantity += cartItem.quantity;
      _cartItems[index].total += cartItem.total;
    } else {
      _cartItems.add(cartItem);
    }
  }

  List<CartItem> get cartItems => [..._cartItems];

  double get totalCart {
    double totalAmount = 0;
    for (var e in _cartItems) {
      totalAmount += e.total;
    }
    return totalAmount;
  }

  double get totalDiscountAmount {
    double totalDisc = 0;
    for (var item in _cartItems) {
      totalDisc += item.discAmount!;
    }
    return totalDisc;
  }

  int get cartItemsCount => _cartItems.length;

  // Delete Item From The Cart
  void deleteFromCart(CartItem cartItem) {
    int index = _cartItems.indexWhere((e) => e.id == cartItem.id);
    _cartItems.removeAt(index);
  }

  void removeByProductId(int id) {
    int index = _cartItems.indexWhere((e) => e.id == id);
    _cartItems.removeAt(index);
  }

  // Clear Cart
  void clearCart() {
    _cartItems.clear();
  }

  ///Singleton factory
  static final CartRepo _instance = CartRepo._internal();

  factory CartRepo() {
    return _instance;
  }

  CartRepo._internal();
}
