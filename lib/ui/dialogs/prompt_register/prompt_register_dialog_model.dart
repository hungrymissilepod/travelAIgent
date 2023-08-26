import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.router.dart';

class PromptRegisterDialogModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future<bool> onSignUpWithEmailTap() async {
    dynamic result = await _navigationService.navigateTo(
      Routes.registerView,
      preventDuplicates: false,
      arguments: const RegisterViewArguments(navigatedFromRegisterPrompt: true),
    );

    if (result is bool) {
      return result;
    }
    return false;
  }
}
