import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/views/preferences/preferences_viewmodel.dart';

enum PreferenceListTileType { radio, checkbox }

class PreferenceListTile extends ViewModelWidget<PreferencesViewModel> {
  const PreferenceListTile({
    super.key,
    required this.title,
    required this.description,
    required this.emoji,
    required this.onChanged,
    required this.type,
    this.radioGroupValue = '',
    this.checkBoxValue = false,
  });

  final String title;
  final String description;
  final String emoji;

  final Function(String) onChanged;
  final PreferenceListTileType type;
  final String? radioGroupValue;
  final bool? checkBoxValue;

  @override
  Widget build(BuildContext context, PreferencesViewModel viewModel) {
    return InkWell(
      onTap: () {
        onChanged(title);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              emoji,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              width: 14,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            type == PreferenceListTileType.radio
                ? Radio(
                    value: title,
                    groupValue: viewModel.holidayType,
                    onChanged: (Object? value) {
                      onChanged(title);
                    },
                  )
                : Checkbox(
                    value: checkBoxValue,
                    onChanged: (bool? newValue) {
                      onChanged(title);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
