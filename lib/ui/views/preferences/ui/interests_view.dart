import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/misc/constants.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/preferences/preferences_viewmodel.dart';
import 'package:travel_aigent/ui/views/preferences/ui/preferences_list_tile.dart';

class InterestsView extends ViewModelWidget<PreferencesViewModel> {
  const InterestsView({super.key});

  @override
  Widget build(BuildContext context, PreferencesViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: scaffoldHorizontalPadding, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'What are your interests?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                viewModel.getInterestTypePromptCount(),
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ],
          ),
        ),

        /// TODO: possible improvements. Could disable all other checkboxes when max boxes are selected

        Expanded(
          child: Scrollbar(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: scaffoldHorizontalPadding),
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                children: <Widget>[
                  Column(
                    children: interestChips.map((e) {
                      return PreferenceListTile(
                        type: PreferenceListTileType.checkbox,
                        title: e.label,
                        description: 'Description text here...',
                        emoji: e.emoji,
                        checkBoxValue: viewModel.isInterestSelected(e.label),
                        onChanged: (String s) {
                          viewModel.addInterest(s);
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
