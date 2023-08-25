import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_aigent/ui/views/plan/ui/plan_view_loaded_state.dart';

class InfoSectionErrorState extends StatelessWidget {
  const InfoSectionErrorState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        SizedBox(
          height: 100,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.triangleExclamation,
                  color: Colors.red,
                ),
                Text(
                  'Something went wrong',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: bigSpacer),
      ],
    );
  }
}
