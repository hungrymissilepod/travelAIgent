import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime {
  String datePickerFormat() {
    return DateFormat('EEE d MMM').format(this);
  }
}
