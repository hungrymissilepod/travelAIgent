import 'package:flutter/material.dart';
import 'package:separated_column/separated_column.dart';
import 'package:travel_aigent/ui/views/plan/ui/plan_view_loaded_state.dart';

class InfoSectionLoadedState extends StatelessWidget {
  const InfoSectionLoadedState({
    super.key,
    required this.subtitle,
    required this.leftColumn,
    required this.rightColumn,
  });

  final Widget? subtitle;
  final List<Widget> leftColumn;
  final List<Widget> rightColumn;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        subtitle ?? const SizedBox.shrink(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SeparatedColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: leftColumn,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 10);
              },
            ),
            SeparatedColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: rightColumn,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 10);
              },
            ),
          ],
        ),
      ],
    );
  }
}
