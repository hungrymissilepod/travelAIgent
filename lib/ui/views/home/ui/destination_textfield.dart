import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_aigent/models/airport_data_model.dart';
import 'package:travel_aigent/models/airport_model.dart';
import 'package:travel_aigent/models/city_model.dart';
import 'package:travel_aigent/models/country_model.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/home/ui/autocomplete_field.dart';

class DestinationTextfield extends StatelessWidget {
  const DestinationTextfield({
    super.key,
    required this.suggestions,
    required this.focusNode,
    required this.controller,
    required this.hintText,
    required this.icon,
  });

  final AirportData suggestions;
  final FocusNode focusNode;
  final TextEditingController controller;
  final String hintText;
  final IconData icon;

  /// TODO: finalise this UI
  List<TextSpan> highlightOccurrences(String source, String query) {
    if (query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
      return [TextSpan(text: source)];
    }
    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    int lastMatchEnd = 0;

    final List<TextSpan> children = [];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));
      }

      children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ));

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }

      lastMatchEnd = match.end;
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        height: homePickerHeight,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: textFieldDecoration(focusNode),
        child: Row(
          children: <Widget>[
            FaIcon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 16,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: AutocompleteField(
                suggestions: suggestions,
                focusNode: focusNode,
                controller: controller,
                cursorColor: Theme.of(context).colorScheme.secondary,
                inputTextStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14),
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                ),
                suggestionBackgroundColor: Colors.white,
                suggestionBuilder: (Object? data) {
                  if (data is Country || data is Airport || data is City) {
                    String label = '';
                    if (data is Country) {
                      label = data.country;
                    } else if (data is City) {
                      label = data.city;
                    } else if (data is Airport) {
                      label = data.airportName;
                    }

                    String label2 = '';
                    if (data is Country) {
                      label2 = data.code;
                    } else if (data is City) {
                      label2 = 'Any';
                    } else if (data is Airport) {
                      label2 = data.airportIataCode;
                    }

                    IconData? icon;
                    if (data is Country) {
                      icon = FontAwesomeIcons.solidFlag;
                    } else if (data is City) {
                      icon = FontAwesomeIcons.locationDot;
                    } else if (data is Airport) {
                      icon = FontAwesomeIcons.planeDeparture;
                    }
                    String label3 = '';
                    if (data is Country) {
                      label3 = data.country;
                    } else if (data is City) {
                      label3 = data.country;
                    } else if (data is Airport) {
                      label3 = data.countryName;
                    }
                    return Container(
                      padding: const EdgeInsets.fromLTRB(5, 15, 10, 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          FaIcon(
                            icon,
                            color: Theme.of(context).primaryColor,
                            size: 18,
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text.rich(
                                        TextSpan(
                                          children: highlightOccurrences(label, controller.text),
                                          style: const TextStyle(color: Colors.grey),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text.rich(
                                      TextSpan(
                                        children: highlightOccurrences('(${label2})', controller.text),
                                        style: const TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text.rich(
                                  TextSpan(
                                    children: highlightOccurrences(label3, controller.text),
                                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  /// TODO: this should return an empty sized box once DEV has finished
                  return Text('failed!');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
