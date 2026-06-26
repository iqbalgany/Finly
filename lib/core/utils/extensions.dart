import 'package:intl/intl.dart';

extension CurrencyFormatter on num {
  String toRupiah() {
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(this);
  }
}
