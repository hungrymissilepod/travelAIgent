import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/services/firebase_user_service.dart';
import 'package:travel_aigent/services/firestore_service.dart';
import 'package:travel_aigent/services/hive_service.dart';
import 'package:travel_aigent/services/who_am_i_service.dart';

enum DeleteAccountDialogSection { failedToDelete }

const String requiresRecentLogin = 'requires-recent-login';

class DeleteUserDialogModel extends BaseViewModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final FirebaseUserService _firebaseUserService =
      locator<FirebaseUserService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final WhoAmIService _whoAmIService = locator<WhoAmIService>();
  final HiveService _hiveService = locator<HiveService>();

  void onCancelTap() {
    _navigationService.back();
  }

  /// Delete user account and all data associated with them
  /// If we fail at any step we will show an error message to the user
  /// saying that they should contact us to delete their account
  Future<void> deleteUser() async {
    clearErrors();
    final String? userId = _firebaseUserService.user?.uid;

    /// First try to delete user collection
    final bool deletedUser =
        await runBusyFuture(_firestoreService.deleteUserCollection(userId));
    if (!deletedUser) {
      setErrorForObject(DeleteAccountDialogSection.failedToDelete, true);
      return;
    }

    /// Then try to delete user plan collection
    final bool deletedUserPlans =
        await runBusyFuture(_firestoreService.deleteUserPlanCollection(userId));
    if (!deletedUserPlans) {
      setErrorForObject(DeleteAccountDialogSection.failedToDelete, true);
      return;
    }

    /// Then try to delete user
    /// This can return with errors so we need to handle them
    final String? errorMessage =
        await runBusyFuture(_firebaseUserService.deleteUser());
    if (errorMessage != null) {
      setErrorForObject(
          DeleteAccountDialogSection.failedToDelete, errorMessage);
    }
    await _hiveService.clear();
    _whoAmIService.reset();
    _navigationService.clearStackAndShow(Routes.startupView);
  }

  String getErrorMessage() {
    switch (error(DeleteAccountDialogSection.failedToDelete)) {
      case requiresRecentLogin:
        return 'Failed to delete account.\n\nFor security reasons we require you to re-login before you can delete your account.';
      default:
        return 'An error occured while trying to delete your account.\n\nPlease contact us at the email below to delete your account:\n\njake.kinglee@gmail.com';
    }
  }

  String getButtonErrorLabel() {
    switch (error(DeleteAccountDialogSection.failedToDelete)) {
      case requiresRecentLogin:
        return 'Login';
      default:
        return 'Cancel';
    }
  }

  void onErrorButtonTapped() {
    switch (error(DeleteAccountDialogSection.failedToDelete)) {
      case requiresRecentLogin:
        _navigationService.clearStackAndShow(
          Routes.signInView,
          arguments: const SignInViewArguments(requiresReauthentication: true),
        );
        return;
      default:
        _navigationService.back();
        return;
    }
  }
}
