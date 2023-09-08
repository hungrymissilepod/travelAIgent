import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/common/common_app_bar.dart';
import 'package:travel_aigent/ui/common/common_safe_area.dart';
import 'package:travel_aigent/ui/common/cta_button.dart';
import 'package:travel_aigent/ui/views/preferences/preferences_viewmodel.dart';
import 'package:travel_aigent/ui/views/preferences/ui/holiday_type_view.dart';
import 'package:travel_aigent/ui/views/preferences/ui/interests_view.dart';
import 'package:travel_aigent/ui/views/preferences/ui/progress_bar.dart';

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
      appBar: CommonAppBar(
        title: viewModel.getAppBarTitle(),
        showBackButton: true,
        onLeadingTap: viewModel.onAppBarBackTap,
      ),
      body: CommonSafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: scaffoldHorizontalPadding),
              child: CTAButton(
                onTap: viewModel.onContinueTap,
                label: viewModel.getCTAButtonLabel(),
                enabled: viewModel.ctaButtonEnabled,
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
