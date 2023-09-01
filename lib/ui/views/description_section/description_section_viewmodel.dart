import 'package:stacked/stacked.dart';

class DescriptionSectionViewModel extends BaseViewModel {
  bool descriptionIsExpanded = false;

  void onReadMoreTap() {
    descriptionIsExpanded = !descriptionIsExpanded;
    rebuildUi();
  }
}
