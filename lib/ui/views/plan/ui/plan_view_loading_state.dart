import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/plan_view_banner_ad/plan_view_banner_ad_view.dart';

class PlanViewLoadingState extends StatelessWidget {
  const PlanViewLoadingState({
    super.key,
    required this.showBannerAd,
  });

  final bool showBannerAd;

  final int animatedTextSpeed = 50;

  final int pauseDurationMilliseconds = 3500;

  TyperAnimatedText animatedText(String str) {
    return TyperAnimatedText(
      str,
      speed: Duration(milliseconds: animatedTextSpeed),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: scaffoldHorizontalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 4, child: Container()),
          Lottie.asset(
            'assets/loading_animation.json',
            repeat: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: DefaultTextStyle(
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
              child: AnimatedTextKit(
                repeatForever: false,
                pause: Duration(milliseconds: pauseDurationMilliseconds),
                animatedTexts: <AnimatedText>[
                  animatedText('Analysing your preferences...'),
                  animatedText('Generating your perfect holiday...'),
                  animatedText('Making everything perfect for you...'),
                  animatedText('Hold tight! We are almost there!'),
                ],
              ),
            ),
          ),
          Expanded(flex: 5, child: Container()),
          showBannerAd ? const PlanViewBannerAdView() : const SizedBox(),
        ],
      ),
    );
  }
}
