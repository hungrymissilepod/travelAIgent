// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i23;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i26;
import 'package:travel_aigent/models/destination_model.dart' as _i25;
import 'package:travel_aigent/models/plan_model.dart' as _i24;
import 'package:travel_aigent/ui/views/about/about_view.dart' as _i17;
import 'package:travel_aigent/ui/views/at_a_glace_section/at_a_glace_section_view.dart'
    as _i14;
import 'package:travel_aigent/ui/views/average_price_section/average_price_section_view.dart'
    as _i13;
import 'package:travel_aigent/ui/views/change_name/change_name_view.dart'
    as _i16;
import 'package:travel_aigent/ui/views/counter/counter_view.dart' as _i4;
import 'package:travel_aigent/ui/views/dashboard/dashboard_view.dart' as _i6;
import 'package:travel_aigent/ui/views/description_section/description_section_view.dart'
    as _i18;
import 'package:travel_aigent/ui/views/home/home_view.dart' as _i2;
import 'package:travel_aigent/ui/views/login/login_view.dart' as _i5;
import 'package:travel_aigent/ui/views/on_boarding_carousel/on_boarding_carousel_view.dart'
    as _i15;
import 'package:travel_aigent/ui/views/plan/plan_view.dart' as _i8;
import 'package:travel_aigent/ui/views/plan_view_banner_ad/plan_view_banner_ad_view.dart'
    as _i19;
import 'package:travel_aigent/ui/views/plan_view_native_ad/plan_view_native_ad_view.dart'
    as _i20;
import 'package:travel_aigent/ui/views/preferences/preferences_view.dart'
    as _i7;
import 'package:travel_aigent/ui/views/profile/profile_view.dart' as _i11;
import 'package:travel_aigent/ui/views/register/register_view.dart' as _i10;
import 'package:travel_aigent/ui/views/saved_plans/saved_plans_view.dart'
    as _i9;
import 'package:travel_aigent/ui/views/sign_in/sign_in_view.dart' as _i12;
import 'package:travel_aigent/ui/views/startup/startup_view.dart' as _i3;
import 'package:travel_aigent/ui/views/things_to_do/things_to_do_view.dart'
    as _i21;
import 'package:travel_aigent/ui/views/your_preferences/your_preferences_view.dart'
    as _i22;

class Routes {
  static const homeView = '/home-view';

  static const startupView = '/startup-view';

  static const counterView = '/counter-view';

  static const loginView = '/login-view';

  static const dashboardView = '/dashboard-view';

  static const preferencesView = '/preferences-view';

  static const planView = '/plan-view';

  static const savedPlansView = '/saved-plans-view';

  static const registerView = '/register-view';

  static const profileView = '/profile-view';

  static const signInView = '/sign-in-view';

  static const averagePriceSectionView = '/average-price-section-view';

  static const atAGlaceSectionView = '/at-aglace-section-view';

  static const onBoardingCarouselView = '/on-boarding-carousel-view';

  static const changeNameView = '/change-name-view';

  static const aboutView = '/about-view';

  static const descriptionSectionView = '/description-section-view';

  static const planViewBannerAdView = '/plan-view-banner-ad-view';

  static const planViewNativeAdView = '/plan-view-native-ad-view';

  static const thingsToDoView = '/things-to-do-view';

  static const yourPreferencesView = '/your-preferences-view';

  static const all = <String>{
    homeView,
    startupView,
    counterView,
    loginView,
    dashboardView,
    preferencesView,
    planView,
    savedPlansView,
    registerView,
    profileView,
    signInView,
    averagePriceSectionView,
    atAGlaceSectionView,
    onBoardingCarouselView,
    changeNameView,
    aboutView,
    descriptionSectionView,
    planViewBannerAdView,
    planViewNativeAdView,
    thingsToDoView,
    yourPreferencesView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i3.StartupView,
    ),
    _i1.RouteDef(
      Routes.counterView,
      page: _i4.CounterView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i5.LoginView,
    ),
    _i1.RouteDef(
      Routes.dashboardView,
      page: _i6.DashboardView,
    ),
    _i1.RouteDef(
      Routes.preferencesView,
      page: _i7.PreferencesView,
    ),
    _i1.RouteDef(
      Routes.planView,
      page: _i8.PlanView,
    ),
    _i1.RouteDef(
      Routes.savedPlansView,
      page: _i9.SavedPlansView,
    ),
    _i1.RouteDef(
      Routes.registerView,
      page: _i10.RegisterView,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i11.ProfileView,
    ),
    _i1.RouteDef(
      Routes.signInView,
      page: _i12.SignInView,
    ),
    _i1.RouteDef(
      Routes.averagePriceSectionView,
      page: _i13.AveragePriceSectionView,
    ),
    _i1.RouteDef(
      Routes.atAGlaceSectionView,
      page: _i14.AtAGlaceSectionView,
    ),
    _i1.RouteDef(
      Routes.onBoardingCarouselView,
      page: _i15.OnBoardingCarouselView,
    ),
    _i1.RouteDef(
      Routes.changeNameView,
      page: _i16.ChangeNameView,
    ),
    _i1.RouteDef(
      Routes.aboutView,
      page: _i17.AboutView,
    ),
    _i1.RouteDef(
      Routes.descriptionSectionView,
      page: _i18.DescriptionSectionView,
    ),
    _i1.RouteDef(
      Routes.planViewBannerAdView,
      page: _i19.PlanViewBannerAdView,
    ),
    _i1.RouteDef(
      Routes.planViewNativeAdView,
      page: _i20.PlanViewNativeAdView,
    ),
    _i1.RouteDef(
      Routes.thingsToDoView,
      page: _i21.ThingsToDoView,
    ),
    _i1.RouteDef(
      Routes.yourPreferencesView,
      page: _i22.YourPreferencesView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.StartupView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.StartupView(),
        settings: data,
      );
    },
    _i4.CounterView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.CounterView(),
        settings: data,
      );
    },
    _i5.LoginView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.LoginView(),
        settings: data,
      );
    },
    _i6.DashboardView: (data) {
      final args = data.getArgs<DashboardViewArguments>(
        orElse: () => const DashboardViewArguments(),
      );
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.DashboardView(
            key: args.key, userJustSavedPlan: args.userJustSavedPlan),
        settings: data,
      );
    },
    _i7.PreferencesView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.PreferencesView(),
        settings: data,
      );
    },
    _i8.PlanView: (data) {
      final args = data.getArgs<PlanViewArguments>(
        orElse: () => const PlanViewArguments(),
      );
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i8.PlanView(key: args.key, savedPlan: args.savedPlan),
        settings: data,
      );
    },
    _i9.SavedPlansView: (data) {
      final args = data.getArgs<SavedPlansViewArguments>(nullOk: false);
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.SavedPlansView(
            key: args.key, navigateToHomeView: args.navigateToHomeView),
        settings: data,
      );
    },
    _i10.RegisterView: (data) {
      final args = data.getArgs<RegisterViewArguments>(
        orElse: () => const RegisterViewArguments(),
      );
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => _i10.RegisterView(
            key: args.key,
            navigatedFromRegisterPrompt: args.navigatedFromRegisterPrompt),
        settings: data,
      );
    },
    _i11.ProfileView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.ProfileView(),
        settings: data,
      );
    },
    _i12.SignInView: (data) {
      final args = data.getArgs<SignInViewArguments>(
        orElse: () => const SignInViewArguments(),
      );
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.SignInView(
            key: args.key,
            requiresReauthentication: args.requiresReauthentication,
            showSignUpButton: args.showSignUpButton),
        settings: data,
      );
    },
    _i13.AveragePriceSectionView: (data) {
      final args =
          data.getArgs<AveragePriceSectionViewArguments>(nullOk: false);
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i13.AveragePriceSectionView(key: args.key, plan: args.plan),
        settings: data,
      );
    },
    _i14.AtAGlaceSectionView: (data) {
      final args = data.getArgs<AtAGlaceSectionViewArguments>(nullOk: false);
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => _i14.AtAGlaceSectionView(
            key: args.key, plan: args.plan, destination: args.destination),
        settings: data,
      );
    },
    _i15.OnBoardingCarouselView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => const _i15.OnBoardingCarouselView(),
        settings: data,
      );
    },
    _i16.ChangeNameView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => const _i16.ChangeNameView(),
        settings: data,
      );
    },
    _i17.AboutView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => const _i17.AboutView(),
        settings: data,
      );
    },
    _i18.DescriptionSectionView: (data) {
      final args = data.getArgs<DescriptionSectionViewArguments>(nullOk: false);
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i18.DescriptionSectionView(key: args.key, plan: args.plan),
        settings: data,
      );
    },
    _i19.PlanViewBannerAdView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => const _i19.PlanViewBannerAdView(),
        settings: data,
      );
    },
    _i20.PlanViewNativeAdView: (data) {
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) => const _i20.PlanViewNativeAdView(),
        settings: data,
      );
    },
    _i21.ThingsToDoView: (data) {
      final args = data.getArgs<ThingsToDoViewArguments>(nullOk: false);
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i21.ThingsToDoView(key: args.key, plan: args.plan),
        settings: data,
      );
    },
    _i22.YourPreferencesView: (data) {
      final args = data.getArgs<YourPreferencesViewArguments>(nullOk: false);
      return _i23.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i22.YourPreferencesView(key: args.key, plan: args.plan),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class DashboardViewArguments {
  const DashboardViewArguments({
    this.key,
    this.userJustSavedPlan = false,
  });

  final _i23.Key? key;

  final bool userJustSavedPlan;

  @override
  String toString() {
    return '{"key": "$key", "userJustSavedPlan": "$userJustSavedPlan"}';
  }

  @override
  bool operator ==(covariant DashboardViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.userJustSavedPlan == userJustSavedPlan;
  }

  @override
  int get hashCode {
    return key.hashCode ^ userJustSavedPlan.hashCode;
  }
}

class PlanViewArguments {
  const PlanViewArguments({
    this.key,
    this.savedPlan,
  });

  final _i23.Key? key;

  final _i24.Plan? savedPlan;

  @override
  String toString() {
    return '{"key": "$key", "savedPlan": "$savedPlan"}';
  }

  @override
  bool operator ==(covariant PlanViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.savedPlan == savedPlan;
  }

  @override
  int get hashCode {
    return key.hashCode ^ savedPlan.hashCode;
  }
}

class SavedPlansViewArguments {
  const SavedPlansViewArguments({
    this.key,
    required this.navigateToHomeView,
  });

  final _i23.Key? key;

  final dynamic Function() navigateToHomeView;

  @override
  String toString() {
    return '{"key": "$key", "navigateToHomeView": "$navigateToHomeView"}';
  }

  @override
  bool operator ==(covariant SavedPlansViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.navigateToHomeView == navigateToHomeView;
  }

  @override
  int get hashCode {
    return key.hashCode ^ navigateToHomeView.hashCode;
  }
}

class RegisterViewArguments {
  const RegisterViewArguments({
    this.key,
    this.navigatedFromRegisterPrompt = false,
  });

  final _i23.Key? key;

  final bool navigatedFromRegisterPrompt;

  @override
  String toString() {
    return '{"key": "$key", "navigatedFromRegisterPrompt": "$navigatedFromRegisterPrompt"}';
  }

  @override
  bool operator ==(covariant RegisterViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.navigatedFromRegisterPrompt == navigatedFromRegisterPrompt;
  }

  @override
  int get hashCode {
    return key.hashCode ^ navigatedFromRegisterPrompt.hashCode;
  }
}

class SignInViewArguments {
  const SignInViewArguments({
    this.key,
    this.requiresReauthentication = false,
    this.showSignUpButton = true,
  });

  final _i23.Key? key;

  final bool requiresReauthentication;

  final bool showSignUpButton;

  @override
  String toString() {
    return '{"key": "$key", "requiresReauthentication": "$requiresReauthentication", "showSignUpButton": "$showSignUpButton"}';
  }

  @override
  bool operator ==(covariant SignInViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.requiresReauthentication == requiresReauthentication &&
        other.showSignUpButton == showSignUpButton;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        requiresReauthentication.hashCode ^
        showSignUpButton.hashCode;
  }
}

class AveragePriceSectionViewArguments {
  const AveragePriceSectionViewArguments({
    this.key,
    required this.plan,
  });

  final _i23.Key? key;

  final _i24.Plan? plan;

  @override
  String toString() {
    return '{"key": "$key", "plan": "$plan"}';
  }

  @override
  bool operator ==(covariant AveragePriceSectionViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.plan == plan;
  }

  @override
  int get hashCode {
    return key.hashCode ^ plan.hashCode;
  }
}

class AtAGlaceSectionViewArguments {
  const AtAGlaceSectionViewArguments({
    this.key,
    required this.plan,
    required this.destination,
  });

  final _i23.Key? key;

  final _i24.Plan? plan;

  final _i25.Destination? destination;

  @override
  String toString() {
    return '{"key": "$key", "plan": "$plan", "destination": "$destination"}';
  }

  @override
  bool operator ==(covariant AtAGlaceSectionViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.plan == plan &&
        other.destination == destination;
  }

  @override
  int get hashCode {
    return key.hashCode ^ plan.hashCode ^ destination.hashCode;
  }
}

class DescriptionSectionViewArguments {
  const DescriptionSectionViewArguments({
    this.key,
    required this.plan,
  });

  final _i23.Key? key;

  final _i24.Plan? plan;

  @override
  String toString() {
    return '{"key": "$key", "plan": "$plan"}';
  }

  @override
  bool operator ==(covariant DescriptionSectionViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.plan == plan;
  }

  @override
  int get hashCode {
    return key.hashCode ^ plan.hashCode;
  }
}

class ThingsToDoViewArguments {
  const ThingsToDoViewArguments({
    this.key,
    required this.plan,
  });

  final _i23.Key? key;

  final _i24.Plan? plan;

  @override
  String toString() {
    return '{"key": "$key", "plan": "$plan"}';
  }

  @override
  bool operator ==(covariant ThingsToDoViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.plan == plan;
  }

  @override
  int get hashCode {
    return key.hashCode ^ plan.hashCode;
  }
}

class YourPreferencesViewArguments {
  const YourPreferencesViewArguments({
    this.key,
    required this.plan,
  });

  final _i23.Key? key;

  final _i24.Plan? plan;

  @override
  String toString() {
    return '{"key": "$key", "plan": "$plan"}';
  }

  @override
  bool operator ==(covariant YourPreferencesViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.plan == plan;
  }

  @override
  int get hashCode {
    return key.hashCode ^ plan.hashCode;
  }
}

extension NavigatorStateExtension on _i26.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCounterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.counterView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDashboardView({
    _i23.Key? key,
    bool userJustSavedPlan = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.dashboardView,
        arguments: DashboardViewArguments(
            key: key, userJustSavedPlan: userJustSavedPlan),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPreferencesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.preferencesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPlanView({
    _i23.Key? key,
    _i24.Plan? savedPlan,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.planView,
        arguments: PlanViewArguments(key: key, savedPlan: savedPlan),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSavedPlansView({
    _i23.Key? key,
    required dynamic Function() navigateToHomeView,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.savedPlansView,
        arguments: SavedPlansViewArguments(
            key: key, navigateToHomeView: navigateToHomeView),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRegisterView({
    _i23.Key? key,
    bool navigatedFromRegisterPrompt = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.registerView,
        arguments: RegisterViewArguments(
            key: key, navigatedFromRegisterPrompt: navigatedFromRegisterPrompt),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSignInView({
    _i23.Key? key,
    bool requiresReauthentication = false,
    bool showSignUpButton = true,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.signInView,
        arguments: SignInViewArguments(
            key: key,
            requiresReauthentication: requiresReauthentication,
            showSignUpButton: showSignUpButton),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAveragePriceSectionView({
    _i23.Key? key,
    required _i24.Plan? plan,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.averagePriceSectionView,
        arguments: AveragePriceSectionViewArguments(key: key, plan: plan),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAtAGlaceSectionView({
    _i23.Key? key,
    required _i24.Plan? plan,
    required _i25.Destination? destination,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.atAGlaceSectionView,
        arguments: AtAGlaceSectionViewArguments(
            key: key, plan: plan, destination: destination),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOnBoardingCarouselView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.onBoardingCarouselView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChangeNameView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.changeNameView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAboutView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.aboutView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDescriptionSectionView({
    _i23.Key? key,
    required _i24.Plan? plan,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.descriptionSectionView,
        arguments: DescriptionSectionViewArguments(key: key, plan: plan),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPlanViewBannerAdView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.planViewBannerAdView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPlanViewNativeAdView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.planViewNativeAdView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToThingsToDoView({
    _i23.Key? key,
    required _i24.Plan? plan,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.thingsToDoView,
        arguments: ThingsToDoViewArguments(key: key, plan: plan),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToYourPreferencesView({
    _i23.Key? key,
    required _i24.Plan? plan,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.yourPreferencesView,
        arguments: YourPreferencesViewArguments(key: key, plan: plan),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCounterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.counterView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDashboardView({
    _i23.Key? key,
    bool userJustSavedPlan = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.dashboardView,
        arguments: DashboardViewArguments(
            key: key, userJustSavedPlan: userJustSavedPlan),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPreferencesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.preferencesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPlanView({
    _i23.Key? key,
    _i24.Plan? savedPlan,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.planView,
        arguments: PlanViewArguments(key: key, savedPlan: savedPlan),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSavedPlansView({
    _i23.Key? key,
    required dynamic Function() navigateToHomeView,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.savedPlansView,
        arguments: SavedPlansViewArguments(
            key: key, navigateToHomeView: navigateToHomeView),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRegisterView({
    _i23.Key? key,
    bool navigatedFromRegisterPrompt = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.registerView,
        arguments: RegisterViewArguments(
            key: key, navigatedFromRegisterPrompt: navigatedFromRegisterPrompt),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSignInView({
    _i23.Key? key,
    bool requiresReauthentication = false,
    bool showSignUpButton = true,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.signInView,
        arguments: SignInViewArguments(
            key: key,
            requiresReauthentication: requiresReauthentication,
            showSignUpButton: showSignUpButton),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAveragePriceSectionView({
    _i23.Key? key,
    required _i24.Plan? plan,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.averagePriceSectionView,
        arguments: AveragePriceSectionViewArguments(key: key, plan: plan),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAtAGlaceSectionView({
    _i23.Key? key,
    required _i24.Plan? plan,
    required _i25.Destination? destination,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.atAGlaceSectionView,
        arguments: AtAGlaceSectionViewArguments(
            key: key, plan: plan, destination: destination),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOnBoardingCarouselView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.onBoardingCarouselView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChangeNameView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.changeNameView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAboutView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.aboutView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDescriptionSectionView({
    _i23.Key? key,
    required _i24.Plan? plan,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.descriptionSectionView,
        arguments: DescriptionSectionViewArguments(key: key, plan: plan),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPlanViewBannerAdView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.planViewBannerAdView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPlanViewNativeAdView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.planViewNativeAdView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithThingsToDoView({
    _i23.Key? key,
    required _i24.Plan? plan,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.thingsToDoView,
        arguments: ThingsToDoViewArguments(key: key, plan: plan),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithYourPreferencesView({
    _i23.Key? key,
    required _i24.Plan? plan,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.yourPreferencesView,
        arguments: YourPreferencesViewArguments(key: key, plan: plan),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
