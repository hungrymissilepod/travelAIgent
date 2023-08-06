import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/misc/constants.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/preferences/preferences_viewmodel.dart';

class HolidayTypeView extends ViewModelWidget<PreferencesViewModel> {
  const HolidayTypeView({super.key});

  @override
  Widget build(BuildContext context, PreferencesViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(scaffoldHorizontalPadding, 10, scaffoldHorizontalPadding, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              const Text(
                'What type of holiday are you dreaming of?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                viewModel.getHolidayTypePromptCount(),
                style: TextStyle(color: Colors.grey.shade700),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          Expanded(
            child: Scrollbar(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  children: holidayTypeChips.map((e) {
                    return LabeledCheckbox(
                      title: e.label,
                      description: 'Description text here...',
                      emoji: e.emoji,
                      value: viewModel.isHolidayTypeSelected(e.label),
                      onChanged: (bool b) {
                        viewModel.setHolidayType(e.label);
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    super.key,
    required this.title,
    required this.description,
    required this.emoji,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String description;
  final String emoji;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
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
            Checkbox(
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
