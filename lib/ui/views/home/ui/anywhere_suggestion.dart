import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_aigent/models/airport_data_model.dart';
import 'package:travel_aigent/ui/views/home/ui/auto_complete_suggestion.dart';

class AnywhereSuggestion extends StatelessWidget {
  const AnywhereSuggestion({
    super.key,
    required this.input,
  });

  final String input;

  @override
  Widget build(BuildContext context) {
    return AutoCompleteSuggestion(
      icon: FontAwesomeIcons.earthAmericas,
      title: highlightOccurrences(anywhere, input),
      code: const <TextSpan>[],
      subtitle: highlightOccurrences('Earth', input),
    );
  }
}
