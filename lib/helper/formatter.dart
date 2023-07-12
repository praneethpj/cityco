import 'package:intl/intl.dart';

class Formatter {
  static String priceFormatter(num price) {
    return price.toStringAsFixed(2);
  }

  static String dateFormatter(DateTime date) {
    return DateFormat("yyyy-MM-dd").format(date);
  }
}
