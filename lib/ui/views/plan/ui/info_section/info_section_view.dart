import 'package:flutter/material.dart';
import 'package:separated_column/separated_column.dart';

class InfoSectionView extends StatelessWidget {
  const InfoSectionView({
    super.key,
    required this.title,
    required this.leftColumn,
    required this.rightColumn,
  });

  final String title;
  final List<Widget> leftColumn;
  final List<Widget> rightColumn;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        const SizedBox(
          height: 16,
        ),
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
