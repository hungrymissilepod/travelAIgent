import 'package:json_annotation/json_annotation.dart';

part 'attraction_model.g.dart';

@JsonSerializable()
class Attraction {
  final String name;
  final String description;
  final String type;
  final double rating;
  String? imageUrl;

  Attraction(this.name, this.description, this.type, this.rating,
      {this.imageUrl});

  factory Attraction.fromJson(Map<String, dynamic> json) =>
      _$AttractionFromJson(json);

  Map<String, dynamic> toJson() => _$AttractionToJson(this);
}
