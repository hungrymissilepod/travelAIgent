import 'package:flutter/material.dart';
import 'package:travel_aigent/models/flexible_destination_model.dart';
import 'package:travel_aigent/ui/views/home/ui/auto_complete_suggestion.dart';

class FlexibleDestinationSuggestion extends StatelessWidget {
  const FlexibleDestinationSuggestion({
    super.key,
    required this.destination,
    required this.input,
  });

  final FlexibleDestination destination;
  final String input;

  @override
  Widget build(BuildContext context) {
    return AutoCompleteSuggestion(
      icon: destination.icon(),
      title: highlightOccurrences(destination.name, input),
      code: const <TextSpan>[],
      subtitle: highlightOccurrences('Earth', input),
    );
  }
}
