import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.logger.dart';

const int admMobMaxFailedLoadAttempts = 3;

class AdmobService {
  final Logger _logger = getLogger('AdmobService');

  late BannerAd? generatePlanBannerAd;
  bool generatePlanBannerAdisLoaded = false;
  int _numGeneratePlanBannerLoadAttempts = 0;

  String get loadingPlanBannerAdId {
    if (kReleaseMode) {
      return Platform.isIOS ? _prodLoadingPlanBannerAdiOS : _prodLoadingPlanBannerAdAndroid;
    }

    return Platform.isIOS ? _testLoadingPlanBannerAdiOS : _testLoadingPlanBannerAdAndroid;
  }

  String _prodLoadingPlanBannerAdiOS = '';
  String _prodLoadingPlanBannerAdAndroid = '';

  String _testLoadingPlanBannerAdiOS = '';
  String _testLoadingPlanBannerAdAndroid = '';

  late InterstitialAd? afterSavePlanInterstitialAd;
  int _numAfterSavePlanInterstitialLoadAttempts = 0;

  String get afterSavePlanInterstitialAdId {
    if (kReleaseMode) {
      return Platform.isIOS ? _prodAfterSavePlanInterstitialAdiOS : _prodAfterSavePlanInterstitialAdAndroid;
    }

    return Platform.isIOS ? _testAfterSavePlanInterstitialAdiOS : _testAfterSavePlanInterstitialAdAndroid;
  }

  String _prodAfterSavePlanInterstitialAdiOS = '';
  String _prodAfterSavePlanInterstitialAdAndroid = '';

  String _testAfterSavePlanInterstitialAdiOS = '';
  String _testAfterSavePlanInterstitialAdAndroid = '';

  AdmobService() {
    /// Production Banner ads
    _prodLoadingPlanBannerAdiOS = dotenv.env['ADMOB_IOS_GENERATE_PLAN_LOADING_BANNER_ID'] ?? '';
    _prodLoadingPlanBannerAdAndroid = dotenv.env['ADMOB_ANDROID_GENERATE_PLAN_LOADING_BANNER_ID'] ?? '';

    /// Test Banner ads
    _testLoadingPlanBannerAdiOS = dotenv.env["ADMOB_IOS_TEST_BANNER_ID"] ?? '';
    _testLoadingPlanBannerAdAndroid = dotenv.env["ADMOB_ANDROID_TEST_BANNER_ID"] ?? '';

    /// Production Interstitial ads
    _prodAfterSavePlanInterstitialAdiOS = dotenv.env['ADMOB_IOS_AFTER_SAVE_PLAN_INTERSTITIAL_ID'] ?? '';
    _prodAfterSavePlanInterstitialAdAndroid = dotenv.env['ADMOB_ANDROID_AFTER_SAVE_PLAN_INTERSTITIAL_ID'] ?? '';

    /// Test Interstitial ads
    _testAfterSavePlanInterstitialAdiOS = dotenv.env['ADMOB_IOS_TEST_INTERSTITIAL_ID'] ?? '';
    _testAfterSavePlanInterstitialAdAndroid = dotenv.env['ADMOB_ANDROID_TEST_INTERSTITIAL_ID'] ?? '';
  }

  loadGeneratePlanBannerAd({required Function onAdLoadedCallback}) {
    generatePlanBannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: loadingPlanBannerAdId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _logger.i('initBannerAd - onAdLoaded - adId: ${ad.adUnitId}');
          generatePlanBannerAdisLoaded = true;
          _numGeneratePlanBannerLoadAttempts = 0;
          onAdLoadedCallback();
        },
        onAdFailedToLoad: (ad, error) {
          _logger.i('initBannerAd - onAdFailedToLoad - adId: ${ad.adUnitId} - error: $error');
          _numGeneratePlanBannerLoadAttempts++;
          generatePlanBannerAd = null;

          if (_numGeneratePlanBannerLoadAttempts < admMobMaxFailedLoadAttempts) {
            loadGeneratePlanBannerAd(onAdLoadedCallback: onAdLoadedCallback);
          } else {
            generatePlanBannerAd?.dispose();
          }
        },
      ),
      request: const AdRequest(),
    );
    generatePlanBannerAd?.load();
  }

  void loadAfterSavePlanInterstitialAd() {
    InterstitialAd.load(
      adUnitId: afterSavePlanInterstitialAdId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _logger.i('initInterstitialAd - onAdLoaded - adId: ${ad.adUnitId}');
          afterSavePlanInterstitialAd = ad;
          _numAfterSavePlanInterstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _logger.i('initInterstitialAd - onAdFailedToLoad - adId: $afterSavePlanInterstitialAdId - error: $error');
          _numAfterSavePlanInterstitialLoadAttempts++;
          afterSavePlanInterstitialAd = null;

          if (_numAfterSavePlanInterstitialLoadAttempts < admMobMaxFailedLoadAttempts) {
            loadAfterSavePlanInterstitialAd();
          } else {
            afterSavePlanInterstitialAd?.dispose();
          }
        },
      ),
    );
  }
}
