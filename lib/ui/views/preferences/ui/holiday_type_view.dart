import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/misc/constants.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/preferences/preferences_viewmodel.dart';
import 'package:travel_aigent/ui/views/preferences/ui/preference_chips.dart';

class HolidayTypeView extends ViewModelWidget<PreferencesViewModel> {
  const HolidayTypeView({super.key});

  @override
  Widget build(BuildContext context, PreferencesViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(scaffoldHorizontalPadding, 10, scaffoldHorizontalPadding, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Select holiday type',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),

          /// TODO: improve copy and UI here
          Text('Select a holiday type (1 max)'),
          const SizedBox(
            height: 20,
          ),

          /// TODO: show options in a list to make use of screen space
          /// TODO: do same in InterestsView
          Center(
            child: PrefenceChips(
              chips: holidayTypeChips,
              onTap: (String p0, int p1) => viewModel.setHolidayType(p0),
              onlyOneChipSelectable: true,
            ),
          ),
        ],
      ),
    );
  }
}
