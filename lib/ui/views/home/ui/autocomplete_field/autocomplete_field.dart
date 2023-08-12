library easy_autocomplete;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:fuzzywuzzy/model/extracted_result.dart';
import 'package:travel_aigent/models/airport_data_model.dart';
import 'package:travel_aigent/models/airport_model.dart';
import 'package:travel_aigent/models/city_model.dart';
import 'package:travel_aigent/models/country_model.dart';
import 'package:travel_aigent/ui/views/home/ui/autocomplete_field/filterable_list.dart';

class AutoCompleteField extends StatefulWidget {
  /// The list of suggestions to be displayed
  final AirportData suggestions;

  /// Fetches list of suggestions from a Future
  final Future<List<String>> Function(String searchValue)? asyncSuggestions;

  /// Text editing controller
  final TextEditingController? controller;

  /// Function that handles the changes to the input
  final Function(String)? onChanged;

  /// Function that handles the submission of the input
  final Function(String)? onSubmitted;

  /// Can be used to set custom inputFormatters to field
  final List<TextInputFormatter> inputFormatter;

  /// Can be used to set the textfield initial value
  final String? initialValue;

  /// Can be used to set the text capitalization type
  final TextCapitalization textCapitalization;

  /// Determines if should gain focus on screen open
  final bool autofocus;

  /// Can be used to set different keyboardTypes to your field
  final TextInputType keyboardType;

  /// Can be used to manage TextField focus
  final FocusNode? focusNode;

  /// Can be used to set a custom color to the input cursor
  final Color? cursorColor;

  /// Can be used to set custom style to the suggestions textfield
  final TextStyle inputTextStyle;

  /// Can be used to set custom style to the suggestions list text
  final TextStyle suggestionTextStyle;

  /// Can be used to set custom background color to suggestions list
  final Color? suggestionBackgroundColor;

  /// Used to set the debounce time for async data fetch
  final Duration debounceDuration;

  /// Can be used to customize suggestion items
  final Widget Function(Object data)? suggestionBuilder;

  /// Can be used to display custom progress idnicator
  final Widget? progressIndicatorBuilder;

  /// Can be used to validate field value
  final String? Function(String?)? validator;

  /// Creates a autocomplete widget to help you manage your suggestions
  const AutoCompleteField(
      {super.key,
      required this.suggestions,
      this.asyncSuggestions,
      this.suggestionBuilder,
      this.progressIndicatorBuilder,
      this.controller,
      this.onChanged,
      this.onSubmitted,
      this.inputFormatter = const [],
      this.initialValue,
      this.autofocus = false,
      this.textCapitalization = TextCapitalization.sentences,
      this.keyboardType = TextInputType.text,
      this.focusNode,
      this.cursorColor,
      this.inputTextStyle = const TextStyle(),
      this.suggestionTextStyle = const TextStyle(),
      this.suggestionBackgroundColor,
      this.debounceDuration = const Duration(milliseconds: 400),
      this.validator})
      : assert(onChanged != null || controller != null,
            'onChanged and controller parameters cannot be both null at the same time'),
        assert(!(controller != null && initialValue != null),
            'controller and initialValue cannot be used at the same time'),
        assert(asyncSuggestions == null, 'asyncSuggestions cannot be null');

  @override
  State<AutoCompleteField> createState() => _AutoCompleteFieldState();
}

class _AutoCompleteFieldState extends State<AutoCompleteField> {
  final LayerLink _layerLink = LayerLink();
  late TextEditingController _controller;
  bool _hasOpenedOverlay = false;
  bool _isLoading = false;
  OverlayEntry? _overlayEntry;
  List<Object> _suggestions = [];
  Timer? _debounce;
  String _previousAsyncSearchText = '';
  late FocusNode _focusNode;
  bool showClearIcon = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue ?? '');
    _controller.addListener(() {
      updateSuggestions(_controller.text);
      updateShowClearIcon();
    });
    _focusNode.addListener(() {
      updateShowClearIcon();
      if (_focusNode.hasFocus) {
        openOverlay();
      } else {
        closeOverlay();
      }
    });
  }

  void updateShowClearIcon() {
    setState(() {
      showClearIcon = _focusNode.hasFocus && _controller.text.isNotEmpty;
    });
  }

  void openOverlay() {
    if (_overlayEntry == null) {
      RenderBox renderBox = context.findRenderObject() as RenderBox;
      var size = renderBox.size;
      var offset = renderBox.localToGlobal(Offset.zero);

      _overlayEntry ??= OverlayEntry(
        builder: (context) => Positioned(
          left: offset.dx,
          top: offset.dy + size.height + 5.0,
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0.0, size.height + 5.0),
            child: FilterableList(
              loading: _isLoading,
              suggestionBuilder: widget.suggestionBuilder,
              progressIndicatorBuilder: widget.progressIndicatorBuilder,
              items: _suggestions,
              suggestionTextStyle: widget.suggestionTextStyle,
              suggestionBackgroundColor: widget.suggestionBackgroundColor,
              onItemTapped: (obj) {
                String value = _getValueOnItemTapped(obj);
                _controller.value =
                    TextEditingValue(text: value, selection: TextSelection.collapsed(offset: value.length));
                widget.onChanged?.call(value);
                widget.onSubmitted?.call(value);
                closeOverlay();
                _focusNode.unfocus();
              },
            ),
          ),
        ),
      );
    }
    if (!_hasOpenedOverlay) {
      Overlay.of(context).insert(_overlayEntry!);
      setState(() => _hasOpenedOverlay = true);
    }
  }

  void closeOverlay() {
    if (_hasOpenedOverlay) {
      _overlayEntry!.remove();
      setState(() {
        _previousAsyncSearchText = '';
        _hasOpenedOverlay = false;
      });
    }
  }

  Future<void> _getAsyncSuggestion(String input) async {
    setState(() => _isLoading = true);
    if (_debounce != null && _debounce!.isActive) _debounce!.cancel();
    _debounce = Timer(widget.debounceDuration, () async {
      if (_previousAsyncSearchText != input || _previousAsyncSearchText.isEmpty || input.isEmpty) {
        _suggestions = await widget.asyncSuggestions!(input);
        setState(() {
          _isLoading = false;
          _previousAsyncSearchText = input;
        });
        rebuildOverlay();
      }
    });
  }

  Future<void> _getSuggestions(String input) async {
    _suggestions.clear();

    /// Fuzzy search
    List<Future> futures = <Future>[
      _fuzzySearchCountries(widget.suggestions.countries, input),
      _fuzzySearchCities(widget.suggestions.cities, input),
      _fuzzySearchAirport(widget.suggestions.airports, input),
      _fuzzySearchAirportCode(widget.suggestions.airports, input),
    ];

    await Future.wait(futures);

    List<ExtractedResult> results = <ExtractedResult>[
      ...await futures[0],
      ...await futures[1],
      ...await futures[2],
      ...await futures[3],
    ];

    /// Sort and order results based on score
    results.sort(((a, b) => (a.score).compareTo(b.score)));
    results = results.reversed.toList();

    /// Add all [Country] objects to list in order
    for (ExtractedResult r in results) {
      // print('${r.choice} - ${r.score}');

      /// Look for matching country name
      int i = widget.suggestions.countries.indexWhere((e) => e.country == r.choice);
      _suggestions = _addToSuggestions(_suggestions, widget.suggestions.countries, i);

      /// Look for matching city name
      int j = widget.suggestions.cities.indexWhere((e) => e.city == r.choice);
      _suggestions = _addToSuggestions(_suggestions, widget.suggestions.cities, j);

      /// Look for city that belongs to a matching country name
      /// i.e Paris is in France so it should appear when France is the [input]
      int k = widget.suggestions.cities.indexWhere((e) => e.country == r.choice);
      _suggestions = _addToSuggestions(_suggestions, widget.suggestions.cities, k);

      /// Look for matching airport name
      int l = widget.suggestions.airports.indexWhere((e) => e.airportName == r.choice);
      _suggestions = _addToSuggestions(_suggestions, widget.suggestions.airports, l);

      /// Look for matching airport code
      int m = widget.suggestions.airports.indexWhere((e) => e.airportIataCode == r.choice);
      _suggestions = _addToSuggestions(_suggestions, widget.suggestions.airports, m);
    }
    rebuildOverlay();
  }

  Future<void> updateSuggestions(String input) async {
    /// Do not show suggestions if text field is empty
    if (input.isEmpty || input == 'Anywhere') return;
    rebuildOverlay();
    if (widget.asyncSuggestions != null) {
      await _getAsyncSuggestion(input);
    } else {
      await _getSuggestions(input);
    }
  }

  void rebuildOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.markNeedsBuild();
    }
  }

  List<Object> _addToSuggestions(List<Object> suggestions, List<Object> objectsToCheck, int index) {
    if (index != -1) {
      if (!suggestions.contains(objectsToCheck[index])) {
        _suggestions.add(objectsToCheck[index]);
      }
    }

    return suggestions;
  }

  String _getValueOnItemTapped(Object object) {
    switch (object.runtimeType) {
      case Country:
        return (object as Country).country;
      case City:
        return (object as City).city;
      case Airport:
        return (object as Airport).airportName;
      default:
        return object.toString();
    }
  }

  /// [cutoff] is how accurate the search should be
  /// [limit] is how many results to return
  Future<List<ExtractedResult>> _fuzzySearch(List<String> choices, String input,
      {int cutoff = 70, int limit = 5}) async {
    List<ExtractedResult> results = extractTop(
      query: input,
      choices: choices,
      cutoff: cutoff,
      limit: limit,
      getter: (s) => s,
    );
    return results;
  }

  /// Fuzzy search for country names
  Future<List<ExtractedResult>> _fuzzySearchCountries(List<Country> countries, String input) async {
    List<String> choices = <String>[];
    choices.addAll(countries.map((e) => e.country).toList());
    List<ExtractedResult> results = await _fuzzySearch(choices, input);
    return results;
  }

  /// When searching cities we search based on city name and the country
  Future<List<ExtractedResult>> _fuzzySearchCities(List<City> cities, String input) async {
    List<String> choices = <String>[];
    choices.addAll(cities.map((e) => e.city).toList());
    choices.addAll(cities.map((e) => e.country).toList());
    List<ExtractedResult> results = await _fuzzySearch(choices, input);
    return results;
  }

  /// Fuzzy search for airports based on names
  Future<List<ExtractedResult>> _fuzzySearchAirport(List<Airport> airports, String input) async {
    List<String> choices = <String>[];
    choices.addAll(airports.map((e) => e.airportName).toList());
    List<ExtractedResult> results = await _fuzzySearch(choices, input);
    return results;
  }

  /// Fuzzy search for airports codes but we have a high [cutoff] so they only appear
  /// in suggestions when the [input] is pretty much spot on
  Future<List<ExtractedResult>> _fuzzySearchAirportCode(List<Airport> airports, String input) async {
    List<String> choices = <String>[];
    choices.addAll(airports.map((e) => e.airportIataCode).toList());
    List<ExtractedResult> results = await _fuzzySearch(choices, input, cutoff: 98);
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Country, city, or airport',
                border: InputBorder.none,
                suffixIcon: Visibility(
                  visible: showClearIcon,
                  child: IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      _controller.clear();
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                    ),
                  ),
                ),
              ),
              textAlignVertical: TextAlignVertical.center,
              inputFormatters: widget.inputFormatter,
              autofocus: widget.autofocus,
              focusNode: _focusNode,
              textCapitalization: widget.textCapitalization,
              keyboardType: widget.keyboardType,
              cursorColor: widget.cursorColor ?? Colors.blue,
              style: widget.inputTextStyle,
              onChanged: (value) => widget.onChanged?.call(value),
              onFieldSubmitted: (value) {
                widget.onSubmitted?.call(value);
                closeOverlay();
                _focusNode.unfocus();
              },
              onEditingComplete: () => closeOverlay(),
              validator: widget.validator != null ? (value) => widget.validator!(value) : null // (value) {}
              ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (_overlayEntry != null) _overlayEntry!.dispose();
    if (widget.controller == null) {
      _controller.removeListener(() {
        updateSuggestions(_controller.text);
        updateShowClearIcon();
      });
      _controller.dispose();
    }
    if (_debounce != null) _debounce?.cancel();
    if (widget.focusNode == null) {
      _focusNode.addListener(() {
        updateShowClearIcon();
        if (_focusNode.hasFocus) {
          openOverlay();
        } else {
          closeOverlay();
        }
      });
      _focusNode.dispose();
    }
    super.dispose();
  }
}
