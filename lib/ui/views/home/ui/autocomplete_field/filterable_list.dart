import 'package:flutter/material.dart';

class FilterableList extends StatelessWidget {
  final List<Object> items;
  final Function(Object) onItemTapped;
  final double elevation;
  final double maxListHeight;
  final TextStyle suggestionTextStyle;
  final Color? suggestionBackgroundColor;
  final bool loading;
  final Widget Function(Object data)? suggestionBuilder;
  final Widget? progressIndicatorBuilder;

  const FilterableList(
      {super.key,
      required this.items,
      required this.onItemTapped,
      this.suggestionBuilder,
      this.elevation = 5,
      this.maxListHeight = 150,
      this.suggestionTextStyle = const TextStyle(),
      this.suggestionBackgroundColor,
      this.loading = false,
      this.progressIndicatorBuilder});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);

    Color backgroundColor = suggestionBackgroundColor ??
        scaffold?.widget.backgroundColor ??
        theme.scaffoldBackgroundColor;

    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(5),
      color: backgroundColor,
      child: Container(
        constraints: BoxConstraints(maxHeight: maxListHeight),
        child: Visibility(
          visible: items.isNotEmpty || loading,
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(5),
            itemCount: loading ? 1 : items.length,
            itemBuilder: (context, index) {
              if (loading) {
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Visibility(
                    visible: progressIndicatorBuilder != null,
                    replacement: const CircularProgressIndicator(),
                    child: progressIndicatorBuilder!,
                  ),
                );
              }
              return InkWell(
                child: suggestionBuilder!(items[index]),
                onTap: () => onItemTapped(items[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}
