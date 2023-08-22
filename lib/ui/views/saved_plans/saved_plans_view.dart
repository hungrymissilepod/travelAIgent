import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/views/saved_plans/ui/saved_plan_loaded_state.dart';
import 'package:travel_aigent/ui/views/saved_plans/ui/saved_plans_empty_state.dart';

import 'saved_plans_viewmodel.dart';

class SavedPlansView extends StackedView<SavedPlansViewModel> {
  const SavedPlansView({
    Key? key,
    required this.navigateToHomeView,
  }) : super(key: key);

  final Function() navigateToHomeView;

  @override
  Widget builder(
    BuildContext context,
    SavedPlansViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'My Trips',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SafeArea(
        child: viewModel.savedPlans.isEmpty
            ? SavedPlanViewEmptyState(navigateToHomeView: navigateToHomeView)
            : const SavedPlanViewLoadedState(),
      ),
    );
  }

  @override
  SavedPlansViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SavedPlansViewModel();
}
