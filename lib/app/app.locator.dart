// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../services/ai_service.dart';
import '../services/airport_service.dart';
import '../services/analytics_service.dart';
import '../services/authentication_service.dart';
import '../services/average_price_service.dart';
import '../services/currency_scraper_service.dart';
import '../services/dio_service.dart';
import '../services/duck_duck_go_image_scraper_service.dart';
import '../services/firebase_user_service.dart';
import '../services/firestore_service.dart';
import '../services/generator_service.dart';
import '../services/ip_service.dart';
import '../services/web_scraper_service.dart';
import '../services/who_am_i_service.dart';
import '../services/wikipedia_scraper_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => DioService());
  locator.registerLazySingleton(() => WebScraperService());
  locator.registerLazySingleton(() => AiService());
  locator.registerLazySingleton(() => GeneratorService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => WhoAmIService());
  locator.registerLazySingleton(() => AnalyticsService());
  locator.registerLazySingleton(() => FirebaseUserService());
  locator.registerLazySingleton(() => IpService());
  locator.registerLazySingleton(() => CurrencyScraperService());
  locator.registerLazySingleton(() => WikipediaScraperService());
  locator.registerLazySingleton(() => AveragePriceService());
  locator.registerLazySingleton(() => AirportService());
  locator.registerLazySingleton(() => DuckDuckGoImageScraperService());
}
