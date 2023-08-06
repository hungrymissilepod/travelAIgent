import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/misc/constants.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/preferences/preferences_viewmodel.dart';
import 'package:travel_aigent/ui/views/preferences/ui/preference_chips.dart';

class InterestsView extends ViewModelWidget<PreferencesViewModel> {
  const InterestsView({super.key});

  @override
  Widget build(BuildContext context, PreferencesViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(scaffoldHorizontalPadding, 10, scaffoldHorizontalPadding, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Select your interests',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),

          /// TODO: improve copy and UI here
          Text('Select your interests (5 max)'),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: PrefenceChips(
              chips: interestChips,
              onTap: (String p0, int p1) => viewModel.addInterest(p0.replaceAll(',', '')),
            ),
          ),
        ],
      ),
    );
  }
}
