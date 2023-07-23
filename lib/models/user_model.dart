import 'package:json_annotation/json_annotation.dart';
import 'package:travel_aigent/models/plan_model.dart';

part 'user_model.g.dart';

enum MeasurementSystem { metric, imperial }

@JsonSerializable()
class User {
  final String name;
  final MeasurementSystem measurementSystem;
  final List<Plan> plans;

  User(
    this.name,
    this.measurementSystem,
    this.plans,
  );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
