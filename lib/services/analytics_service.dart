import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.logger.dart';

class AnalyticsService {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  final Logger _logger = getLogger('AnalyticsService');

  void logEvent(String name, {Map<String, dynamic>? parameters}) {
    analytics.logEvent(name: name, parameters: parameters);
    _logger.i('$name - ${parameters.toString()}');
  }
}
