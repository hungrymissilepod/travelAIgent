import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_aigent/models/airport_data_model.dart';
import 'package:travel_aigent/models/airport_model.dart';
import 'package:travel_aigent/models/city_model.dart';
import 'package:travel_aigent/models/country_model.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/home/ui/autocomplete_field/airport_suggestion.dart';
import 'package:travel_aigent/ui/views/home/ui/autocomplete_field/autocomplete_field.dart';
import 'package:travel_aigent/ui/views/home/ui/autocomplete_field/country_suggestion.dart';
import 'package:travel_aigent/ui/views/home/ui/city_suggestion.dart';

class DestinationTextfield extends StatelessWidget {
  const DestinationTextfield({
    super.key,
    required this.suggestions,
    required this.focusNode,
    required this.controller,
    required this.icon,
  });

  final AirportData suggestions;
  final FocusNode focusNode;
  final TextEditingController controller;
  final IconData icon;

  final double iconSizedBoxWidth = 20;
  final double iconSpacer = 12;
  final double containerPadding = 8;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        height: homePickerHeight,
        padding: EdgeInsets.symmetric(horizontal: containerPadding),
        decoration: textFieldDecoration(focusNode),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: iconSizedBoxWidth,
              child: FaIcon(
                icon,
                color: Theme.of(context).primaryColor,
                size: 16,
              ),
            ),
            SizedBox(width: iconSpacer),
            Flexible(
              child: AutoCompleteField(
                suggestions: suggestions,
                focusNode: focusNode,
                controller: controller,
                iconOffset: iconSizedBoxWidth + iconSpacer + 8,
                containerPadding: containerPadding,
                cursorColor: Theme.of(context).colorScheme.secondary,
                inputTextStyle: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 14),
                suggestionBackgroundColor: Colors.white,
                suggestionBuilder: (Object? data) {
                  if (data is Country) {
                    return CountrySuggestion(
                        country: data, input: controller.text);
                  }
                  if (data is Airport) {
                    return AirportSuggestion(
                        airport: data, input: controller.text);
                  }
                  if (data is City) {
                    return CitySuggestion(city: data, input: controller.text);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
