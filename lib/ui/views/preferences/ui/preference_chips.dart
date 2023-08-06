import 'package:flutter/material.dart';
import 'package:simple_chips_input/select_chips_input.dart';
import 'package:travel_aigent/models/interest_chip_model.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';

class PrefenceChips extends StatelessWidget {
  const PrefenceChips({super.key, required this.chips, required this.onTap, this.onlyOneChipSelectable = false});

  final List<InterestChip> chips;
  final Function(String p0, int p1) onTap;
  final bool onlyOneChipSelectable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SelectChipsInput(
        wrapAlignment: WrapAlignment.center,
        onlyOneChipSelectable: onlyOneChipSelectable,
        chipsText: chips.map((e) => e.label).toList(),
        separatorCharacter: onlyOneChipSelectable ? null : ',',
        paddingInsideWidgetContainer: const EdgeInsets.symmetric(horizontal: 3),
        paddingInsideChipContainer: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        marginBetweenChips: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        selectedChipTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        unselectedChipTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 16,
        ),
        onTap: (String p0, int p1) => onTap(p0, p1),
        widgetContainerDecoration: const BoxDecoration(color: Colors.transparent),
        unselectedChipDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Theme.of(context).primaryColorLight, width: 1)),
        selectedChipDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colours.accent.shade50,
            border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 1)),
        prefixIcons: chips.map((e) {
          return Padding(padding: const EdgeInsets.only(right: 5.0), child: Text(e.emoji));
        }).toList(),
      ),
    );
  }
}
