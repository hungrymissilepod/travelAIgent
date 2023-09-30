import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/common_app_bar.dart';
import 'package:travel_aigent/ui/common/common_safe_area.dart';
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
      appBar: CommonAppBar(
        title: 'My Trips',
        centerTitle: false,
        titleStyle: Theme.of(context).textTheme.displayLarge,
      ),
      body: viewModel.isBusy
          ? const SizedBox()
          : CommonSafeArea(
              child: viewModel.savedPlans.isEmpty
                  ? SavedPlanViewEmptyState(
                      navigateToHomeView: navigateToHomeView)
                  : SavedPlanViewLoadedState(type: viewModel.templateType),
            ),
    );
  }

  @override
  SavedPlansViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SavedPlansViewModel();
}
