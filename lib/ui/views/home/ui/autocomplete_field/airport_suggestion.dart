import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_aigent/models/airport_model.dart';
import 'package:travel_aigent/ui/views/home/ui/auto_complete_suggestion.dart';

class AirportSuggestion extends StatelessWidget {
  const AirportSuggestion({
    super.key,
    required this.airport,
    required this.input,
  });

  final Airport airport;
  final String input;

  @override
  Widget build(BuildContext context) {
    return AutoCompleteSuggestion(
      icon: FontAwesomeIcons.plane,
      title: highlightOccurrences(airport.airportName, input),
      code: highlightOccurrences('(${airport.airportIataCode})', input),
      subtitle: highlightOccurrences(airport.countryName, input),
    );
  }
}
