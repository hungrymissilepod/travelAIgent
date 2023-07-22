import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:simple_chips_input/select_chips_input.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/misc/constants.dart';
import 'package:travel_aigent/models/interest_chip_model.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/common/cta_button.dart';

import 'preferences_viewmodel.dart';

class PreferencesView extends StackedView<PreferencesViewModel> {
  const PreferencesView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PreferencesViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          onTap: viewModel.onAppBarBackTap,
          child: Icon(
            Icons.arrow_back_rounded,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const ProgressBar(),
            Expanded(
              child: PageView(
                controller: viewModel.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const <Widget>[
                  HolidayTypeView(),
                  InterestsView(),
                ],
              ),
            ),
            CTAButton(
              onTap: viewModel.onContinueTap,
              label: 'Continue',
            ),
          ],
        ),
      ),
    );
  }

  @override
  PreferencesViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PreferencesViewModel();

  @override
  void onViewModelReady(PreferencesViewModel viewModel) => viewModel.init();
}

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
      animateFromLastPercent: true,
      animation: true,
      animationDuration: 100,
    );
  }
}

class PrefenceChips extends StatelessWidget {
  const PrefenceChips({super.key, required this.chips, required this.onTap, this.onlyOneChipSelectable = false});

  final List<InterestChip> chips;
  final Function(String p0, int p1) onTap;
  final bool onlyOneChipSelectable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SelectChipsInput(
        wrapAlignment: WrapAlignment.center,
        onlyOneChipSelectable: onlyOneChipSelectable,
        chipsText: chips.map((e) => e.label).toList(),
        separatorCharacter: onlyOneChipSelectable ? null : ',',
        paddingInsideWidgetContainer: const EdgeInsets.symmetric(horizontal: 3),
        paddingInsideChipContainer: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        marginBetweenChips: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        selectedChipTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        unselectedChipTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 16,
        ),
        onTap: (String p0, int p1) => onTap(p0, p1),
        widgetContainerDecoration: const BoxDecoration(color: Colors.transparent),
        unselectedChipDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Theme.of(context).primaryColorLight, width: 1)),
        selectedChipDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colours.accent.shade50,
            border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 1)),
        prefixIcons: chips.map((e) {
          return Padding(padding: const EdgeInsets.only(right: 5.0), child: Text(e.emoji));
        }).toList(),
      ),
    );
  }
}

class HolidayTypeView extends ViewModelWidget<PreferencesViewModel> {
  const HolidayTypeView({super.key});

  @override
  Widget build(BuildContext context, PreferencesViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Select a holiday type',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
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

class InterestsView extends ViewModelWidget<PreferencesViewModel> {
  const InterestsView({super.key});

  @override
  Widget build(BuildContext context, PreferencesViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(10),
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
          Center(
            child: PrefenceChips(
              chips: interestChips,
              onTap: (String p0, int p1) => viewModel.addInterest(p0),
            ),
          ),
        ],
      ),
    );
  }
}
