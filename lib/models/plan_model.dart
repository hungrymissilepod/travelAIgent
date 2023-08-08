import 'package:travel_aigent/models/attraction_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:travel_aigent/models/destination_model.dart';
import 'package:travel_aigent/models/preferences_model.dart';

part 'plan_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Plan {
  final String city;
  final String country;
  final String description;
  final String temperature;
  final int distance;

  /// Language spoken in [country]
  final String language;

  List<Attraction> attractions;
  Destination? destination;
  Preferences? preferences;

  /// Image of the [city]
  String? imageUrl;

  /// Name the user gives this plan when they save it
  String? name;

  Plan(
    this.city,
    this.country,
    this.description,
    this.temperature,
    this.distance,
    this.language,
    this.attractions,
    this.destination,
    this.preferences, {
    this.imageUrl,
    this.name,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

  Map<String, dynamic> toJson() => _$PlanToJson(this);
}
