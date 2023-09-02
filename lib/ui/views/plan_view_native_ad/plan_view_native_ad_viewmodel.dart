import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/services/admob_service.dart';

class PlanViewNativeAdViewModel extends BaseViewModel {
  final AdmobService _admobService = locator<AdmobService>();
  final Logger _logger = getLogger('PlanViewNativeAdViewModel');

  bool isAdLoaded = false;

  NativeAd? get nativeAd => _admobService.planViewNativeAd;

  PlanViewNativeAdViewModel() {
    _admobService.loadPlanViewNativeAd(onAdLoadedCallback: () {
      isAdLoaded = true;
      _logger.i('loaded native ad');
      rebuildUi();
    });
  }
}
