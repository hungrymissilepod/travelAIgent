import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/common/cta_button.dart';

class BackgroundController extends StatelessWidget {
  final int currentPage;
  final int totalPage;
  final PageController controller;
  final Function onTap;

  const BackgroundController({
    super.key,
    required this.currentPage,
    required this.totalPage,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: scaffoldHorizontalPadding),
      child: Column(
        children: <Widget>[
          SmoothPageIndicator(
            controller: controller,
            count: totalPage,
            effect: WormEffect(
              dotColor: Colors.grey.shade400,
              activeDotColor: Colours.accent,
              dotHeight: 8,
              dotWidth: 8,
              spacing: 16,
            ),
          ),
          const SizedBox(height: 40),
          CTAButton(
            onTap: () => onTap(),
            label: currentPage == totalPage - 1 ? 'Let\'s Go!' : 'Next',
          ),
        ],
      ),
    );
  }
}
