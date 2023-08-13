import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/services/authentication_service.dart';
import 'package:travel_aigent/services/dio_service.dart';
import 'package:travel_aigent/services/web_scraper_service.dart';
import 'package:travel_aigent/services/ai_service.dart';
import 'package:travel_aigent/services/generator_service.dart';
import 'package:travel_aigent/services/firestore_service.dart';
import 'package:travel_aigent/services/who_am_i_service.dart';
import 'package:travel_aigent/services/analytics_service.dart';
import 'package:travel_aigent/services/firebase_user_service.dart';
import 'package:travel_aigent/services/ip_service.dart';
import 'package:travel_aigent/services/currency_scraper_service.dart';
import 'package:travel_aigent/services/wikipedia_scraper_service.dart';
import 'package:travel_aigent/services/average_price_service.dart';
import 'package:travel_aigent/services/airport_service.dart';
import 'package:travel_aigent/services/image_scraper_service.dart';
// @stacked-import

import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<NavigationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<BottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DialogService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<AuthenticationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DioService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<WebScraperService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<AiService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<GeneratorService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<FirestoreService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<WhoAmIService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<AnalyticsService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<FirebaseUserService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<IpService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<CurrencyScraperService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<WikipediaScraperService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<AveragePriceService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<AirportService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ImageScraperService>(onMissingStub: OnMissingStub.returnDefault),
// @stacked-mock-spec
])
void registerServices() {
  getAndRegisterNavigationService();
  getAndRegisterBottomSheetService();
  getAndRegisterDialogService();
  getAndRegisterAuthenticationService();
  getAndRegisterDioService();
  getAndRegisterWebScraperService();
  getAndRegisterAiService();
  getAndRegisterGeneratorService();
  getAndRegisterFirestoreService();
  getAndRegisterWhoAmIService();
  getAndRegisterAnalyticsService();
  getAndRegisterFirebaseUserService();
  getAndRegisterIpService();
  getAndRegisterCurrencyScraperService();
  getAndRegisterWikipediaScraperService();
  getAndRegisterAveragePriceService();
  getAndRegisterAirportService();
  getAndRegisterImageScraperService();
// @stacked-mock-register
}

MockNavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

MockBottomSheetService getAndRegisterBottomSheetService<T>({
  SheetResponse<T>? showCustomSheetResponse,
}) {
  _removeRegistrationIfExists<BottomSheetService>();
  final service = MockBottomSheetService();

  when(service.showCustomSheet<T, T>(
    enableDrag: anyNamed('enableDrag'),
    enterBottomSheetDuration: anyNamed('enterBottomSheetDuration'),
    exitBottomSheetDuration: anyNamed('exitBottomSheetDuration'),
    ignoreSafeArea: anyNamed('ignoreSafeArea'),
    isScrollControlled: anyNamed('isScrollControlled'),
    barrierDismissible: anyNamed('barrierDismissible'),
    additionalButtonTitle: anyNamed('additionalButtonTitle'),
    variant: anyNamed('variant'),
    title: anyNamed('title'),
    hasImage: anyNamed('hasImage'),
    imageUrl: anyNamed('imageUrl'),
    showIconInMainButton: anyNamed('showIconInMainButton'),
    mainButtonTitle: anyNamed('mainButtonTitle'),
    showIconInSecondaryButton: anyNamed('showIconInSecondaryButton'),
    secondaryButtonTitle: anyNamed('secondaryButtonTitle'),
    showIconInAdditionalButton: anyNamed('showIconInAdditionalButton'),
    takesInput: anyNamed('takesInput'),
    barrierColor: anyNamed('barrierColor'),
    barrierLabel: anyNamed('barrierLabel'),
    customData: anyNamed('customData'),
    data: anyNamed('data'),
    description: anyNamed('description'),
  )).thenAnswer((realInvocation) => Future.value(showCustomSheetResponse ?? SheetResponse<T>()));

  locator.registerSingleton<BottomSheetService>(service);
  return service;
}

MockDialogService getAndRegisterDialogService() {
  _removeRegistrationIfExists<DialogService>();
  final service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

MockAuthenticationService getAndRegisterAuthenticationService() {
  _removeRegistrationIfExists<AuthenticationService>();
  final service = MockAuthenticationService();
  locator.registerSingleton<AuthenticationService>(service);
  return service;
}

MockDioService getAndRegisterDioService() {
  _removeRegistrationIfExists<DioService>();
  final service = MockDioService();
  locator.registerSingleton<DioService>(service);
  return service;
}

MockWebScraperService getAndRegisterWebScraperService() {
  _removeRegistrationIfExists<WebScraperService>();
  final service = MockWebScraperService();
  locator.registerSingleton<WebScraperService>(service);
  return service;
}

MockAiService getAndRegisterAiService() {
  _removeRegistrationIfExists<AiService>();
  final service = MockAiService();
  locator.registerSingleton<AiService>(service);
  return service;
}

MockGeneratorService getAndRegisterGeneratorService() {
  _removeRegistrationIfExists<GeneratorService>();
  final service = MockGeneratorService();
  locator.registerSingleton<GeneratorService>(service);
  return service;
}

MockFirestoreService getAndRegisterFirestoreService() {
  _removeRegistrationIfExists<FirestoreService>();
  final service = MockFirestoreService();
  locator.registerSingleton<FirestoreService>(service);
  return service;
}

MockWhoAmIService getAndRegisterWhoAmIService() {
  _removeRegistrationIfExists<WhoAmIService>();
  final service = MockWhoAmIService();
  locator.registerSingleton<WhoAmIService>(service);
  return service;
}

MockAnalyticsService getAndRegisterAnalyticsService() {
  _removeRegistrationIfExists<AnalyticsService>();
  final service = MockAnalyticsService();
  locator.registerSingleton<AnalyticsService>(service);
  return service;
}

MockFirebaseUserService getAndRegisterFirebaseUserService() {
  _removeRegistrationIfExists<FirebaseUserService>();
  final service = MockFirebaseUserService();
  locator.registerSingleton<FirebaseUserService>(service);
  return service;
}

MockIpService getAndRegisterIpService() {
  _removeRegistrationIfExists<IpService>();
  final service = MockIpService();
  locator.registerSingleton<IpService>(service);
  return service;
}

MockCurrencyScraperService getAndRegisterCurrencyScraperService() {
  _removeRegistrationIfExists<CurrencyScraperService>();
  final service = MockCurrencyScraperService();
  locator.registerSingleton<CurrencyScraperService>(service);
  return service;
}

MockWikipediaScraperService getAndRegisterWikipediaScraperService() {
  _removeRegistrationIfExists<WikipediaScraperService>();
  final service = MockWikipediaScraperService();
  locator.registerSingleton<WikipediaScraperService>(service);
  return service;
}

MockAveragePriceService getAndRegisterAveragePriceService() {
  _removeRegistrationIfExists<AveragePriceService>();
  final service = MockAveragePriceService();
  locator.registerSingleton<AveragePriceService>(service);
  return service;
}

MockAirportService getAndRegisterAirportService() {
  _removeRegistrationIfExists<AirportService>();
  final service = MockAirportService();
  locator.registerSingleton<AirportService>(service);
  return service;
}

MockImageScraperService getAndRegisterImageScraperService() {
  _removeRegistrationIfExists<ImageScraperService>();
  final service = MockImageScraperService();
  locator.registerSingleton<ImageScraperService>(service);
  return service;
}
// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
