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
      {required this.items,
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

    Color _suggestionBackgroundColor =
        suggestionBackgroundColor ?? scaffold?.widget.backgroundColor ?? theme.scaffoldBackgroundColor;

    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(5),
      color: _suggestionBackgroundColor,
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
                    padding: EdgeInsets.all(10),
                    child: Visibility(
                        visible: progressIndicatorBuilder != null,
                        child: progressIndicatorBuilder!,
                        replacement: CircularProgressIndicator()));
              }

              // if (suggestionBuilder != null) {
              return InkWell(child: suggestionBuilder!(items[index]), onTap: () => onItemTapped(items[index]));
              // }

              // return Material(
              //     color: Colors.transparent,
              //     child: InkWell(
              //         child: Container(
              //             width: double.infinity,
              //             padding: EdgeInsets.all(5),
              //             child: Text(items[index].toString(), style: suggestionTextStyle)),
              //         onTap: () => onItemTapped(items[index])));
            },
          ),
        ),
      ),
    );
  }
}
