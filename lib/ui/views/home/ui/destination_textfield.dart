import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';

class DestinationTextfield extends StatelessWidget {
  const DestinationTextfield({
    super.key,
    required this.suggestions,
    required this.focusNode,
    required this.controller,
    required this.hintText,
    required this.icon,
  });

  final List<String> suggestions;
  final FocusNode focusNode;
  final TextEditingController controller;
  final String hintText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        height: homePickerHeight,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: textFieldDecoration(focusNode),
        child: Row(
          children: <Widget>[
            FaIcon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 16,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: EasyAutocomplete(
                suggestions: suggestions,
                focusNode: focusNode,
                controller: controller,
                cursorColor: Theme.of(context).colorScheme.secondary,
                inputTextStyle: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 14),
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                ),
                suggestionBackgroundColor: Colors.white,
                suggestionBuilder: (String? data) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
                    child: Text(data ?? ''),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
