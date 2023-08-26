import 'package:flutter/material.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/common/common_safe_area.dart';
import 'package:travel_aigent/ui/common/cta_button.dart';
import 'package:travel_aigent/ui/views/startup/startup_viewmodel.dart';

class LauchButtons extends StatefulWidget {
  const LauchButtons({
    super.key,
    required this.viewModel,
  });

  final StartupViewModel viewModel;

  @override
  State<LauchButtons> createState() => _LauchButtonsState();
}

class _LauchButtonsState extends State<LauchButtons> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 250),
    vsync: this,
  )..forward();

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: CommonSafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: scaffoldHorizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              CTAButton(
                onTap: widget.viewModel.onGetStartedTap,
                label: 'Get Started',
                style: CTAButtonStyle.outline,
              ),
              const SizedBox(height: 20),
              CTAButton(
                onTap: widget.viewModel.onSignInTap,
                label: 'Sign In',
                style: CTAButtonStyle.fill,
                overrideColor: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
