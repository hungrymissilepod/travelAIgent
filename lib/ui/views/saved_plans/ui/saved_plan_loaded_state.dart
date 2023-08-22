import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/saved_plans/saved_plans_viewmodel.dart';
import 'package:travel_aigent/ui/views/saved_plans/ui/saved_plan_card.dart';

class SavedPlanViewLoadedState extends ViewModelWidget<SavedPlansViewModel> {
  const SavedPlanViewLoadedState({super.key});

  @override
  Widget build(BuildContext context, SavedPlansViewModel viewModel) {
    return Scrollbar(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(scaffoldHorizontalPadding, 10, scaffoldHorizontalPadding, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: viewModel.savedPlans.map((e) => SavedPlanCard(plan: e)).toList(),
          ),
        ),
      ),
    );
  }
}
