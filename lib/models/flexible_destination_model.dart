import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flexible_destination_model.g.dart';

const String anywhere = 'Anywhere';

@JsonSerializable()
class FlexibleDestination extends Equatable {
  final String name;

  const FlexibleDestination(this.name);

  factory FlexibleDestination.fromJson(Map<String, dynamic> json) => _$FlexibleDestinationFromJson(json);

  Map<String, dynamic> toJson() => _$FlexibleDestinationToJson(this);

  IconData icon() {
    switch (name) {
      case anywhere:
        return FontAwesomeIcons.earthAmericas;
      default:
        return FontAwesomeIcons.locationDot;
    }
  }

  @override
  List<Object?> get props => <Object?>[name];
}
