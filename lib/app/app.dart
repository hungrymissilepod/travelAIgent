import 'package:travel_aigent/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:travel_aigent/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:travel_aigent/ui/views/home/home_view.dart';
import 'package:travel_aigent/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/ui/views/counter/counter_view.dart';
import 'package:travel_aigent/ui/views/login/login_view.dart';
import 'package:travel_aigent/services/authentication_service.dart';
import 'package:travel_aigent/services/dio_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: CounterView),
    MaterialRoute(page: LoginView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: DioService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
  logger: StackedLogger(),
)
class App {}
