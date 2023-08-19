import 'package:json_annotation/json_annotation.dart';
import 'package:travel_aigent/models/duck_web_image_model.dart';

part 'attraction_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Attraction {
  final String name;
  final String description;
  final String type;
  final double rating;
  List<DuckWebImage>? images = [];

  Attraction(
    this.name,
    this.description,
    this.type,
    this.rating, {
    this.images,
  });

  factory Attraction.fromJson(Map<String, dynamic> json) =>
      _$AttractionFromJson(json);

  Map<String, dynamic> toJson() => _$AttractionToJson(this);
}
