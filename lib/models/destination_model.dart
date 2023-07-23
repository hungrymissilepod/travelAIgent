import 'package:travel_aigent/misc/date_time_formatter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'destination_model.g.dart';

@JsonSerializable()
class Destination {
  final String from;
  final String to;
  final DateTime fromDate;
  final DateTime toDate;
  final int travellers;

  Destination(
    this.from,
    this.to,
    this.fromDate,
    this.toDate,
    this.travellers,
  );

  @override
  String toString() =>
      'from: $from - to: $to - fromDate: ${fromDate.datePickerFormat()} - toDate: ${toDate.datePickerFormat()} - travellers: $travellers';

  factory Destination.fromJson(Map<String, dynamic> json) =>
      _$DestinationFromJson(json);

  Map<String, dynamic> toJson() => _$DestinationToJson(this);
}
