import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:separated_column/separated_column.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/common/common_app_bar.dart';
import 'package:travel_aigent/ui/common/common_safe_area.dart';

import 'package:travel_aigent/ui/views/profile/ui/profile_section_header.dart';

import 'about_viewmodel.dart';

List<OpenSourceLibrary> _libraries = <OpenSourceLibrary>[
  OpenSourceLibrary('stacked', 'filledstacks.com', 'https://pub.dev/packages/stacked'),
  OpenSourceLibrary('stacked_services', 'filledstacks.com', 'https://pub.dev/packages/stacked_services'),
  OpenSourceLibrary('stacked_themes', 'filledstacks.com', 'https://pub.dev/packages/stacked_themes'),
  OpenSourceLibrary('dio', 'flutter.cn', 'https://pub.dev/packages/dio'),
  OpenSourceLibrary('logger', 'unknown', 'https://pub.dev/packages/logger'),
  OpenSourceLibrary('flutter_dotenv', 'unknown', 'https://pub.dev/packages/flutter_dotenv'),
  OpenSourceLibrary('hive', 'isar.dev', 'https://pub.dev/packages/hive'),
  OpenSourceLibrary('firebase_core', 'firebase.google.com', 'https://pub.dev/packages/firebase_core'),
  OpenSourceLibrary('firebase_auth', 'firebase.google.com', 'https://pub.dev/packages/firebase_auth'),
  OpenSourceLibrary('firebase_analytics', 'firebase.google.com', 'https://pub.dev/packages/firebase_analytics'),
  OpenSourceLibrary('firebase_crashlytics', 'firebase.google.com', 'https://pub.dev/packages/firebase_crashlytics'),
  OpenSourceLibrary('cloud_firestore', 'firebase.google.com', 'https://pub.dev/packages/cloud_firestore'),
  OpenSourceLibrary('font_awesome_flutter', 'fluttercommunity.dev', 'https://pub.dev/packages/font_awesome_flutter'),
  OpenSourceLibrary('simple_chips_input', 'shourya.floatingpoint.co.in', 'https://pub.dev/packages/simple_chips_input'),
  OpenSourceLibrary('easy_autocomplete', '4inka.com', 'https://pub.dev/packages/easy_autocomplete'),
  OpenSourceLibrary('dart_countries', 'unknown', 'https://pub.dev/packages/dart_countries'),
  OpenSourceLibrary('dart_openai', 'gwhyyy.com', 'https://pub.dev/packages/dart_openai'),
  OpenSourceLibrary('html', 'tools.dart.dev', 'https://pub.dev/packages/html'),
  OpenSourceLibrary('beautiful_soup_dart', 'unknown', 'https://pub.dev/packages/beautiful_soup_dart'),
  OpenSourceLibrary('flutter_svg', 'dnfield.dev', 'https://pub.dev/packages/flutter_svg'),
  OpenSourceLibrary('percent_indicator', 'diegoveloper.com', 'https://pub.dev/packages/percent_indicator'),
  OpenSourceLibrary('intl', 'dart.def', 'https://pub.dev/packages/intl'),
  OpenSourceLibrary('calendar_date_picker2', 'unknown', 'https://pub.dev/packages/calendar_date_picker2'),
  OpenSourceLibrary('json_annotation', 'google.dev', 'https://pub.dev/packages/json_annotation'),
  OpenSourceLibrary('separated_column', 'unknown', 'https://pub.dev/packages/separated_column'),
  OpenSourceLibrary('email_validator', 'unknown', 'https://pub.dev/packages/email_validator'),
  OpenSourceLibrary('uuid', 'yuli.dev', 'https://pub.dev/packages/uuid'),
  OpenSourceLibrary('fancy_password_field', 'rodrigobastos.dev', 'https://pub.dev/packages/fancy_password_field'),
  OpenSourceLibrary('path_provider', 'flutter.dev', 'https://pub.dev/packages/path_provider'),
  OpenSourceLibrary('fuzzywuzzy', 'sphericalk.at', 'https://pub.dev/packages/fuzzywuzzy'),
  OpenSourceLibrary('equatable', 'fluttercommunity.dev', 'https://pub.dev/packages/equatable'),
  OpenSourceLibrary('lottie', 'xaha.dev', 'https://pub.dev/packages/lottie'),
  OpenSourceLibrary('animated_text_kit', 'ayushagarwal.ml', 'https://pub.dev/packages/animated_text_kit'),
  OpenSourceLibrary('enum_to_string', 'unknown', 'https://pub.dev/packages/enum_to_string'),
  OpenSourceLibrary('smooth_page_indicator', 'codeness.ly', 'https://pub.dev/packages/smooth_page_indicator'),
  OpenSourceLibrary('cached_network_image', 'baseflow.com', 'https://pub.dev/packages/cached_network_image'),
  OpenSourceLibrary('provider', 'dash-overflow.net', 'https://pub.dev/packages/provider'),
  OpenSourceLibrary('path', 'dart.dev', 'https://pub.dev/packages/path'),
  OpenSourceLibrary('url_launcher', 'flutter.dev', 'https://pub.dev/packages/url_launcher'),
  OpenSourceLibrary('package_info_plus', 'fluttercommunity.dev', 'https://pub.dev/packages/package_info_plus'),
  OpenSourceLibrary('flutter_bounceable', 'unknown', 'https://pub.dev/packages/flutter_bounceable'),
  OpenSourceLibrary('flutter_native_splash', 'jonhanson.net', 'https://pub.dev/packages/flutter_native_splash'),
  OpenSourceLibrary(
      'flutter_keyboard_visibility', 'jasonrai.ca', 'https://pub.dev/packages/flutter_keyboard_visibility'),
  OpenSourceLibrary('super_rich_text', 'cleancode.dev', 'https://pub.dev/packages/super_rich_text'),
  OpenSourceLibrary('google_mobile_ads', 'google.dev', 'https://pub.dev/packages/google_mobile_ads'),
  OpenSourceLibrary('in_app_review', 'britannio.dev', 'https://pub.dev/packages/in_app_review'),
  OpenSourceLibrary('app_tracking_transparency', 'he2apps.com', 'https://pub.dev/packages/app_tracking_transparency'),
];

class AboutView extends StackedView<AboutViewModel> {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AboutViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CommonAppBar(
        title: 'About',
        showBackButton: true,
      ),
      body: CommonSafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: scaffoldHorizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20),
                  const ProfileSectionHeader(
                    label: 'App Version',
                  ),
                  Text(viewModel.version),
                  const SizedBox(height: 30),
                  const ProfileSectionHeader(
                    label: 'Credits',
                  ),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        const TextSpan(
                          text:
                              'We would like to thank StorySet for allowing us to use their awesome artwork!\n\nCheck them out ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: 'here!',
                          style: const TextStyle(
                            color: Colours.accent,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              viewModel.onStorySetLinkTapped();
                            },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const ProfileSectionHeader(
                    label: 'Open Source Libraries',
                  ),
                  const Text(
                    'Below are the open source libraries that we have used to create Viajo. We thank the open source community for providing these plugins!',
                  ),
                  const SizedBox(height: 30),
                  SeparatedColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    children: _libraries.map((e) {
                      return InkWell(
                        onTap: () => viewModel.onOpenSourceLinkTapped(e.url),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    e.name,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(e.creator),
                                ],
                              ),
                              FaIcon(
                                FontAwesomeIcons.arrowUpRightFromSquare,
                                color: Theme.of(context).primaryColor,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  AboutViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AboutViewModel();
}

class OpenSourceLibrary {
  String name;
  String creator;
  String url;

  OpenSourceLibrary(this.name, this.creator, this.url);
}
