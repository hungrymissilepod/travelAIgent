import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    required this.focusNode,
    required this.hasError,
    required this.icon,
    required this.controller,
    required this.child,
  });

  final FocusNode focusNode;
  final bool hasError;
  final IconData icon;
  final TextEditingController controller;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: textFieldContainerPadding),
      decoration: textFieldDecoration(focusNode, hasError),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: textFieldIconSizedBoxWidth,
            child: FaIcon(
              icon,
              color: Theme.of(context).primaryColor,
              size: textFieldIconSize,
            ),
          ),
          const SizedBox(width: textFieldIconSpacer),
          child,
        ],
      ),
    );
  }
}
