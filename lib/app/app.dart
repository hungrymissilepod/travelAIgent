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
import 'package:travel_aigent/ui/views/dashboard/dashboard_view.dart';
import 'package:travel_aigent/services/web_scraper_service.dart';
import 'package:travel_aigent/services/ai_service.dart';
import 'package:travel_aigent/ui/views/preferences/preferences_view.dart';
import 'package:travel_aigent/services/generator_service.dart';
import 'package:travel_aigent/ui/views/plan/plan_view.dart';
import 'package:travel_aigent/ui/views/saved_plans/saved_plans_view.dart';
import 'package:travel_aigent/ui/dialogs/save_plan/save_plan_dialog.dart';
import 'package:travel_aigent/ui/views/register/register_view.dart';
import 'package:travel_aigent/ui/views/profile/profile_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: CounterView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: DashboardView),
    MaterialRoute(page: PreferencesView),
    MaterialRoute(page: PlanView),
    MaterialRoute(page: SavedPlansView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: ProfileView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: DioService),
    LazySingleton(classType: WebScraperService),
    LazySingleton(classType: AiService),
    LazySingleton(classType: GeneratorService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: SavePlanDialog),
// @stacked-dialog
  ],
  logger: StackedLogger(),
)
class App {}
