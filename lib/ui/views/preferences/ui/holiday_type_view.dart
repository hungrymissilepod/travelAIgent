import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/misc/constants.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/preferences/preferences_viewmodel.dart';
import 'package:travel_aigent/ui/views/preferences/ui/preferences_list_tile.dart';

class HolidayTypeView extends ViewModelWidget<PreferencesViewModel> {
  const HolidayTypeView({super.key});

  @override
  Widget build(BuildContext context, PreferencesViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: scaffoldHorizontalPadding, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'What type of holiday are you dreaming of?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                viewModel.getHolidayTypePromptCount(),
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        Expanded(
          child: Scrollbar(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  horizontal: scaffoldHorizontalPadding),
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                children: <Widget>[
                  Column(
                    children: holidayTypeChips.map((e) {
                      return PreferenceListTile(
                        title: e.label,
                        description: e.description ?? '',
                        emoji: e.emoji,
                        checkBoxValue: viewModel.isHolidayTypeSelected(e.label),
                        onChanged: (String s) {
                          viewModel.setHolidayType(s);
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
