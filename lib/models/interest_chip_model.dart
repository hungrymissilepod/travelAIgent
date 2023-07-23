import 'package:json_annotation/json_annotation.dart';

part 'interest_chip_model.g.dart';

@JsonSerializable()
class InterestChip {
  final String label;
  final String emoji;

  InterestChip(this.label, this.emoji);

  factory InterestChip.fromJson(Map<String, dynamic> json) =>
      _$InterestChipFromJson(json);

  Map<String, dynamic> toJson() => _$InterestChipToJson(this);
}
