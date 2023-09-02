import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/common/common_safe_area.dart';
import 'package:travel_aigent/ui/common/cta_button.dart';
import 'package:travel_aigent/ui/common/refresh_icon.dart';
import 'package:travel_aigent/ui/views/plan/ui/plan_view_error_state.dart';
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
        centerTitle: true,
        leading: Offstage(
          offstage: viewModel.isBusy,
          child: GestureDetector(
            onTap: savedPlan == null ? viewModel.onExitButtonTap : viewModel.onContinueButtonTap,
            child: Icon(
              savedPlan == null ? Icons.close : Icons.arrow_back_rounded,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        title: Visibility(
          visible: (!viewModel.hasError && !viewModel.isBusy) && savedPlan == null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              RefreshIcon(
                onTap: viewModel.onTryAgainButtonTap,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 10),
                child: Bounceable(
                  onTap: () async {
                    /// Only allow tapping if user has not saved plan yet
                    if (viewModel.showSaveButton) {
                      HapticFeedback.lightImpact();
                      viewModel.onSaveTripTap();
                    }
                  },
                  child: FaIcon(
                    viewModel.bookMarkIconFilled ? FontAwesomeIcons.solidBookmark : FontAwesomeIcons.bookmark,
                    color: viewModel.bookMarkIconFilled ? Colours.accent : Colours.accent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: CommonSafeArea(
        child: viewModel.hasError
            ? PlanViewErrorState(retry: () => viewModel.generatePlan(savedPlan))
            : viewModel.isBusy
                ? PlanViewLoadingState(showBannerAd: viewModel.showLoadingBannerAd)
                : PlanViewLoadedState(
                    isSavedPlan: savedPlan != null,
                  ),
      ),
      bottomNavigationBar: Visibility(
        visible: (!viewModel.hasError && !viewModel.isBusy) && savedPlan == null && viewModel.showSaveButton,
        child: CommonSafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(scaffoldHorizontalPadding, 0, scaffoldHorizontalPadding, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
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
  void onViewModelReady(PlanViewModel viewModel) => viewModel.generatePlan(savedPlan);
}
