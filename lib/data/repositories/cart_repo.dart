import '../repositories/repositories.dart';
import '../models/models.dart';

class CartRepo {
  List<CartItem> _cartItems = [];
  double _discount = 0;
  double _delfee = 0;
  double _tenderedAmnt = 0;

  final CheckOutRepo _checkOutRepo = AppRepo.checkOutRepository;

  // Add To Cart
  Future<void> addToCart(CartItem cartItem) async {
    await Future.delayed(const Duration(milliseconds: 300));
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

  double get discount => _discount;
  double get delfee => _delfee;
  double get tenderedAmnt => _tenderedAmnt;

  double get totalCart {
    double totalAmount = 0;
    for (var e in _cartItems) {
      totalAmount += e.total;
    }
    return totalAmount;
  }

  double get changeAmount {
    double change;
    change = _tenderedAmnt - (totalCart + _delfee - discount);
    if (change < 0) {
      return 0;
    }
    return change;
  }

  void changeDiscount(double discount) {
    _discount = discount;
  }

  void changeTenderedAmnt(double tenderedAmnt) {
    _tenderedAmnt = tenderedAmnt;
    _checkOutRepo.checkoutData.tenderamt = tenderedAmnt;
  }

  void changeDelfee(double delfee) {
    _delfee = delfee;
    _checkOutRepo.checkoutData.delfee = delfee;
  }

  void toggleIsSelected(int index) {
    _cartItems[index].isSelected = !_cartItems[index].isSelected;
  }

  void toggleSelectAllItems() {
    _cartItems = _cartItems.map((cartItem) {
      var item = cartItem;
      item.isSelected = !item.isSelected;
      return item;
    }).toList();
  }

  double get grantTotal {
    // double totalAmount = 0;
    // _cartItems.forEach((e) => totalAmount += e.total);
    return totalCart + _delfee - discount;
  }

  int get cartItemsCount => _cartItems.length;

  // Delete Item From The Cart
  void deleteFromCart(CartItem cartItem) {
    int index = _cartItems.indexWhere(
        (e) => e.id == cartItem.id && e.unitPrice == cartItem.unitPrice);
    _cartItems.removeAt(index);
  }

  void removeItemIfSelected() {
    _cartItems.removeWhere((cartItem) => cartItem.isSelected);
    if (_cartItems.isEmpty) {
      _cartItems.clear();
      _delfee = 0;
      _tenderedAmnt = 0;
      _checkOutRepo.checkoutData = CheckOutModel();
    }
  }

  // Clear Cart
  Future<void> clearCart() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _cartItems.clear();
    _delfee = 0;
    _tenderedAmnt = 0;
    _checkOutRepo.checkoutData = CheckOutModel();
  }

  ///Singleton factory
  static final CartRepo _instance = CartRepo._internal();

  factory CartRepo() {
    return _instance;
  }

  CartRepo._internal();
}
