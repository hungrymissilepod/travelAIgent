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
import 'package:travel_aigent/ui/views/home/ui/filterable_list.dart';

class AutocompleteField extends StatefulWidget {
  /// The list of suggestions to be displayed
  final AirportData suggestions;

  /// Fetches list of suggestions from a Future
  final Future<List<String>> Function(String searchValue)? asyncSuggestions;

  /// Text editing controller
  final TextEditingController? controller;

  /// Can be used to decorate the input
  final InputDecoration decoration;

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
  const AutocompleteField(
      {super.key,
      required this.suggestions,
      this.asyncSuggestions,
      this.suggestionBuilder,
      this.progressIndicatorBuilder,
      this.controller,
      this.decoration = const InputDecoration(),
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
  State<AutocompleteField> createState() => _AutocompleteFieldState();
}

class _AutocompleteFieldState extends State<AutocompleteField> {
  final LayerLink _layerLink = LayerLink();
  late TextEditingController _controller;
  bool _hasOpenedOverlay = false;
  bool _isLoading = false;
  OverlayEntry? _overlayEntry;
  List<Object> _suggestions = [];
  Timer? _debounce;
  String _previousAsyncSearchText = '';
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue ?? '');
    _controller.addListener(() => updateSuggestions(_controller.text));
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        openOverlay();
      } else {
        closeOverlay();
      }
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
                String value;
                if (obj is Country) {
                  value = obj.country;

                  _controller.value =
                      TextEditingValue(text: value, selection: TextSelection.collapsed(offset: value.length));
                } else if (obj is City) {
                  value = obj.city;
                  _controller.value =
                      TextEditingValue(text: value, selection: TextSelection.collapsed(offset: value.length));
                } else if (obj is Airport) {
                  value = obj.airportName;
                  _controller.value =
                      TextEditingValue(text: value, selection: TextSelection.collapsed(offset: value.length));
                } else {
                  value = obj.toString();
                  _controller.value =
                      TextEditingValue(text: value, selection: TextSelection.collapsed(offset: value.length));
                }

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

  Future<void> updateSuggestions(String input) async {
    /// Do not show suggestions if text field is empty
    if (input.isEmpty || input == 'Anywhere') return;
    print('updateSuggestions: $input');
    rebuildOverlay();
    if (widget.asyncSuggestions != null) {
      await _getAsyncSuggestion(input);
    } else {
      print('updateSuggestions: $input');
      _suggestions.clear();

      /// Fuzzy search
      List<Future> futures = <Future>[
        _fuzzySearchCountries(widget.suggestions.countries, input),
        _fuzzySearchCities(widget.suggestions.cities, input),
        _fuzzySearchAirport(widget.suggestions.airports, input),
        _fuzzySearchAirportCode(widget.suggestions.airports, input)
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
        print('${r.choice} - ${r.score}');

        /// Look for matching country name
        int index = widget.suggestions.countries.indexWhere((e) => e.country == r.choice);
        if (index != -1) {
          if (!_suggestions.contains(widget.suggestions.countries[index])) {
            _suggestions.add(widget.suggestions.countries[index]);
          }
        }

        /// Look for matching city name
        int index4 = widget.suggestions.cities.indexWhere((e) => e.city == r.choice);
        if (index4 != -1) {
          if (!_suggestions.contains(widget.suggestions.cities[index4])) {
            _suggestions.add(widget.suggestions.cities[index4]);
          }
        }

        /// Look for city that belongs to a matching country name
        /// i.e Paris is in France so it should appear when France is the [input]
        int index5 = widget.suggestions.cities.indexWhere((e) => e.country == r.choice);
        if (index5 != -1) {
          if (!_suggestions.contains(widget.suggestions.cities[index5])) {
            _suggestions.add(widget.suggestions.cities[index5]);
          }
        }

        /// Look for matching airport name
        int index2 = widget.suggestions.airports.indexWhere((e) => e.airportName == r.choice);
        if (index2 != -1) {
          if (!_suggestions.contains(widget.suggestions.airports[index2])) {
            _suggestions.add(widget.suggestions.airports[index2]);
          }
        }

        /// Look for matching airport code
        int index3 = widget.suggestions.airports.indexWhere((e) => e.airportIataCode == r.choice);
        if (index3 != -1) {
          if (!_suggestions.contains(widget.suggestions.airports[index3])) {
            _suggestions.add(widget.suggestions.airports[index3]);
          }
        }
      }
      rebuildOverlay();
    }
  }

  void rebuildOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.markNeedsBuild();
    }
  }

  Future<List<ExtractedResult>> _fuzzySearch(List<String> choices, String input, {int cutoff = 70}) async {
    List<ExtractedResult> results = extractTop(
      query: input,
      choices: choices,
      cutoff: cutoff,

      /// how accurate the fuzzy search should be
      limit: 5,

      /// how many to return
      getter: (s) => s,
    );
    return results;
  }

  Future<List<ExtractedResult>> _fuzzySearchCountries(List<Country> countries, String input) async {
    List<String> choices = <String>[];

    /// Add all country names to list
    choices.addAll(countries.map((e) => e.country).toList());

    /// Do fuzzy search on country names
    List<ExtractedResult> results = await _fuzzySearch(choices, input);
    return results;
  }

  Future<List<ExtractedResult>> _fuzzySearchCities(List<City> cities, String input) async {
    List<String> choices = <String>[];
    choices.addAll(cities.map((e) => e.city).toList());
    choices.addAll(cities.map((e) => e.country).toList());
    List<ExtractedResult> results = await _fuzzySearch(choices, input);
    for (var r in results) {
      print('search cities: ${r.choice}');
    }
    return results;
  }

  Future<List<ExtractedResult>> _fuzzySearchAirport(List<Airport> airports, String input) async {
    List<String> choices = <String>[];
    choices.addAll(airports.map((e) => e.airportName).toList());
    List<ExtractedResult> results = await _fuzzySearch(choices, input);
    return results;
  }

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
              decoration: widget.decoration,
              controller: _controller,
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
      _controller.removeListener(() => updateSuggestions(_controller.text));
      _controller.dispose();
    }
    if (_debounce != null) _debounce?.cancel();
    if (widget.focusNode == null) {
      _focusNode.removeListener(() {
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
