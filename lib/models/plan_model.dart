import 'package:travel_aigent/models/attraction_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'plan_model.g.dart';

@JsonSerializable()
class Plan {
  final String city;
  final List<Attraction> attractions;

  Plan(
    this.city,
    this.attractions,
  );

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

  Map<String, dynamic> toJson() => _$PlanToJson(this);
}
