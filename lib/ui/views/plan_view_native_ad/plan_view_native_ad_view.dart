import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:stacked/stacked.dart';

import 'plan_view_native_ad_viewmodel.dart';

/// This is a Stacked view version of native ads
/// Using this approach we can only load one native ad at a time.
///
/// In order to load multiple native ads at a time use [PlanNativeAdView] widget
class PlanViewNativeAdView extends StackedView<PlanViewNativeAdViewModel> {
  const PlanViewNativeAdView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PlanViewNativeAdViewModel viewModel,
    Widget? child,
  ) {
    return viewModel.isAdLoaded
        ? Container(
            color: Colors.red,
            child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 300,
                  maxWidth: double.infinity,
                  minHeight: 100,
                  maxHeight: 400,
                ),
                child: Center(child: AdWidget(ad: viewModel.nativeAd!))),
          )
        : const SizedBox();
  }

  @override
  PlanViewNativeAdViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PlanViewNativeAdViewModel();
}
