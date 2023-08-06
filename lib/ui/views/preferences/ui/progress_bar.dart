import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/preferences/preferences_viewmodel.dart';

class ProgressBar extends ViewModelWidget<PreferencesViewModel> {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context, PreferencesViewModel viewModel) {
    return LinearPercentIndicator(
      padding: EdgeInsets.zero,
      lineHeight: 10.0,
      percent: viewModel.percent,
      progressColor: Theme.of(context).colorScheme.secondary,
      backgroundColor: Colours.accent.shade100,
      barRadius: const Radius.circular(20),
      animateFromLastPercent: true,
      animation: true,
      animationDuration: 100,
    );
  }
}
