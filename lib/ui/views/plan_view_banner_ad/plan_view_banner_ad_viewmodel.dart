import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/services/admob_service.dart';

class PlanViewBannerAdViewModel extends BaseViewModel {
  final AdmobService _admobService = locator<AdmobService>();
  final Logger _logger = getLogger('PlanViewBannerAdViewModel');

  bool isBannerAdLoaded = false;

  BannerAd? get bannerAd => _admobService.generatePlanBannerAd;

  PlanViewBannerAdViewModel() {
    _admobService.loadGeneratePlanBannerAd(onAdLoadedCallback: () {
      isBannerAdLoaded = true;
      _logger.i('loaded banner ad');
      rebuildUi();
    });
  }
}
