import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_aigent/models/country_model.dart';
import 'package:travel_aigent/ui/views/home/ui/auto_complete_suggestion.dart';

class CountrySuggestion extends StatelessWidget {
  const CountrySuggestion({
    super.key,
    required this.country,
    required this.input,
  });

  final Country country;
  final String input;

  @override
  Widget build(BuildContext context) {
    return AutoCompleteSuggestion(
      icon: FontAwesomeIcons.solidFlag,
      title: highlightOccurrences(country.country, input),
      code: highlightOccurrences('(${country.code})', input),
      subtitle: highlightOccurrences(country.country, input),
    );
  }
}
