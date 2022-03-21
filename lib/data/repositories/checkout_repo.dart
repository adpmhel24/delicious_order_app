import '../models/models.dart';

class CheckOutRepo {
  late CheckOutModel checkoutData;

  ///Singleton factory
  static final CheckOutRepo _instance = CheckOutRepo._internal();

  factory CheckOutRepo() {
    return _instance;
  }

  CheckOutRepo._internal();
}
