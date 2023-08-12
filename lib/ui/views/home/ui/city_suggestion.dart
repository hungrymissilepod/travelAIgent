import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_aigent/models/city_model.dart';
import 'package:travel_aigent/ui/views/home/ui/auto_complete_suggestion.dart';

class CitySuggestion extends StatelessWidget {
  const CitySuggestion({
    super.key,
    required this.city,
    required this.input,
  });

  final City city;
  final String input;

  @override
  Widget build(BuildContext context) {
    return AutoCompleteSuggestion(
      icon: FontAwesomeIcons.locationDot,
      title: highlightOccurrences(city.city, input),
      code: highlightOccurrences('(Any)', input),
      subtitle: highlightOccurrences(city.country, input),
    );
  }
}
