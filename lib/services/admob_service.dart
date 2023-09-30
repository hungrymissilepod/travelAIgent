import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/services/hive_service.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';

const int admMobMaxFailedLoadAttempts = 3;

/// The number of cold starts we allow before we start showing app open ads
const int numTimesColdStartBeforeAppOpenAdsShown = 3;

class AdmobService {
  final HiveService _hiveService = locator<HiveService>();
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

  AppOpenAd? appOpenAd;
  bool isShowingAppOpenAd = false;
  int _numAppOpenAdsLoaded = 0;
  int _numTimesAppColdStarted = 0;

  /// Maximum duration allowed between loading and showing the ad.
  final Duration _maxCacheDurationAppOpenAd = const Duration(hours: 4);

  /// Keep track of load time so we don't show an expired ad.
  DateTime? _appOpenAdLoadTime;

  String get appOpenAdId {
    if (kReleaseMode) {
      return Platform.isIOS ? _prodAppOpenAdiOS : _prodAppOpenAdAndroid;
    }

    return Platform.isIOS ? _testAppOpenAdiOS : _testAppOpenAdAndroid;
  }

  String _prodAppOpenAdiOS = '';
  String _prodAppOpenAdAndroid = '';

  String _testAppOpenAdiOS = '';
  String _testAppOpenAdAndroid = '';

  NativeAd? planViewNativeAd;
  bool planViewNativeAdIsLoaded = false;
  int _numPlanViewNativeLoadAttempts = 0;

  String get planViewNativeAdId {
    if (kReleaseMode) {
      return Platform.isIOS ? _prodPlanViewNativeAdiOS : _prodPlanViewNativeAdAndroid;
    }

    return Platform.isIOS ? _testPlanViewNativeAdiOS : _testPlanViewNativeAdAndroid;
  }

  String _prodPlanViewNativeAdiOS = '';
  String _prodPlanViewNativeAdAndroid = '';

  String _testPlanViewNativeAdiOS = '';
  String _testPlanViewNativeAdAndroid = '';

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

    /// Production App Open ads
    _prodAppOpenAdiOS = dotenv.env['ADMOB_IOS_APP_OPEN_ID'] ?? '';
    _prodAppOpenAdAndroid = dotenv.env['ADMOB_ANDROID_APP_OPEN_ID'] ?? '';

    /// Test App Open ads
    _testAppOpenAdiOS = dotenv.env['ADMOB_IOS_TEST_APP_OPEN_ID'] ?? '';
    _testAppOpenAdAndroid = dotenv.env['ADMOB_ANDROID_TEST_APP_OPEN_ID'] ?? '';

    /// Production Plan View Native ads
    _prodPlanViewNativeAdiOS = dotenv.env['ADMOB_IOS_PLAN_VIEW_NATIVE_ID'] ?? '';
    _prodPlanViewNativeAdAndroid = dotenv.env['ADMOB_ANDROID_PLAN_VIEW_NATIVE_ID'] ?? '';

    /// Test Plan View Native ads
    _testPlanViewNativeAdiOS = dotenv.env['ADMOB_IOS_TEST_NATIVE_ADVANCED_ID'] ?? '';
    _testPlanViewNativeAdAndroid = dotenv.env['ADMOB_ANDROID_TEST_NATIVE_ADVANCED_ID'] ?? '';
  }

  Future<void> init() async {
    _numTimesAppColdStarted = await _hiveService.read(HiveKeys.numTimesAppColdStarted);
    _logger.i('init - _numTimesAppColdStarted: $_numTimesAppColdStarted');
    loadAppOpenAd();
  }

  loadGeneratePlanBannerAd({required Function onAdLoadedCallback}) {
    generatePlanBannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: loadingPlanBannerAdId,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _logger.i('loadGeneratePlanBannerAd - onAdLoaded - adId: ${ad.adUnitId}');
          generatePlanBannerAdisLoaded = true;
          _numGeneratePlanBannerLoadAttempts = 0;
          onAdLoadedCallback();
        },
        onAdFailedToLoad: (ad, error) {
          _logger.i('loadGeneratePlanBannerAd - onAdFailedToLoad - adId: ${ad.adUnitId} - error: $error');
          ad.dispose();
          _numGeneratePlanBannerLoadAttempts++;
          generatePlanBannerAd = null;

          if (_numGeneratePlanBannerLoadAttempts < admMobMaxFailedLoadAttempts) {
            loadGeneratePlanBannerAd(onAdLoadedCallback: onAdLoadedCallback);
          } else {
            generatePlanBannerAd?.dispose();
          }
        },
      ),
    )..load();
  }

  void loadAfterSavePlanInterstitialAd() {
    InterstitialAd.load(
      adUnitId: afterSavePlanInterstitialAdId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _logger.i('loadAfterSavePlanInterstitialAd - onAdLoaded - adId: ${ad.adUnitId}');
          afterSavePlanInterstitialAd = ad;
          _numAfterSavePlanInterstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _logger.i(
              'loadAfterSavePlanInterstitialAd - onAdFailedToLoad - adId: $afterSavePlanInterstitialAdId - error: $error');
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

  void loadPlanViewNativeAd({required Function onAdLoadedCallback}) {
    planViewNativeAd = NativeAd(
      adUnitId: planViewNativeAdId,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          _logger.i('loadPlanViewNativeAd - onAdLoaded - adId: ${ad.adUnitId}');
          planViewNativeAdIsLoaded = true;
          _numPlanViewNativeLoadAttempts = 0;
          onAdLoadedCallback();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          _logger.i('loadPlanViewNativeAd - onAdFailedToLoad - adId: ${ad.adUnitId} - error: $error');
          ad.dispose();
          _numPlanViewNativeLoadAttempts++;
          planViewNativeAd = null;

          if (_numPlanViewNativeLoadAttempts < admMobMaxFailedLoadAttempts) {
            loadPlanViewNativeAd(onAdLoadedCallback: onAdLoadedCallback);
          } else {
            planViewNativeAd?.dispose();
          }
        },
      ),
      nativeTemplateStyle: NativeTemplateStyle(
        cornerRadius: 8.0,
        templateType: TemplateType.small,
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
    )..load();
  }

  void loadAppOpenAd() {
    if (_numTimesAppColdStarted < numTimesColdStartBeforeAppOpenAdsShown) {
      return;
    }
    AppOpenAd.load(
      adUnitId: appOpenAdId,
      orientation: AppOpenAd.orientationPortrait,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _logger.i('loadAppOpenAd - onAdLoaded');
          appOpenAd = ad;
          _appOpenAdLoadTime = DateTime.now();
          _numAppOpenAdsLoaded++;
          _logger.i('_numAppOpenAdsLoaded: $_numAppOpenAdsLoaded');

          /// This make the add appear on a cold start
          if (_numAppOpenAdsLoaded == 1) {
            appOpenAd?.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (ad) {
                _logger.i('$ad onAdShowedFullScreenContent');
                isShowingAppOpenAd = true;
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                _logger.i('$ad onAdFailedToShowFullScreenContent: $error');
                isShowingAppOpenAd = false;
                ad.dispose();
                appOpenAd = null;
              },
              onAdDismissedFullScreenContent: (ad) {
                _logger.i('$ad onAdDismissedFullScreenContent');
                SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
                isShowingAppOpenAd = false;
                ad.dispose();
                appOpenAd = null;
                loadAppOpenAd();
              },
            );
            _showAppOpenAd();
          }
        },
        onAdFailedToLoad: (error) {
          _logger.e('Failed to load AppOpen ad: $error');
        },
      ),
    );
  }

  Future<void> _showAppOpenAd() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    appOpenAd?.show();
  }

  void showAppOpenAdIfAvailable() {
    if (_numTimesAppColdStarted < numTimesColdStartBeforeAppOpenAdsShown) {
      return;
    }
    if (!isAppOpenAdAvailable) {
      _logger.i('Tried to show AppOpen ad before available');
      loadAppOpenAd();
      return;
    }
    if (isShowingAppOpenAd) {
      _logger.i('Tried to show AppOpen ad while aleady showing an ad');
      return;
    }
    if (DateTime.now().subtract(_maxCacheDurationAppOpenAd).isAfter(_appOpenAdLoadTime!)) {
      _logger.i('Maximum cache duration exceeded. Loading another ad.');
      appOpenAd!.dispose();
      appOpenAd = null;
      loadAppOpenAd();
      return;
    }
    appOpenAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _logger.i('$ad onAdShowedFullScreenContent');
        isShowingAppOpenAd = true;
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _logger.i('$ad onAdFailedToShowFullScreenContent: $error');
        isShowingAppOpenAd = false;
        ad.dispose();
        appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        _logger.i('$ad onAdDismissedFullScreenContent');
        isShowingAppOpenAd = false;
        ad.dispose();
        appOpenAd = null;
        loadAppOpenAd();
      },
    );

    /// This makes the app appear every time the user foreground the app (after cold start)
    if (_numAppOpenAdsLoaded >= 1) {
      appOpenAd?.show();
    }
  }

  bool get isAppOpenAdAvailable {
    return appOpenAd != null;
  }
}
