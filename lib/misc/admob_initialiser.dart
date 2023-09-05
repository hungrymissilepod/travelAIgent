import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.logger.dart';

class AdmobInitialiser {
  final Logger _logger = getLogger('AdmobInitialiser');

  final List<String> testDeviceIds = <String>[
    /// Android simulator
    "1BCBD81DE5A4D0DBCA85CADA5BC04025",

    /// iOS simulator
    "GADSimulatorID",

    /// my iPhone 11
    "20cfcf6aad3044a4aeb91770a7f1b2ee",

    /// my Huawei
    "31C16CCB2401446FACFCB9ABCD2F2B5C",
  ];

  Future<void> init() async {
    /// This can be used for debugging purposes
    // ConsentDebugSettings debugSettings = ConsentDebugSettings(debugGeography: DebugGeography.debugGeographyEea);
    // ConsentRequestParameters params = ConsentRequestParameters(consentDebugSettings: debugSettings);

    final ConsentRequestParameters params = ConsentRequestParameters();

    /// Check if consent form is required
    ConsentInformation.instance.requestConsentInfoUpdate(
      params,
      () async {
        if (await ConsentInformation.instance.isConsentFormAvailable()) {
          _logger.i('load GDPR consent form');
          loadForm();
        }
      },
      (FormError error) {
        _logger.e('failed to request GDPR consent info: ${error.message}');
      },
    );

    MobileAds.instance.initialize();

    RequestConfiguration requestConfiguration = RequestConfiguration(
      testDeviceIds: testDeviceIds,
    );
    MobileAds.instance.updateRequestConfiguration(requestConfiguration);
  }

  /// Show consent form
  void loadForm() {
    ConsentForm.loadConsentForm(
      (ConsentForm consentForm) async {
        var status = await ConsentInformation.instance.getConsentStatus();
        if (status == ConsentStatus.required) {
          consentForm.show(
            (FormError? formError) {
              _logger.i('reload load GDPR consent form');
              loadForm();
            },
          );
        }
      },
      (FormError formError) {
        _logger.i('erorr showing GDPR consent form');
      },
    );
  }
}
