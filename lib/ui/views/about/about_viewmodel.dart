import 'package:package_info_plus/package_info_plus.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutViewModel extends BaseViewModel {
  String version = '';

  AboutViewModel() {
    init();
  }

  Future<void> init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    rebuildUi();
  }

  void onStorySetLinkTapped() {
    launchUrl(Uri.parse('https://www.storyset.com'));
  }

  void onOpenSourceLinkTapped(String url) {
    launchUrl(Uri.parse(url));
  }
}
