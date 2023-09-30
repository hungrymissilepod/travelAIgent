import 'package:json_annotation/json_annotation.dart';
import 'package:travel_aigent/models/duck_web_image_model.dart';

part 'attraction_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Attraction {
  String name;
  String description;
  final String type;
  double? rating;
  String? formattedAddress;
  String? placeId;
  List<DuckWebImage>? images = [];

  Attraction(
    this.name,
    this.description,
    this.type,
    this.rating, {
    this.images,
    this.placeId,
    this.formattedAddress,
  });

  factory Attraction.fromJson(Map<String, dynamic> json) => _$AttractionFromJson(json);

  Map<String, dynamic> toJson() => _$AttractionToJson(this);
}
