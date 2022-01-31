import './repositories.dart';

class AppRepo {
  static final authRepository = AuthRepository();
  static final productsRepository = ProductsRepo();
  static final cartRepository = CartRepo();
  static final customerRepository = CustomerRepo();
  static final salesTypeRepository = SalesTypeRepo();
  static final discTypeRepository = DiscountTypeRepo();
  static final orderRepository = OrderRepo();
  static final customerTypeRepository = CustomerTypeRepo();
  static final checkOutRepository = CheckOutRepo();
}
