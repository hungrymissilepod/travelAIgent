import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:simple_chips_input/select_chips_input.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/misc/constants.dart';
import 'package:travel_aigent/models/chip_model.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';

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

            /// TOOD: create CTA button and uee among app
            InkWell(
              onTap: viewModel.onContinueTap,
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: const Center(
                    child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 21,
                    ),
                  ),
                )),
              ),
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
  const PrefenceChips(
      {super.key,
      required this.chips,
      required this.onTap,
      this.onlyOneChipSelectable = false});

  final List<ChipModel> chips;
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
        paddingInsideChipContainer:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        marginBetweenChips:
            const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        selectedChipTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        unselectedChipTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 16,
        ),
        onTap: (String p0, int p1) => onTap(p0, p1),
        widgetContainerDecoration:
            const BoxDecoration(color: Colors.transparent),
        unselectedChipDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
                color: Theme.of(context).primaryColorLight, width: 1)),
        selectedChipDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colours.accent.shade50,
            border: Border.all(
                color: Theme.of(context).colorScheme.secondary, width: 1)),
        prefixIcons: chips.map((e) {
          return Padding(
              padding: const EdgeInsets.only(right: 5.0), child: Text(e.emoji));
        }).toList(),
      ),
    );
  }
}

class HolidayTypeView extends ViewModelWidget<PreferencesViewModel> {
  const HolidayTypeView({super.key});

  @override
  Widget build(BuildContext context, PreferencesViewModel viewModel) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Select a holiday type',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        ),
        PrefenceChips(
          chips: holidayTypeChips,
          onTap: (String p0, int p1) => viewModel.setHolidayType(p0),
          onlyOneChipSelectable: true,
        ),
      ],
    );
  }
}

class InterestsView extends ViewModelWidget<PreferencesViewModel> {
  const InterestsView({super.key});

  @override
  Widget build(BuildContext context, PreferencesViewModel viewModel) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Select your interests',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        ),
        PrefenceChips(
          chips: interestChips,
          onTap: (String p0, int p1) => viewModel.addInterest(p0),
        ),
      ],
    );
  }
}
