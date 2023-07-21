import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_chips_input/select_chips_input.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';

import 'home_viewmodel.dart';

const double cardPadding = 12;

class HomeView extends StackedView<HomeViewModel> {
  final int startingIndex;
  const HomeView({Key? key, required this.startingIndex}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            /// TODO: show username here
                            Text(
                              'Hi {username}!',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            Text(
                              'Where to next?',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),

                        /// TODO: show use avatar image here
                        /// if user has no image just show the first letter of their name
                        CircleAvatar(
                          child: const Text('J'),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          foregroundColor: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Flying from:',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),

                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.secondary),
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: <Widget>[
                          const FaIcon(
                            FontAwesomeIcons.magnifyingGlass,
                            size: 16,
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: EasyAutocomplete(
                                inputFormatter: <TextInputFormatter>[
                                  FlagEmojiTextFormatter(),
                                ],
                                cursorColor:
                                    Theme.of(context).colorScheme.secondary,
                                inputTextStyle: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 14),
                                decoration: const InputDecoration(
                                  hintText: 'Country...',
                                  border: InputBorder.none,
                                ),
                                suggestionBackgroundColor: Colors.white,
                                suggestionBuilder: (data) {
                                  return Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        5, 10, 10, 10),
                                    child: Text(data),
                                  );
                                },
                                suggestions: viewModel.countriesList,
                                onChanged: (value) =>
                                    print('onChanged value: $value'),
                                onSubmitted: (value) =>
                                    print('onSubmitted value: $value')),
                          ),
                        ],
                      ),
                    ),

                    // SearchBar(
                    //   leading: const FaIcon(
                    //     FontAwesomeIcons.magnifyingGlass,
                    //     size: 16,
                    //   ),
                    //   shape: MaterialStateProperty.resolveWith((states) {
                    //     return RoundedRectangleBorder(borderRadius: BorderRadius.circular(4));
                    //   }),
                    //   elevation: MaterialStateProperty.resolveWith((states) => 2),
                    //   hintText: 'Country, city or airport',
                    // ),

                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      viewModel.travelDistanceLabel(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Slider(
                      value: viewModel.travelDistanceValue,
                      min: 1,
                      max: 24,
                      onChanged: (double value) {
                        viewModel.updateTravelDistanceValue(value);
                      },
                    ),

                    /// Type of holiday
                    Text(
                      'I want a',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SelectChipsInput(
                      chipsText: const <String>[
                        'City break',
                        'Beach holiday',
                        'Adventure',
                        'Family trip',
                      ],
                      separatorCharacter: ',',
                      paddingInsideChipContainer: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      marginBetweenChips: const EdgeInsets.all(2),
                      selectedChipTextStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      unselectedChipTextStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),
                      onTap: (String p0, int p1) {
                        viewModel.updateHolidayTypes(p0);
                      },
                      widgetContainerDecoration:
                          const BoxDecoration(color: Colors.transparent),
                      unselectedChipDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: Theme.of(context).primaryColorLight,
                              width: 1)),
                      selectedChipDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colours.accent.shade50,
                          border: Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 1)),
                      prefixIcons: const [
                        Padding(
                            padding: EdgeInsets.only(right: 5.0),
                            child: Text('🏢')),
                        Padding(
                            padding: EdgeInsets.only(right: 5.0),
                            child: Text('🏖️')),
                        Padding(
                            padding: EdgeInsets.only(right: 5.0),
                            child: Text('🥾')),
                        Padding(
                            padding: EdgeInsets.only(right: 5.0),
                            child: Text('👨‍👩‍👧‍👦')),
                      ],
                    ),

                    /// TODO: create widget out of this so that we can supply it with a list
                    /// of items and have it update a value in the view model without the need for all
                    /// this duplicate code

                    /// Interests
                    Text(
                      'Interests',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SelectChipsInput(
                      chipsText: ['Hiking', 'Museums', 'Food'],
                      separatorCharacter: ',',
                      paddingInsideChipContainer: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      marginBetweenChips: const EdgeInsets.all(2),
                      selectedChipTextStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      unselectedChipTextStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),
                      onTap: (String p0, int p1) {
                        viewModel.updateInterests(p0);
                      },
                      widgetContainerDecoration:
                          const BoxDecoration(color: Colors.transparent),
                      unselectedChipDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: Theme.of(context).primaryColorLight,
                              width: 1)),
                      selectedChipDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colours.accent.shade50,
                          border: Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 1)),
                      prefixIcons: const [
                        Padding(
                            padding: EdgeInsets.only(right: 5.0),
                            child: Text('🥾')),
                        Padding(
                            padding: EdgeInsets.only(right: 5.0),
                            child: Text('🖼️')),
                        Padding(
                            padding: EdgeInsets.only(right: 5.0),
                            child: Text('😋')),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            /// TESTING changing to dark mode
            MaterialButton(
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                viewModel.incrementCounter();
                getThemeManager(context).toggleDarkLightTheme();
              },
              child: const Text(
                'Toggle theme',
                style: TextStyle(color: Colors.white),
              ),
            ),
            viewModel.imageUrl.isEmpty
                ? Container()
                : Image.network(
                    viewModel.imageUrl,
                    height: 400,
                    errorBuilder: (context, error, stackTrace) => Container(),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel(startingIndex);
}

/// Custom formatter that will ensure that all text is removed
/// if a user is deleting text from an input and only an emoji remains.
///
/// This means that the user will not have to delete the flag emoji before they
/// start typing again.
class FlagEmojiTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    /// Regular expression for detecting emojis
    final RegExp regExp = RegExp(
        r'(?:[\u2700-\u27bf]|(?:\ud83c[\udde6-\uddff]){2}|[\ud800-\udbff][\udc00-\udfff]|[\u0023-\u0039]\ufe0f?\u20e3|\u3299|\u3297|\u303d|\u3030|\u24c2|\ud83c[\udd70-\udd71]|\ud83c[\udd7e-\udd7f]|\ud83c\udd8e|\ud83c[\udd91-\udd9a]|\ud83c[\udde6-\uddff]|\ud83c[\ude01-\ude02]|\ud83c\ude1a|\ud83c\ude2f|\ud83c[\ude32-\ude3a]|\ud83c[\ude50-\ude51]|\u203c|\u2049|[\u25aa-\u25ab]|\u25b6|\u25c0|[\u25fb-\u25fe]|\u00a9|\u00ae|\u2122|\u2139|\ud83c\udc04|[\u2600-\u26FF]|\u2b05|\u2b06|\u2b07|\u2b1b|\u2b1c|\u2b50|\u2b55|\u231a|\u231b|\u2328|\u23cf|[\u23e9-\u23f3]|[\u23f8-\u23fa]|\ud83c\udccf|\u2934|\u2935|[\u2190-\u21ff])');

    /// If [newValue] conatains an emoji
    if (newValue.text.contains(regExp)) {
      /// Remove the emoji from the string
      String str = newValue.text.replaceAll(regExp, '');

      /// If [str] is empty it means that this string only contains an emoji
      if (str.trim().isEmpty) {
        /// So we can return with an empty string now so that the emoji is automatically deleted
        return newValue.copyWith(
            text: '',
            selection:
                TextSelection.fromPosition(const TextPosition(offset: 0)));
      }
    }
    return newValue;
  }
}
