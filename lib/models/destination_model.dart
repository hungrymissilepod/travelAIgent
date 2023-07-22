import 'package:travel_aigent/misc/date_time_formatter.dart';

class DestinationModel {
  final String from;
  final String to;
  final DateTime fromDate;
  final DateTime toDate;
  final int travellers;

  DestinationModel(
    this.from,
    this.to,
    this.fromDate,
    this.toDate,
    this.travellers,
  );

  @override
  String toString() =>
      'from: $from - to: $to - fromDate: ${fromDate.datePickerFormat()} - toDate: ${toDate.datePickerFormat()} - travellers: $travellers';
}
