import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:separated_column/separated_column.dart';

class InfoSectionView extends StatefulWidget {
  const InfoSectionView({
    super.key,
    required this.title,
    this.initiallyExpanded = true,
    required this.leftColumn,
    required this.rightColumn,
    this.subtitle,
    this.isLoading = false,
  });

  final String title;
  final bool initiallyExpanded;
  final List<Widget> leftColumn;
  final List<Widget> rightColumn;
  final Widget? subtitle;
  final bool isLoading;

  @override
  State<InfoSectionView> createState() => _InfoSectionViewState();
}

class _InfoSectionViewState extends State<InfoSectionView> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        initiallyExpanded: widget.initiallyExpanded,
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        trailing: AnimatedRotation(
          turns: _isExpanded ? 0.5 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: const FaIcon(
            FontAwesomeIcons.chevronDown,
          ),
        ),
        onExpansionChanged: (bool expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: <Widget>[
          widget.isLoading
              ? const InfoSectionLoadingState()
              : InfoSectionLoadedState(
                  subtitle: widget.subtitle,
                  leftColumn: widget.leftColumn,
                  rightColumn: widget.rightColumn,
                ),
        ],
      ),
    );
  }
}

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

class InfoSectionLoadingState extends StatelessWidget {
  const InfoSectionLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 100,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Fetching price data...',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
