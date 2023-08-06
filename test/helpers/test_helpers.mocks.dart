// Mocks generated by Mockito 5.4.2 from annotations
// in travel_aigent/test/helpers/test_helpers.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i11;
import 'dart:ui' as _i12;

import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:dart_openai/dart_openai.dart' as _i17;
import 'package:dio/dio.dart' as _i2;
import 'package:flutter/material.dart' as _i10;
import 'package:mockito/mockito.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i9;
import 'package:travel_aigent/models/destination_model.dart' as _i3;
import 'package:travel_aigent/models/plan_model.dart' as _i5;
import 'package:travel_aigent/models/preferences_model.dart' as _i4;
import 'package:travel_aigent/models/who_am_i_model.dart' as _i8;
import 'package:travel_aigent/services/ai_service.dart' as _i16;
import 'package:travel_aigent/services/authentication_service.dart' as _i13;
import 'package:travel_aigent/services/dio_service.dart' as _i14;
import 'package:travel_aigent/services/firestore_service.dart' as _i19;
import 'package:travel_aigent/services/generator_service.dart' as _i18;
import 'package:travel_aigent/services/web_scraper_service.dart' as _i15;
import 'package:travel_aigent/services/who_am_i_service.dart' as _i20;
import 'package:uuid/uuid.dart' as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeResponse_0<T> extends _i1.SmartFake implements _i2.Response<T> {
  _FakeResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDestination_1 extends _i1.SmartFake implements _i3.Destination {
  _FakeDestination_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePreferences_2 extends _i1.SmartFake implements _i4.Preferences {
  _FakePreferences_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePlan_3 extends _i1.SmartFake implements _i5.Plan {
  _FakePlan_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCollectionReference_4<T extends Object?> extends _i1.SmartFake
    implements _i6.CollectionReference<T> {
  _FakeCollectionReference_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUuid_5 extends _i1.SmartFake implements _i7.Uuid {
  _FakeUuid_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWhoAmI_6 extends _i1.SmartFake implements _i8.WhoAmI {
  _FakeWhoAmI_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [NavigationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockNavigationService extends _i1.Mock implements _i9.NavigationService {
  @override
  String get previousRoute => (super.noSuchMethod(
        Invocation.getter(#previousRoute),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  String get currentRoute => (super.noSuchMethod(
        Invocation.getter(#currentRoute),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  _i10.GlobalKey<_i10.NavigatorState>? nestedNavigationKey(int? index) =>
      (super.noSuchMethod(
        Invocation.method(
          #nestedNavigationKey,
          [index],
        ),
        returnValueForMissingStub: null,
      ) as _i10.GlobalKey<_i10.NavigatorState>?);
  @override
  void config({
    bool? enableLog,
    bool? defaultPopGesture,
    bool? defaultOpaqueRoute,
    Duration? defaultDurationTransition,
    bool? defaultGlobalState,
    _i9.Transition? defaultTransitionStyle,
    String? defaultTransition,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #config,
          [],
          {
            #enableLog: enableLog,
            #defaultPopGesture: defaultPopGesture,
            #defaultOpaqueRoute: defaultOpaqueRoute,
            #defaultDurationTransition: defaultDurationTransition,
            #defaultGlobalState: defaultGlobalState,
            #defaultTransitionStyle: defaultTransitionStyle,
            #defaultTransition: defaultTransition,
          },
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i11.Future<T?>? navigateWithTransition<T>(
    _i10.Widget? page, {
    bool? opaque,
    String? transition = r'',
    Duration? duration,
    bool? popGesture,
    int? id,
    _i10.Curve? curve,
    bool? fullscreenDialog = false,
    bool? preventDuplicates = true,
    _i9.Transition? transitionClass,
    _i9.Transition? transitionStyle,
    String? routeName,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #navigateWithTransition,
          [page],
          {
            #opaque: opaque,
            #transition: transition,
            #duration: duration,
            #popGesture: popGesture,
            #id: id,
            #curve: curve,
            #fullscreenDialog: fullscreenDialog,
            #preventDuplicates: preventDuplicates,
            #transitionClass: transitionClass,
            #transitionStyle: transitionStyle,
            #routeName: routeName,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i11.Future<T?>?);
  @override
  _i11.Future<T?>? replaceWithTransition<T>(
    _i10.Widget? page, {
    bool? opaque,
    String? transition = r'',
    Duration? duration,
    bool? popGesture,
    int? id,
    _i10.Curve? curve,
    bool? fullscreenDialog = false,
    bool? preventDuplicates = true,
    _i9.Transition? transitionClass,
    _i9.Transition? transitionStyle,
    String? routeName,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #replaceWithTransition,
          [page],
          {
            #opaque: opaque,
            #transition: transition,
            #duration: duration,
            #popGesture: popGesture,
            #id: id,
            #curve: curve,
            #fullscreenDialog: fullscreenDialog,
            #preventDuplicates: preventDuplicates,
            #transitionClass: transitionClass,
            #transitionStyle: transitionStyle,
            #routeName: routeName,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i11.Future<T?>?);
  @override
  bool back<T>({
    dynamic result,
    int? id,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #back,
          [],
          {
            #result: result,
            #id: id,
          },
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  void popUntil(
    _i10.RoutePredicate? predicate, {
    int? id,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #popUntil,
          [predicate],
          {#id: id},
        ),
        returnValueForMissingStub: null,
      );
  @override
  void popRepeated(int? popTimes) => super.noSuchMethod(
        Invocation.method(
          #popRepeated,
          [popTimes],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i11.Future<T?>? navigateTo<T>(
    String? routeName, {
    dynamic arguments,
    int? id,
    bool? preventDuplicates = true,
    Map<String, String>? parameters,
    _i10.RouteTransitionsBuilder? transition,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #navigateTo,
          [routeName],
          {
            #arguments: arguments,
            #id: id,
            #preventDuplicates: preventDuplicates,
            #parameters: parameters,
            #transition: transition,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i11.Future<T?>?);
  @override
  _i11.Future<T?>? navigateToView<T>(
    _i10.Widget? view, {
    dynamic arguments,
    int? id,
    bool? opaque,
    _i10.Curve? curve,
    Duration? duration,
    bool? fullscreenDialog = false,
    bool? popGesture,
    bool? preventDuplicates = true,
    _i9.Transition? transition,
    _i9.Transition? transitionStyle,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #navigateToView,
          [view],
          {
            #arguments: arguments,
            #id: id,
            #opaque: opaque,
            #curve: curve,
            #duration: duration,
            #fullscreenDialog: fullscreenDialog,
            #popGesture: popGesture,
            #preventDuplicates: preventDuplicates,
            #transition: transition,
            #transitionStyle: transitionStyle,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i11.Future<T?>?);
  @override
  _i11.Future<T?>? replaceWith<T>(
    String? routeName, {
    dynamic arguments,
    int? id,
    bool? preventDuplicates = true,
    Map<String, String>? parameters,
    _i10.RouteTransitionsBuilder? transition,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #replaceWith,
          [routeName],
          {
            #arguments: arguments,
            #id: id,
            #preventDuplicates: preventDuplicates,
            #parameters: parameters,
            #transition: transition,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i11.Future<T?>?);
  @override
  _i11.Future<T?>? clearStackAndShow<T>(
    String? routeName, {
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #clearStackAndShow,
          [routeName],
          {
            #arguments: arguments,
            #id: id,
            #parameters: parameters,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i11.Future<T?>?);
  @override
  _i11.Future<T?>? clearStackAndShowView<T>(
    _i10.Widget? view, {
    dynamic arguments,
    int? id,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #clearStackAndShowView,
          [view],
          {
            #arguments: arguments,
            #id: id,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i11.Future<T?>?);
  @override
  _i11.Future<T?>? clearTillFirstAndShow<T>(
    String? routeName, {
    dynamic arguments,
    int? id,
    bool? preventDuplicates = true,
    Map<String, String>? parameters,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #clearTillFirstAndShow,
          [routeName],
          {
            #arguments: arguments,
            #id: id,
            #preventDuplicates: preventDuplicates,
            #parameters: parameters,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i11.Future<T?>?);
  @override
  _i11.Future<T?>? clearTillFirstAndShowView<T>(
    _i10.Widget? view, {
    dynamic arguments,
    int? id,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #clearTillFirstAndShowView,
          [view],
          {
            #arguments: arguments,
            #id: id,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i11.Future<T?>?);
  @override
  _i11.Future<T?>? pushNamedAndRemoveUntil<T>(
    String? routeName, {
    _i10.RoutePredicate? predicate,
    dynamic arguments,
    int? id,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #pushNamedAndRemoveUntil,
          [routeName],
          {
            #predicate: predicate,
            #arguments: arguments,
            #id: id,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i11.Future<T?>?);
}

/// A class which mocks [BottomSheetService].
///
/// See the documentation for Mockito's code generation for more information.
class MockBottomSheetService extends _i1.Mock
    implements _i9.BottomSheetService {
  @override
  void setCustomSheetBuilders(Map<dynamic, _i9.SheetBuilder>? builders) =>
      super.noSuchMethod(
        Invocation.method(
          #setCustomSheetBuilders,
          [builders],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i11.Future<_i9.SheetResponse<dynamic>?> showBottomSheet({
    required String? title,
    String? description,
    String? confirmButtonTitle = r'Ok',
    String? cancelButtonTitle,
    bool? enableDrag = true,
    bool? barrierDismissible = true,
    bool? isScrollControlled = false,
    Duration? exitBottomSheetDuration,
    Duration? enterBottomSheetDuration,
    bool? ignoreSafeArea,
    bool? useRootNavigator = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #showBottomSheet,
          [],
          {
            #title: title,
            #description: description,
            #confirmButtonTitle: confirmButtonTitle,
            #cancelButtonTitle: cancelButtonTitle,
            #enableDrag: enableDrag,
            #barrierDismissible: barrierDismissible,
            #isScrollControlled: isScrollControlled,
            #exitBottomSheetDuration: exitBottomSheetDuration,
            #enterBottomSheetDuration: enterBottomSheetDuration,
            #ignoreSafeArea: ignoreSafeArea,
            #useRootNavigator: useRootNavigator,
          },
        ),
        returnValue: _i11.Future<_i9.SheetResponse<dynamic>?>.value(),
        returnValueForMissingStub:
            _i11.Future<_i9.SheetResponse<dynamic>?>.value(),
      ) as _i11.Future<_i9.SheetResponse<dynamic>?>);
  @override
  _i11.Future<_i9.SheetResponse<T>?> showCustomSheet<T, R>({
    dynamic variant,
    String? title,
    String? description,
    bool? hasImage = false,
    String? imageUrl,
    bool? showIconInMainButton = false,
    String? mainButtonTitle,
    bool? showIconInSecondaryButton = false,
    String? secondaryButtonTitle,
    bool? showIconInAdditionalButton = false,
    String? additionalButtonTitle,
    bool? takesInput = false,
    _i12.Color? barrierColor = const _i12.Color(2315255808),
    bool? barrierDismissible = true,
    bool? isScrollControlled = false,
    String? barrierLabel = r'',
    dynamic customData,
    R? data,
    bool? enableDrag = true,
    Duration? exitBottomSheetDuration,
    Duration? enterBottomSheetDuration,
    bool? ignoreSafeArea,
    bool? useRootNavigator = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #showCustomSheet,
          [],
          {
            #variant: variant,
            #title: title,
            #description: description,
            #hasImage: hasImage,
            #imageUrl: imageUrl,
            #showIconInMainButton: showIconInMainButton,
            #mainButtonTitle: mainButtonTitle,
            #showIconInSecondaryButton: showIconInSecondaryButton,
            #secondaryButtonTitle: secondaryButtonTitle,
            #showIconInAdditionalButton: showIconInAdditionalButton,
            #additionalButtonTitle: additionalButtonTitle,
            #takesInput: takesInput,
            #barrierColor: barrierColor,
            #barrierDismissible: barrierDismissible,
            #isScrollControlled: isScrollControlled,
            #barrierLabel: barrierLabel,
            #customData: customData,
            #data: data,
            #enableDrag: enableDrag,
            #exitBottomSheetDuration: exitBottomSheetDuration,
            #enterBottomSheetDuration: enterBottomSheetDuration,
            #ignoreSafeArea: ignoreSafeArea,
            #useRootNavigator: useRootNavigator,
          },
        ),
        returnValue: _i11.Future<_i9.SheetResponse<T>?>.value(),
        returnValueForMissingStub: _i11.Future<_i9.SheetResponse<T>?>.value(),
      ) as _i11.Future<_i9.SheetResponse<T>?>);
  @override
  void completeSheet(_i9.SheetResponse<dynamic>? response) =>
      super.noSuchMethod(
        Invocation.method(
          #completeSheet,
          [response],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [DialogService].
///
/// See the documentation for Mockito's code generation for more information.
class MockDialogService extends _i1.Mock implements _i9.DialogService {
  @override
  void registerCustomDialogBuilders(
          Map<dynamic, _i9.DialogBuilder>? builders) =>
      super.noSuchMethod(
        Invocation.method(
          #registerCustomDialogBuilders,
          [builders],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void registerCustomDialogBuilder({
    required dynamic variant,
    required _i10.Widget Function(
      _i10.BuildContext,
      _i9.DialogRequest<dynamic>,
      dynamic Function(_i9.DialogResponse<dynamic>),
    )? builder,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #registerCustomDialogBuilder,
          [],
          {
            #variant: variant,
            #builder: builder,
          },
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i11.Future<_i9.DialogResponse<dynamic>?> showDialog({
    String? title,
    String? description,
    String? cancelTitle,
    _i12.Color? cancelTitleColor,
    String? buttonTitle = r'Ok',
    _i12.Color? buttonTitleColor,
    bool? barrierDismissible = false,
    _i9.DialogPlatform? dialogPlatform,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #showDialog,
          [],
          {
            #title: title,
            #description: description,
            #cancelTitle: cancelTitle,
            #cancelTitleColor: cancelTitleColor,
            #buttonTitle: buttonTitle,
            #buttonTitleColor: buttonTitleColor,
            #barrierDismissible: barrierDismissible,
            #dialogPlatform: dialogPlatform,
          },
        ),
        returnValue: _i11.Future<_i9.DialogResponse<dynamic>?>.value(),
        returnValueForMissingStub:
            _i11.Future<_i9.DialogResponse<dynamic>?>.value(),
      ) as _i11.Future<_i9.DialogResponse<dynamic>?>);
  @override
  _i11.Future<_i9.DialogResponse<T>?> showCustomDialog<T, R>({
    dynamic variant,
    String? title,
    String? description,
    bool? hasImage = false,
    String? imageUrl,
    bool? showIconInMainButton = false,
    String? mainButtonTitle,
    bool? showIconInSecondaryButton = false,
    String? secondaryButtonTitle,
    bool? showIconInAdditionalButton = false,
    String? additionalButtonTitle,
    bool? takesInput = false,
    _i12.Color? barrierColor = const _i12.Color(2315255808),
    bool? barrierDismissible = false,
    String? barrierLabel = r'',
    bool? useSafeArea = true,
    dynamic customData,
    R? data,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #showCustomDialog,
          [],
          {
            #variant: variant,
            #title: title,
            #description: description,
            #hasImage: hasImage,
            #imageUrl: imageUrl,
            #showIconInMainButton: showIconInMainButton,
            #mainButtonTitle: mainButtonTitle,
            #showIconInSecondaryButton: showIconInSecondaryButton,
            #secondaryButtonTitle: secondaryButtonTitle,
            #showIconInAdditionalButton: showIconInAdditionalButton,
            #additionalButtonTitle: additionalButtonTitle,
            #takesInput: takesInput,
            #barrierColor: barrierColor,
            #barrierDismissible: barrierDismissible,
            #barrierLabel: barrierLabel,
            #useSafeArea: useSafeArea,
            #customData: customData,
            #data: data,
          },
        ),
        returnValue: _i11.Future<_i9.DialogResponse<T>?>.value(),
        returnValueForMissingStub: _i11.Future<_i9.DialogResponse<T>?>.value(),
      ) as _i11.Future<_i9.DialogResponse<T>?>);
  @override
  _i11.Future<_i9.DialogResponse<dynamic>?> showConfirmationDialog({
    String? title,
    String? description,
    String? cancelTitle = r'Cancel',
    _i12.Color? cancelTitleColor,
    String? confirmationTitle = r'Ok',
    _i12.Color? confirmationTitleColor,
    bool? barrierDismissible = false,
    _i9.DialogPlatform? dialogPlatform,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #showConfirmationDialog,
          [],
          {
            #title: title,
            #description: description,
            #cancelTitle: cancelTitle,
            #cancelTitleColor: cancelTitleColor,
            #confirmationTitle: confirmationTitle,
            #confirmationTitleColor: confirmationTitleColor,
            #barrierDismissible: barrierDismissible,
            #dialogPlatform: dialogPlatform,
          },
        ),
        returnValue: _i11.Future<_i9.DialogResponse<dynamic>?>.value(),
        returnValueForMissingStub:
            _i11.Future<_i9.DialogResponse<dynamic>?>.value(),
      ) as _i11.Future<_i9.DialogResponse<dynamic>?>);
  @override
  void completeDialog(_i9.DialogResponse<dynamic>? response) =>
      super.noSuchMethod(
        Invocation.method(
          #completeDialog,
          [response],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [AuthenticationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthenticationService extends _i1.Mock
    implements _i13.AuthenticationService {
  @override
  void init() => super.noSuchMethod(
        Invocation.method(
          #init,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool userLoggedIn() => (super.noSuchMethod(
        Invocation.method(
          #userLoggedIn,
          [],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  _i11.Future<String?> registerWithEmailAndPassword(
    String? name,
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #registerWithEmailAndPassword,
          [
            name,
            email,
            password,
          ],
        ),
        returnValue: _i11.Future<String?>.value(),
        returnValueForMissingStub: _i11.Future<String?>.value(),
      ) as _i11.Future<String?>);
  @override
  _i11.Future<String?> signInWithEmailAndPassword(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #signInWithEmailAndPassword,
          [
            email,
            password,
          ],
        ),
        returnValue: _i11.Future<String?>.value(),
        returnValueForMissingStub: _i11.Future<String?>.value(),
      ) as _i11.Future<String?>);
  @override
  _i11.Future<void> signOut() => (super.noSuchMethod(
        Invocation.method(
          #signOut,
          [],
        ),
        returnValue: _i11.Future<void>.value(),
        returnValueForMissingStub: _i11.Future<void>.value(),
      ) as _i11.Future<void>);
}

/// A class which mocks [DioService].
///
/// See the documentation for Mockito's code generation for more information.
class MockDioService extends _i1.Mock implements _i14.DioService {
  @override
  _i11.Future<_i2.Response<dynamic>> get(
    String? url, {
    Map<String, dynamic>? parameters,
    bool? printResponse = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {
            #parameters: parameters,
            #printResponse: printResponse,
          },
        ),
        returnValue:
            _i11.Future<_i2.Response<dynamic>>.value(_FakeResponse_0<dynamic>(
          this,
          Invocation.method(
            #get,
            [url],
            {
              #parameters: parameters,
              #printResponse: printResponse,
            },
          ),
        )),
        returnValueForMissingStub:
            _i11.Future<_i2.Response<dynamic>>.value(_FakeResponse_0<dynamic>(
          this,
          Invocation.method(
            #get,
            [url],
            {
              #parameters: parameters,
              #printResponse: printResponse,
            },
          ),
        )),
      ) as _i11.Future<_i2.Response<dynamic>>);
  @override
  _i11.Future<_i2.Response<dynamic>> post(
    String? url, {
    Map<String, dynamic>? parameters,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {#parameters: parameters},
        ),
        returnValue:
            _i11.Future<_i2.Response<dynamic>>.value(_FakeResponse_0<dynamic>(
          this,
          Invocation.method(
            #post,
            [url],
            {#parameters: parameters},
          ),
        )),
        returnValueForMissingStub:
            _i11.Future<_i2.Response<dynamic>>.value(_FakeResponse_0<dynamic>(
          this,
          Invocation.method(
            #post,
            [url],
            {#parameters: parameters},
          ),
        )),
      ) as _i11.Future<_i2.Response<dynamic>>);
  @override
  _i11.Future<_i2.Response<dynamic>> put(
    String? url, {
    Map<String, dynamic>? parameters,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {#parameters: parameters},
        ),
        returnValue:
            _i11.Future<_i2.Response<dynamic>>.value(_FakeResponse_0<dynamic>(
          this,
          Invocation.method(
            #put,
            [url],
            {#parameters: parameters},
          ),
        )),
        returnValueForMissingStub:
            _i11.Future<_i2.Response<dynamic>>.value(_FakeResponse_0<dynamic>(
          this,
          Invocation.method(
            #put,
            [url],
            {#parameters: parameters},
          ),
        )),
      ) as _i11.Future<_i2.Response<dynamic>>);
  @override
  _i11.Future<_i2.Response<dynamic>> patch(
    String? url, {
    Map<String, dynamic>? parameters,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {#parameters: parameters},
        ),
        returnValue:
            _i11.Future<_i2.Response<dynamic>>.value(_FakeResponse_0<dynamic>(
          this,
          Invocation.method(
            #patch,
            [url],
            {#parameters: parameters},
          ),
        )),
        returnValueForMissingStub:
            _i11.Future<_i2.Response<dynamic>>.value(_FakeResponse_0<dynamic>(
          this,
          Invocation.method(
            #patch,
            [url],
            {#parameters: parameters},
          ),
        )),
      ) as _i11.Future<_i2.Response<dynamic>>);
}

/// A class which mocks [WebScraperService].
///
/// See the documentation for Mockito's code generation for more information.
class MockWebScraperService extends _i1.Mock implements _i15.WebScraperService {
  @override
  _i11.Future<String> getWikipediaLargeImageUrlFromSearch(String? searchTerm) =>
      (super.noSuchMethod(
        Invocation.method(
          #getWikipediaLargeImageUrlFromSearch,
          [searchTerm],
        ),
        returnValue: _i11.Future<String>.value(''),
        returnValueForMissingStub: _i11.Future<String>.value(''),
      ) as _i11.Future<String>);
  @override
  _i11.Future<String> getWikipediaImageSmall(String? searchTerm) =>
      (super.noSuchMethod(
        Invocation.method(
          #getWikipediaImageSmall,
          [searchTerm],
        ),
        returnValue: _i11.Future<String>.value(''),
        returnValueForMissingStub: _i11.Future<String>.value(''),
      ) as _i11.Future<String>);
  @override
  _i11.Future<String> getWikipediaImageLarge(String? searchTerm) =>
      (super.noSuchMethod(
        Invocation.method(
          #getWikipediaImageLarge,
          [searchTerm],
        ),
        returnValue: _i11.Future<String>.value(''),
        returnValueForMissingStub: _i11.Future<String>.value(''),
      ) as _i11.Future<String>);
}

/// A class which mocks [AiService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAiService extends _i1.Mock implements _i16.AiService {
  @override
  _i11.Future<String> request(
    String? prompt,
    int? maxTokens, {
    List<_i17.OpenAIFunctionModel>? functions,
    _i17.FunctionCall? functionCall = _i17.FunctionCall.none,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #request,
          [
            prompt,
            maxTokens,
          ],
          {
            #functions: functions,
            #functionCall: functionCall,
          },
        ),
        returnValue: _i11.Future<String>.value(''),
        returnValueForMissingStub: _i11.Future<String>.value(''),
      ) as _i11.Future<String>);
}

/// A class which mocks [GeneratorService].
///
/// See the documentation for Mockito's code generation for more information.
class MockGeneratorService extends _i1.Mock implements _i18.GeneratorService {
  @override
  _i3.Destination get destination => (super.noSuchMethod(
        Invocation.getter(#destination),
        returnValue: _FakeDestination_1(
          this,
          Invocation.getter(#destination),
        ),
        returnValueForMissingStub: _FakeDestination_1(
          this,
          Invocation.getter(#destination),
        ),
      ) as _i3.Destination);
  @override
  _i4.Preferences get preferences => (super.noSuchMethod(
        Invocation.getter(#preferences),
        returnValue: _FakePreferences_2(
          this,
          Invocation.getter(#preferences),
        ),
        returnValueForMissingStub: _FakePreferences_2(
          this,
          Invocation.getter(#preferences),
        ),
      ) as _i4.Preferences);
  @override
  void setDestination(_i3.Destination? destination) => super.noSuchMethod(
        Invocation.method(
          #setDestination,
          [destination],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setPreferences(_i4.Preferences? preferences) => super.noSuchMethod(
        Invocation.method(
          #setPreferences,
          [preferences],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addToBlacklistedCities(String? city) => super.noSuchMethod(
        Invocation.method(
          #addToBlacklistedCities,
          [city],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i11.Future<_i5.Plan> generatePlan() => (super.noSuchMethod(
        Invocation.method(
          #generatePlan,
          [],
        ),
        returnValue: _i11.Future<_i5.Plan>.value(_FakePlan_3(
          this,
          Invocation.method(
            #generatePlan,
            [],
          ),
        )),
        returnValueForMissingStub: _i11.Future<_i5.Plan>.value(_FakePlan_3(
          this,
          Invocation.method(
            #generatePlan,
            [],
          ),
        )),
      ) as _i11.Future<_i5.Plan>);
}

/// A class which mocks [FirestoreService].
///
/// See the documentation for Mockito's code generation for more information.
class MockFirestoreService extends _i1.Mock implements _i19.FirestoreService {
  @override
  _i6.CollectionReference<Object?> get usersCollection => (super.noSuchMethod(
        Invocation.getter(#usersCollection),
        returnValue: _FakeCollectionReference_4<Object?>(
          this,
          Invocation.getter(#usersCollection),
        ),
        returnValueForMissingStub: _FakeCollectionReference_4<Object?>(
          this,
          Invocation.getter(#usersCollection),
        ),
      ) as _i6.CollectionReference<Object?>);
  @override
  _i6.CollectionReference<Object?> get plansCollection => (super.noSuchMethod(
        Invocation.getter(#plansCollection),
        returnValue: _FakeCollectionReference_4<Object?>(
          this,
          Invocation.getter(#plansCollection),
        ),
        returnValueForMissingStub: _FakeCollectionReference_4<Object?>(
          this,
          Invocation.getter(#plansCollection),
        ),
      ) as _i6.CollectionReference<Object?>);
  @override
  _i7.Uuid get uuid => (super.noSuchMethod(
        Invocation.getter(#uuid),
        returnValue: _FakeUuid_5(
          this,
          Invocation.getter(#uuid),
        ),
        returnValueForMissingStub: _FakeUuid_5(
          this,
          Invocation.getter(#uuid),
        ),
      ) as _i7.Uuid);
  @override
  _i11.Future<bool> addUser(
    String? userId,
    String? name,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addUser,
          [
            userId,
            name,
          ],
        ),
        returnValue: _i11.Future<bool>.value(false),
        returnValueForMissingStub: _i11.Future<bool>.value(false),
      ) as _i11.Future<bool>);
  @override
  _i11.Future<void> getUser() => (super.noSuchMethod(
        Invocation.method(
          #getUser,
          [],
        ),
        returnValue: _i11.Future<void>.value(),
        returnValueForMissingStub: _i11.Future<void>.value(),
      ) as _i11.Future<void>);
  @override
  _i11.Future<bool> addPlan(_i5.Plan? plan) => (super.noSuchMethod(
        Invocation.method(
          #addPlan,
          [plan],
        ),
        returnValue: _i11.Future<bool>.value(false),
        returnValueForMissingStub: _i11.Future<bool>.value(false),
      ) as _i11.Future<bool>);
}

/// A class which mocks [WhoAmIService].
///
/// See the documentation for Mockito's code generation for more information.
class MockWhoAmIService extends _i1.Mock implements _i20.WhoAmIService {
  @override
  _i8.WhoAmI get whoAmI => (super.noSuchMethod(
        Invocation.getter(#whoAmI),
        returnValue: _FakeWhoAmI_6(
          this,
          Invocation.getter(#whoAmI),
        ),
        returnValueForMissingStub: _FakeWhoAmI_6(
          this,
          Invocation.getter(#whoAmI),
        ),
      ) as _i8.WhoAmI);
  @override
  set whoAmI(_i8.WhoAmI? _whoAmI) => super.noSuchMethod(
        Invocation.setter(
          #whoAmI,
          _whoAmI,
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setName(String? name) => super.noSuchMethod(
        Invocation.method(
          #setName,
          [name],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setWhoAmI(Map<String, dynamic>? data) => super.noSuchMethod(
        Invocation.method(
          #setWhoAmI,
          [data],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addPlan(_i5.Plan? plan) => super.noSuchMethod(
        Invocation.method(
          #addPlan,
          [plan],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void reset() => super.noSuchMethod(
        Invocation.method(
          #reset,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
