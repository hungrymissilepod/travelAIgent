import 'package:travel_aigent/ui/views/plan/ui/image_carousel.dart';
import 'package:travel_aigent/ui/views/saved_plans/saved_plans_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SavedPlanCard extends ViewModelWidget<SavedPlansViewModel> {
  const SavedPlanCard({super.key, required this.plan});

  final Plan plan;

  @override
  Widget build(BuildContext context, SavedPlansViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () => viewModel.onSavedPlanCardTap(plan),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: CachedNetworkImage(
                  imageUrl: plan.images == null
                      ? ''
                      : plan.images!.isEmpty
                          ? ''
                          : plan.images?[0].image ?? '',
                  height: 250,
                  fit: BoxFit.cover,
                  placeholderFadeInDuration: Duration.zero,
                  fadeInDuration: Duration.zero,
                  placeholder: (context, url) => Center(child: Container()),
                  errorWidget: (context, url, error) =>
                      const ImageCarouselError(),
                ),
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
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text('${plan.city}, ${plan.country}'),
                      ],
                    ),
                    const FaIcon(
                      FontAwesomeIcons.arrowRight,
                    ),
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
