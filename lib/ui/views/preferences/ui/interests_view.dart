import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/misc/constants.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/preferences/preferences_viewmodel.dart';
import 'package:travel_aigent/ui/views/preferences/ui/holiday_type_view.dart';

class InterestsView extends ViewModelWidget<PreferencesViewModel> {
  const InterestsView({super.key});

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
                'What are you interested in doing while on holiday?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                viewModel.getInterestTypePromptCount(),
                style: TextStyle(color: Colors.grey.shade700),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),

          /// TODO: possible improvements. Could disable all other checkboxes when max boxes are selected

          Expanded(
            child: Scrollbar(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  children: interestChips.map((e) {
                    return LabeledCheckbox(
                      title: e.label,
                      description: 'Description text here...',
                      emoji: e.emoji,
                      value: viewModel.isInterestSelected(e.label),
                      onChanged: (bool b) {
                        viewModel.addInterest(e.label);
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
