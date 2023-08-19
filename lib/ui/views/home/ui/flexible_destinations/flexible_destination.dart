import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FlexibleDestination {
  final String label;
  final IconData icon;

  FlexibleDestination(this.label, this.icon);
}

final List<FlexibleDestination> flexibleDestinations = <FlexibleDestination>[
  FlexibleDestination('Anywhere', FontAwesomeIcons.earthAmericas),
  FlexibleDestination('Europe', FontAwesomeIcons.locationDot),
  FlexibleDestination('North America', FontAwesomeIcons.locationDot),
  FlexibleDestination('South America', FontAwesomeIcons.locationDot),
  FlexibleDestination('Africa', FontAwesomeIcons.locationDot),
  FlexibleDestination('Asia', FontAwesomeIcons.locationDot),
  FlexibleDestination('Australia', FontAwesomeIcons.locationDot),
];
