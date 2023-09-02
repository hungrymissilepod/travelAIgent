import 'dart:io';

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
    /// We add an additional bottom padding to the banner on iOS
    /// so that banner is not behind the swipe up bar
    final double bottomPadding = Platform.isIOS ? 20 : 0;
    return viewModel.isBannerAdLoaded
        ? Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: SizedBox(
              height: viewModel.bannerAd?.size.height.toDouble(),
              width: viewModel.bannerAd?.size.width.toDouble(),
              child: AdWidget(ad: viewModel.bannerAd!),
            ),
          )
        : SizedBox(height: 60 + bottomPadding);
  }

  @override
  PlanViewBannerAdViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PlanViewBannerAdViewModel();
}
