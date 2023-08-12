import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/common/cta_button.dart';
import 'package:travel_aigent/ui/views/plan/ui/plan_view_loaded_state.dart';
import 'package:travel_aigent/ui/views/plan/ui/plan_view_loading_state.dart';

import 'plan_viewmodel.dart';

class PlanView extends StackedView<PlanViewModel> {
  const PlanView({Key? key, this.savedPlan}) : super(key: key);

  final Plan? savedPlan;

  @override
  Widget builder(
    BuildContext context,
    PlanViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        leading: Offstage(
          offstage: viewModel.isBusy,
          child: GestureDetector(
            onTap: savedPlan == null
                ? viewModel.onExitButtonTap
                : viewModel.onContinueButtonTap,
            child: Icon(
              savedPlan == null ? Icons.close : Icons.arrow_back_rounded,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),

      /// TODO: add this error handling back in, however! We need to make sure that image requsts failing does not stop the ENTIRE page from showing. We need to display image error states anyway
      body: SafeArea(
        child: viewModel.isBusy
            ? const PlanViewLoadingState()
            : const PlanViewLoadedState(),

        //   // child: viewModel.hasError
        //   //     ? PlanViewErrorState(retry: () => viewModel.generatePlan(savedPlan))
        //   //     : viewModel.isBusy
        //   //         ? const PlanViewLoadingState()
        //   //         : const PlanViewLoadedState(),
      ),
      bottomNavigationBar: Visibility(
        // visible: (!viewModel.hasError && !viewModel.isBusy) && savedPlan == null,
        visible: (!viewModel.isBusy) && savedPlan == null,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                scaffoldHorizontalPadding, 0, scaffoldHorizontalPadding, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CTAButton(
                  onTap: viewModel.onTryAgainButtonTap,
                  label: 'Get another suggestion',
                  style: CTAButtonStyle.outline,
                ),
                const SizedBox(
                  height: 10,
                ),
                CTAButton(
                  onTap: viewModel.onSaveTripTap,
                  label: 'Save Trip',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  PlanViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PlanViewModel();

  @override
  void onViewModelReady(PlanViewModel viewModel) =>
      viewModel.generatePlan(savedPlan);
}
