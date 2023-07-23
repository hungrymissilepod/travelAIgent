import 'package:flutter/material.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';

enum CTAButtonStyle { fill, outline }

class CTAButton extends StatelessWidget {
  const CTAButton({
    super.key,
    required this.onTap,
    required this.label,
    this.style = CTAButtonStyle.fill,
  });

  final Function() onTap;
  final String label;
  final CTAButtonStyle style;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          style == CTAButtonStyle.fill ? Colours.accent : Colors.white,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            color: style == CTAButtonStyle.fill ? Colors.transparent : Colours.accent,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
        overlayColor: MaterialStateProperty.all(
          style == CTAButtonStyle.fill ? Colours.accent[700] : Colours.accent[100],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Text(
          label,
          style: TextStyle(
            color: style == CTAButtonStyle.fill ? Colors.white : Colours.accent,
            fontWeight: FontWeight.w700,
            fontSize: 21,
          ),
        ),
      ),
    );
    // return InkWell(
    //   // splashColor: Colors.red,
    //   highlightColor: Colors.red,
    //   onTap: onTap,
    //   child: Container(
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(8),
    //       color: style == CTAButtonStyle.fill ? Colours.accent : Colors.white,
    //       border: Border.all(
    //         color: Colours.accent,
    //       ),
    //     ),
    //     child: Center(
    //         child: Padding(
    //       padding: const EdgeInsets.all(16),
    //       child: Text(
    //         label,
    //         style: TextStyle(
    //           color: style == CTAButtonStyle.fill ? Colors.white : Colours.accent,
    //           fontWeight: FontWeight.w700,
    //           fontSize: 21,
    //         ),
    //       ),
    //     )),
    //   ),
    // );
  }
}
