import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/models/attraction_model.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';

import 'saved_plans_viewmodel.dart';

class SavedPlansView extends StackedView<SavedPlansViewModel> {
  const SavedPlansView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SavedPlansViewModel viewModel,
    Widget? child,
  ) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            scaffoldHorizontalPadding, 10, scaffoldHorizontalPadding, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'My Trips',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: plans.map((e) => SavedPlanCard(plan: e)).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  SavedPlansViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SavedPlansViewModel();
}

class SavedPlanCard extends ViewModelWidget<SavedPlansViewModel> {
  const SavedPlanCard({super.key, required this.plan});

  final Plan plan;

  @override
  Widget build(BuildContext context, SavedPlansViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
        onTap: () => viewModel.onSavedPlanCardTap(plan),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.network(plan.imageUrl ?? '',
                    height: 300,
                    fit: BoxFit.cover, errorBuilder: (BuildContext context,
                        Object error, StackTrace? stackTrace) {
                  /// TODO: show image load error here
                  return Container(
                    height: 300,
                    color: Colors.grey,
                    child: Center(
                      child: Text(
                        'failed to load image for: ${plan.name}',
                      ),
                    ),
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          plan.name ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text('${plan.city}, ${plan.country}'),
                      ],
                    ),
                    const FaIcon(FontAwesomeIcons.arrowRight)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Plan> plans = <Plan>[
  Plan(
    'Vienna',
    'Austria',
    "Vienna, the capital city of Austria, is known for its rich culture, artistic heritage, and stunning architecture. It is often referred to as the 'City of Music' due to its historical association with renowned composers such as Mozart, Beethoven, and Strauss. Visitors can explore the city's many museums, palaces, and concert halls, or simply wander through its charming streets and enjoy the vibrant atmosphere. Vienna also boasts a thriving coffeehouse culture, where one can relax and indulge in delicious pastries, while enjoying the Viennese way of life.",
    '20',
    4,
    'English',
    <Attraction>[
      Attraction(
          'Schönbrunn Palace',
          'As one of the most important cultural landmarks in Austria, Schönbrunn Palace offers a glimpse into the imperial history of Vienna. Visitors can explore the majestic palace interiors, stroll through the sprawling gardens, and even watch a classical concert in the Orangery.',
          'Cultural',
          5,
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/c/c9/Wien_-_Schloss_Sch%C3%B6nbrunn.JPG'),
      Attraction(
          "St. Stephen's Cathedral",
          "Located in the heart of the city, St. Stephen's Cathedral is a stunning example of Gothic architecture. Visitors can climb the tower for panoramic views of Vienna, admire the intricate details of the interior, or attend a choir performance or organ concert.",
          'Historical',
          4.5,
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/d/dd/Wien_-_Stephansdom_%281%29.JPG'),
      Attraction(
        "Belvedere Palace",
        "Belvedere Palace is a masterpiece of Baroque architecture that houses an impressive collection of Austrian art. Visitors can view the renowned artwork, including Gustav Klimt's famous painting 'The Kiss,' as well as explore the beautiful gardens and fountains.",
        'Art & Culture',
        3.5,
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/4/48/Wien_Unteres_Belvedere.jpg',
      ),
    ],
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/f/fc/Montage_of_Vienna.jpg',
    name: 'Plan 1',
  ),
  Plan(
    'Vienna',
    'Austria',
    "Vienna, the capital city of Austria, is known for its rich culture, artistic heritage, and stunning architecture. It is often referred to as the 'City of Music' due to its historical association with renowned composers such as Mozart, Beethoven, and Strauss. Visitors can explore the city's many museums, palaces, and concert halls, or simply wander through its charming streets and enjoy the vibrant atmosphere. Vienna also boasts a thriving coffeehouse culture, where one can relax and indulge in delicious pastries, while enjoying the Viennese way of life.",
    '20',
    4,
    'English',
    <Attraction>[
      Attraction(
          'Schönbrunn Palace',
          'As one of the most important cultural landmarks in Austria, Schönbrunn Palace offers a glimpse into the imperial history of Vienna. Visitors can explore the majestic palace interiors, stroll through the sprawling gardens, and even watch a classical concert in the Orangery.',
          'Cultural',
          5,
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/c/c9/Wien_-_Schloss_Sch%C3%B6nbrunn.JPG'),
      Attraction(
          "St. Stephen's Cathedral",
          "Located in the heart of the city, St. Stephen's Cathedral is a stunning example of Gothic architecture. Visitors can climb the tower for panoramic views of Vienna, admire the intricate details of the interior, or attend a choir performance or organ concert.",
          'Historical',
          4.5,
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/d/dd/Wien_-_Stephansdom_%281%29.JPG'),
      Attraction(
        "Belvedere Palace",
        "Belvedere Palace is a masterpiece of Baroque architecture that houses an impressive collection of Austrian art. Visitors can view the renowned artwork, including Gustav Klimt's famous painting 'The Kiss,' as well as explore the beautiful gardens and fountains.",
        'Art & Culture',
        3.5,
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/4/48/Wien_Unteres_Belvedere.jpg',
      ),
    ],
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/f/fc/Montage_of_Vienna.jpg',
    name: 'Plan 2',
  ),
  Plan(
    'Vienna',
    'Austria',
    "Vienna, the capital city of Austria, is known for its rich culture, artistic heritage, and stunning architecture. It is often referred to as the 'City of Music' due to its historical association with renowned composers such as Mozart, Beethoven, and Strauss. Visitors can explore the city's many museums, palaces, and concert halls, or simply wander through its charming streets and enjoy the vibrant atmosphere. Vienna also boasts a thriving coffeehouse culture, where one can relax and indulge in delicious pastries, while enjoying the Viennese way of life.",
    '20',
    4,
    'English',
    <Attraction>[
      Attraction(
          'Schönbrunn Palace',
          'As one of the most important cultural landmarks in Austria, Schönbrunn Palace offers a glimpse into the imperial history of Vienna. Visitors can explore the majestic palace interiors, stroll through the sprawling gardens, and even watch a classical concert in the Orangery.',
          'Cultural',
          5,
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/c/c9/Wien_-_Schloss_Sch%C3%B6nbrunn.JPG'),
      Attraction(
          "St. Stephen's Cathedral",
          "Located in the heart of the city, St. Stephen's Cathedral is a stunning example of Gothic architecture. Visitors can climb the tower for panoramic views of Vienna, admire the intricate details of the interior, or attend a choir performance or organ concert.",
          'Historical',
          4.5,
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/d/dd/Wien_-_Stephansdom_%281%29.JPG'),
      Attraction(
        "Belvedere Palace",
        "Belvedere Palace is a masterpiece of Baroque architecture that houses an impressive collection of Austrian art. Visitors can view the renowned artwork, including Gustav Klimt's famous painting 'The Kiss,' as well as explore the beautiful gardens and fountains.",
        'Art & Culture',
        3.5,
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/4/48/Wien_Unteres_Belvedere.jpg',
      ),
    ],
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/f/fc/Montage_of_Vienna.jpg',
    name: 'Plan 3',
  ),
];
