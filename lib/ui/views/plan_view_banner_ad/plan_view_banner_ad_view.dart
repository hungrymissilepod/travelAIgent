import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:stacked/stacked.dart';

import 'plan_view_banner_ad_viewmodel.dart';

class PlanViewBannerAdView extends StackedView<PlanViewBannerAdViewModel> {
  const PlanViewBannerAdView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PlanViewBannerAdViewModel viewModel,
    Widget? child,
  ) {
    return viewModel.isBannerAdLoaded
        ? Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              height: viewModel.bannerAd?.size.height.toDouble(),
              width: viewModel.bannerAd?.size.width.toDouble(),
              child: AdWidget(ad: viewModel.bannerAd!),
            ),
          )

        /// this is the height of the bannerAd (60) and the 20 padding
        : const SizedBox(
            height: 80,
          );
  }

  @override
  PlanViewBannerAdViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PlanViewBannerAdViewModel();
}
