import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:travel_aigent/models/plan_model.dart';

part 'who_am_i_model.g.dart';

enum MeasurementSystem { metric, imperial }

@JsonSerializable()
class WhoAmI {
  String? name;
  MeasurementSystem measurementSystem;
  List<Plan> plans;

  WhoAmI({
    this.name,
    this.measurementSystem = MeasurementSystem.metric,
    required this.plans,
  });

  factory WhoAmI.fromJson(Map<String, dynamic> json) => _$WhoAmIFromJson(json);

  Map<String, dynamic> toJson() => _$WhoAmIToJson(this);

  factory WhoAmI.empty() {
    return WhoAmI(name: '', plans: <Plan>[]);
  }

  Map<String, dynamic> userCollectionJson(String userId) {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'measurementSystem': describeEnum(measurementSystem),
    };
  }

  Map<String, dynamic> plansCollectionJson(String userId) {
    return <String, dynamic>{
      'userId': userId,
      'plans': plans.map((e) => e.toJson()).toList(),
    };
  }

  String? firstName() {
    if (name == null) {
      return '';
    }
    List<String> list = name!.split(' ');
    return list[0];
  }

  String firstChar() {
    if (name == null) {
      return '';
    } else if (name!.isEmpty) {
      return '';
    }
    return name?[0] ?? '';
  }
}
