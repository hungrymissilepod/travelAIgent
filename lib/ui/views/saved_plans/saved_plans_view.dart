import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      appBar: const CommonAppBar(
        title: 'My Trips',
      ),
      body: CommonSafeArea(
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
