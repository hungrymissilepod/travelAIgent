import 'package:flutter/material.dart';

class StartUpLogo extends StatefulWidget {
  const StartUpLogo({
    super.key,
    required this.width,
  });

  final double width;

  @override
  State<StartUpLogo> createState() => _StartUpLogoState();
}

class _StartUpLogoState extends State<StartUpLogo> {
  late Image logo;

  @override
  void initState() {
    super.initState();
    logo = Image.asset(
      'assets/splash_logo2.png',
      width: widget.width,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(logo.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: logo,
    );
  }
}
