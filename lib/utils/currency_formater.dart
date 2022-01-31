import 'package:intl/intl.dart';

String formatStringToDecimal(var amount, {bool hasCurrency = false}) {
  String currency = '₱';
  var newValue = '';
  final f =
      NumberFormat.currency(locale: 'en_US', decimalDigits: 2, symbol: '');
  var num = double.parse(amount.replaceAll(',', ''));
  if (hasCurrency) {
    newValue = currency + f.format(num).trim();
  } else {
    newValue = f.format(num).trim();
  }

  return newValue;
}
