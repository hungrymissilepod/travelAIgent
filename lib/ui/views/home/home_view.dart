import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

const double cardPadding = 12;

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Stack(
      children: <Widget>[
        Container(
          color: Theme.of(context).colorScheme.secondary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              /// Welcome card
              Card(
                margin: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(cardPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
                ),
              ),

              /// To and from card
              Card(
                margin: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(cardPadding),
                  child: Column(
                    children: <Widget>[
                      /// TODO: this should be list of airports
                      /// TODO: revisit if we should show the magnifying glass icon or not? It makes the autocomplete not fit across the whole search bar
                      Row(
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.locationDot,
                            color: Theme.of(context).primaryColor,
                            size: 16,
                          ),
                          const SizedBox(width: 10),

                          /// TODO: revisit using emojis in this search bar. Does not look professional here
                          Flexible(
                            child: EasyAutocomplete(
                                inputFormatter: <TextInputFormatter>[
                                  FlagEmojiTextFormatter(),
                                ],
                                cursorColor: Theme.of(context).colorScheme.secondary,
                                inputTextStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14),
                                decoration: const InputDecoration(
                                  hintText: 'Where from?',
                                  border: InputBorder.none,
                                ),
                                suggestionBackgroundColor: Colors.white,
                                suggestionBuilder: (data) {
                                  return Container(
                                    padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
                                    child: Text(data),
                                  );
                                },
                                suggestions: viewModel.countriesList,
                                onChanged: (value) => print('onChanged value: $value'),
                                onSubmitted: (value) => print('onSubmitted value: $value')),
                          ),
                        ],
                      ),

                      /// Where to textfield
                      /// TODO: add disabled styling so it is clear this is disabled
                      TextField(
                        enabled: viewModel.anywhereCheckBoxChecked == false,
                        cursorColor: Theme.of(context).colorScheme.secondary,
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0),
                          prefixIcon: FaIcon(
                            FontAwesomeIcons.plane,
                            color: Theme.of(context).primaryColor,
                            size: 16,
                          ),

                          /// TODO: need to ensure both textfields have correct amount of padding between icons
                          prefixIconConstraints: const BoxConstraints(minWidth: 25),
                          hintText: 'Where to?',
                          border: InputBorder.none,
                        ),
                      ),

                      CheckboxListTile(
                        title: const Text("I don't know where to go"),
                        value: viewModel.anywhereCheckBoxChecked,
                        onChanged: (bool? b) => viewModel.toggleAnywhereCheckBox(b),
                      ),

                      /// TODO: should this even be an option? If the user selects that they don't know where to go
                      /// should we just give them anywhere on earth without the travelDistance setting?
                      viewModel.anywhereCheckBoxChecked ?? false
                          ? Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    viewModel.travelDistanceLabel(),
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                                Slider(
                                  value: viewModel.travelDistance,
                                  min: 1,
                                  max: 24,
                                  thumbColor: Theme.of(context).colorScheme.secondary,
                                  activeColor: Theme.of(context).colorScheme.secondaryContainer,
                                  onChanged: (double value) {
                                    viewModel.updateTravelDistance(value);
                                  },
                                ),
                              ],
                            )
                          : const SizedBox(),

                      /// TODO: could add the number of travellers option here?
                    ],
                  ),
                ),
              ),

              /// CTA button to search
              InkWell(
                onTap: () {
                  print('generate trip');
                },
                child: Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Generate',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 21,
                      ),
                    ),
                  )),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: -100,

          /// TODO: make a cool flowy blobby white background so this melts in the background
          child: Container(
            color: Colors.white,
            child: SvgPicture.asset(
              'assets/svgs/airport tower-pana.svg',
              height: 350,
            ),
          ),
        ),
      ],
    );
  }
}

/// Custom formatter that will ensure that all text is removed
/// if a user is deleting text from an input and only an emoji remains.
///
/// This means that the user will not have to delete the flag emoji before they
/// start typing again.
class FlagEmojiTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
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
        return newValue.copyWith(text: '', selection: TextSelection.fromPosition(const TextPosition(offset: 0)));
      }
    }
    return newValue;
  }
}


/*

//                   /// Type of holiday
  //                   Text(
  //                     'I want a',
  //                     style: Theme.of(context).textTheme.bodySmall,
  //                   ),
  //                   SelectChipsInput(
  //                     chipsText: const <String>[
  //                       'City break',
  //                       'Beach holiday',
  //                       'Adventure',
  //                       'Family trip',
  //                     ],
  //                     separatorCharacter: ',',
  //                     paddingInsideChipContainer: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  //                     marginBetweenChips: const EdgeInsets.all(2),
  //                     selectedChipTextStyle: const TextStyle(
  //                       color: Colors.black,
  //                       fontSize: 16,
  //                     ),
  //                     unselectedChipTextStyle: TextStyle(
  //                       color: Theme.of(context).colorScheme.primary,
  //                       fontSize: 16,
  //                     ),
  //                     onTap: (String p0, int p1) {
  //                       viewModel.updateHolidayTypes(p0);
  //                     },
  //                     widgetContainerDecoration: const BoxDecoration(color: Colors.transparent),
  //                     unselectedChipDecoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(50),
  //                         border: Border.all(color: Theme.of(context).primaryColorLight, width: 1)),
  //                     selectedChipDecoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(50),
  //                         color: Colours.accent.shade50,
  //                         border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 1)),
  //                     prefixIcons: const [
  //                       Padding(padding: EdgeInsets.only(right: 5.0), child: Text('🏢')),
  //                       Padding(padding: EdgeInsets.only(right: 5.0), child: Text('🏖️')),
  //                       Padding(padding: EdgeInsets.only(right: 5.0), child: Text('🥾')),
  //                       Padding(padding: EdgeInsets.only(right: 5.0), child: Text('👨‍👩‍👧‍👦')),
  //                     ],
  //                   ),

  //                   /// TODO: create widget out of this so that we can supply it with a list
  //                   /// of items and have it update a value in the view model without the need for all
  //                   /// this duplicate code

  //                   /// Interests
  //                   Text(
  //                     'Interests',
  //                     style: Theme.of(context).textTheme.bodySmall,
  //                   ),
  //                   SelectChipsInput(
  //                     chipsText: ['Hiking', 'Museums', 'Food'],
  //                     separatorCharacter: ',',
  //                     paddingInsideChipContainer: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  //                     marginBetweenChips: const EdgeInsets.all(2),
  //                     selectedChipTextStyle: const TextStyle(
  //                       color: Colors.black,
  //                       fontSize: 16,
  //                     ),
  //                     unselectedChipTextStyle: TextStyle(
  //                       color: Theme.of(context).colorScheme.primary,
  //                       fontSize: 16,
  //                     ),
  //                     onTap: (String p0, int p1) {
  //                       viewModel.updateInterests(p0);
  //                     },
  //                     widgetContainerDecoration: const BoxDecoration(color: Colors.transparent),
  //                     unselectedChipDecoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(50),
  //                         border: Border.all(color: Theme.of(context).primaryColorLight, width: 1)),
  //                     selectedChipDecoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(50),
  //                         color: Colours.accent.shade50,
  //                         border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 1)),
  //                     prefixIcons: const [
  //                       Padding(padding: EdgeInsets.only(right: 5.0), child: Text('🥾')),
  //                       Padding(padding: EdgeInsets.only(right: 5.0), child: Text('🖼️')),
  //                       Padding(padding: EdgeInsets.only(right: 5.0), child: Text('😋')),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),

*/

/*
//           /// TESTING changing to dark mode
  //           MaterialButton(
  //             color: Theme.of(context).colorScheme.secondary,
  //             onPressed: () {
  //               viewModel.incrementCounter();
  //               getThemeManager(context).toggleDarkLightTheme();
  //             },
  //             child: const Text(
  //               'Toggle theme',
  //               style: TextStyle(color: Colors.white),
  //             ),
  //           ),

*/