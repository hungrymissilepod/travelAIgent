import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/on_boarding_carousel/on_boarding_carousel/flutter_onboarding_slider.dart';

import 'on_boarding_carousel_viewmodel.dart';

class OnBoardingCarouselView extends StackedView<OnBoardingCarouselViewModel> {
  const OnBoardingCarouselView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    OnBoardingCarouselViewModel viewModel,
    Widget? child,
  ) {
    return OnBoardingSlider(
      finishButtonText: 'Register',
      onFinish: () {
        viewModel.onFinish();
      },
      controllerColor: Colors.blue,
      totalPage: 3,
      headerBackgroundColor: Colors.white,
      pageBackgroundColor: Colors.white,
      centerBackground: true,
      background: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20),
          child: Image.asset(
            'assets/airport.png',
            height: MediaQuery.of(context).size.height / 2.5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Image.asset(
            'assets/hiker2.png',
            height: MediaQuery.of(context).size.height / 2.5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Image.asset(
            'assets/travel.png',
            height: MediaQuery.of(context).size.height / 2.5,
          ),
        ),
      ],
      speed: 1.8,
      pageBodies: [
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
              ),
              const Text(
                'Welcome to Viajo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colours.accent,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Embark on a journey of personalised travel recommendations, through the power of AI',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
              ),
              const Text(
                'Tailored to you',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colours.accent,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'From hidden gems to iconic landmarks, uncover your ideal getaway',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
              ),
              const Text(
                'Your Adventure Awaits',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colours.accent,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Pack your bags and your camera, your next adventure awaits!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  OnBoardingCarouselViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      OnBoardingCarouselViewModel();
}
