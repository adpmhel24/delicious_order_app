class UtilValidators {
  static final RegExp _usernameRegExp =
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]");
  static final RegExp _passwordRegExp = RegExp(
    r'^.{4,10}$',
  );

  static final RegExp _phoneNumberRegExp =
      RegExp(r'^(03|05|07|08|09|01[2|6|8|9])+([0-9]{8})$');

  static final RegExp _numberWithDecRegExp = RegExp(r'^(\d*)?(\.\d{1,3})?$');

  static final RegExp _allZeroRegExp = RegExp(r'^0?(\.[0]{1,3})?$');

  static isValidUsername(String username) {
    return _usernameRegExp.hasMatch(username);
  }

  static isValidNumeric(String value) {
    if (value.isEmpty) {
      return false;
    } else if (_allZeroRegExp.hasMatch(value)) {
      return false;
    }
    return _numberWithDecRegExp.hasMatch(value);
  }

  static isVietnamesePhoneNumber(String phoneNumber) {
    return _phoneNumberRegExp.hasMatch(phoneNumber);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  static isValidName(String name) {
    return name.isNotEmpty;
  }

  ///Singleton factory
  static final UtilValidators _instance = UtilValidators._internal();

  factory UtilValidators() {
    return _instance;
  }

  UtilValidators._internal();
}
