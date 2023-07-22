import 'package:travel_aigent/models/attraction_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'plan_model.g.dart';

@JsonSerializable()
class Plan {
  final String city;
  final String country;
  final String description;
  final String temperature;
  final int distance;
  final String language;
  final List<Attraction> attractions;

  /// Image of the [city]
  String? imageUrl;

  Plan(
    this.city,
    this.country,
    this.description,
    this.temperature,
    this.distance,
    this.language,
    this.attractions, {
    this.imageUrl,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

  Map<String, dynamic> toJson() => _$PlanToJson(this);
}
