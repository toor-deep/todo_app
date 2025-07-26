import 'package:intl/intl.dart';

extension FormattedDate on DateTime {
  String toFormattedString() {
    return DateFormat('EEE, dd MMM yyyy').format(this);
  }
}
