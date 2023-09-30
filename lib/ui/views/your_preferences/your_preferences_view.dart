import 'package:flutter/material.dart';
import 'package:separated_column/separated_column.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/misc/constants.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/ui/common/common_expansion_tile.dart';
import 'package:travel_aigent/ui/views/plan/ui/plan_view_loaded_state.dart';

import 'your_preferences_viewmodel.dart';

class YourPreferencesView extends StackedView<YourPreferencesViewModel> {
  const YourPreferencesView({
    Key? key,
    required this.plan,
  }) : super(key: key);

  final Plan? plan;

  String getHolidayTypeEmoji(String type) {
    final int index = holidayTypeChips.indexWhere((e) => e.label == type);
    if (index != -1) {
      return holidayTypeChips[index].emoji;
    }
    return '';
  }

  String getInterestEmoji(String type) {
    final int index = interestChips.indexWhere((e) => e.label == type);
    if (index != -1) {
      return interestChips[index].emoji;
    }
    return '';
  }

  @override
  Widget builder(
    BuildContext context,
    YourPreferencesViewModel viewModel,
    Widget? child,
  ) {
    return CommonExpansionTile(
      title: 'Your Preferences',
      children: <Widget>[
        const Text(
          'Holiday type',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: smallSpacer),
        YourPreferencesRow(
          emoji: getHolidayTypeEmoji(plan?.preferences?.holidayType ?? ''),
          label: plan?.preferences?.holidayType ?? '',
        ),
        const SizedBox(height: smallSpacer * 1.5),
        const Text(
          'Interests',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: smallSpacer),
        plan?.preferences?.interests == null
            ? const SizedBox()
            : SeparatedColumn(
                separatorBuilder: (context, index) {
                  return const SizedBox(height: smallSpacer);
                },
                children: plan!.preferences!.interests.map((e) {
                  return YourPreferencesRow(
                      emoji: getInterestEmoji(e), label: e);
                }).toList(),
              ),
      ],
    );
  }

  @override
  YourPreferencesViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      YourPreferencesViewModel();
}

class YourPreferencesRow extends StatelessWidget {
  const YourPreferencesRow({
    super.key,
    required this.emoji,
    required this.label,
  });

  final String emoji;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          emoji,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 20,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
