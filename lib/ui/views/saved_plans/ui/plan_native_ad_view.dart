import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/services/admob_service.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';

class PlanNativeAdView extends StatefulWidget {
  const PlanNativeAdView({
    super.key,
    this.type = TemplateType.medium,
  });

  final TemplateType type;

  @override
  State<PlanNativeAdView> createState() => _PlanNativeAdViewState();
}

class _PlanNativeAdViewState extends State<PlanNativeAdView> {
  final AdmobService admobService = locator<AdmobService>();
  final Logger logger = getLogger('PlanNativeAdView');

  NativeAd? _ad;
  bool _isLoaded = false;
  int attemptsToLoad = 0;

  @override
  void initState() {
    super.initState();
    _ad = NativeAd(
      adUnitId: admobService.planViewNativeAdId,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          logger.i('onAdLoaded - adId: ${ad.adUnitId}');
          attemptsToLoad = 0;
          setState(() {
            _ad = ad as NativeAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          logger.i('onAdFailedToLoad - adId: ${ad.adUnitId} - error: $error');
          ad.dispose();
          attemptsToLoad++;
          _isLoaded = false;
          _ad = null;

          if (attemptsToLoad < admMobMaxFailedLoadAttempts) {
            _ad?.load();
          } else {
            _ad?.dispose();
          }
        },
      ),
      nativeTemplateStyle: NativeTemplateStyle(
        cornerRadius: 8.0,
        templateType: widget.type,
        callToActionTextStyle: NativeTemplateTextStyle(
          size: 16.0,
          backgroundColor: Colours.accent,
          style: NativeTemplateFontStyle.bold,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          size: 18,
          textColor: Colors.black,
          backgroundColor: Colors.white,
          style: NativeTemplateFontStyle.bold,
        ),
      ),
    );
    _ad?.load();
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded == false
        ? const SizedBox()
        : ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 300,
              maxWidth: double.infinity,
              minHeight: 100,
              maxHeight: widget.type == TemplateType.medium ? 380 : 110,
            ),
            child: Center(
              child: AdWidget(
                ad: _ad!,
              ),
            ),
          );
  }
}
