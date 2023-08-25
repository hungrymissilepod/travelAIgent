import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/models/airport_data_model.dart';
import 'package:travel_aigent/models/airport_model.dart';
import 'package:travel_aigent/models/city_model.dart';
import 'package:travel_aigent/models/country_model.dart';
import 'package:travel_aigent/models/flexible_destination_model.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/home/home_viewmodel.dart';
import 'package:travel_aigent/ui/views/home/ui/anywhere_suggestion.dart';
import 'package:travel_aigent/ui/views/home/ui/autocomplete_field/airport_suggestion.dart';
import 'package:travel_aigent/ui/views/home/ui/autocomplete_field/autocomplete_field.dart';
import 'package:travel_aigent/ui/views/home/ui/autocomplete_field/country_suggestion.dart';
import 'package:travel_aigent/ui/views/home/ui/city_suggestion.dart';

class DestinationTextfield extends ViewModelWidget<HomeViewModel> {
  const DestinationTextfield({
    super.key,
    required this.suggestions,
    required this.focusNode,
    required this.controller,
    required this.icon,
    required this.unfocusedHintText,
    required this.hasError,
    required this.onChanged,
    this.showAnywhereAsDefaultSuggestion = false,
  });

  final AirportData suggestions;
  final FocusNode focusNode;
  final TextEditingController controller;
  final IconData icon;
  final String unfocusedHintText;
  final bool hasError;
  final Function(String) onChanged;
  final bool showAnywhereAsDefaultSuggestion;

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: scaffoldHorizontalPadding),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: textFieldContainerPadding),
          decoration: textFieldDecoration(focusNode, hasError),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: textFieldIconSizedBoxWidth,
                child: FaIcon(
                  icon,
                  color: Theme.of(context).primaryColor,
                  size: textFieldIconSize,
                ),
              ),
              const SizedBox(width: textFieldIconSpacer),
              Flexible(
                child: AutoCompleteField(
                  suggestions: suggestions,
                  onChanged: (String value) => onChanged(value),
                  focusNode: focusNode,
                  controller: controller,
                  iconOffset: textFieldIconSizedBoxWidth + textFieldIconSpacer + 8,
                  containerPadding: textFieldContainerPadding,
                  unfocusedHintText: unfocusedHintText,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  inputTextStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14),
                  showAnywhereAsDefaultSuggestion: showAnywhereAsDefaultSuggestion,
                  suggestionBackgroundColor: Colors.white,
                  suggestionBuilder: (Object? data) {
                    if (data is Country) {
                      return CountrySuggestion(country: data, input: controller.text);
                    }
                    if (data is Airport) {
                      return AirportSuggestion(airport: data, input: controller.text);
                    }
                    if (data is City) {
                      return CitySuggestion(city: data, input: controller.text);
                    }
                    if (data is FlexibleDestination) {
                      return FlexibleDestinationSuggestion(destination: data, input: controller.text);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
