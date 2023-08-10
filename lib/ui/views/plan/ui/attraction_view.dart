import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_aigent/models/attraction_model.dart';

class AttractionView extends StatelessWidget {
  const AttractionView({super.key, required this.attraction});

  final Attraction attraction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            child: Image.network(attraction.imageUrl ?? '', height: 300, fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
              /// TODO: show image load error here
              return Container(
                height: 300,
                color: Colors.grey,
                child: Center(
                  child: Text(
                    'failed to load image for: ${attraction.name}',
                  ),
                ),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        attraction.name,
                        maxLines: 2,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        const FaIcon(
                          FontAwesomeIcons.solidStar,
                          size: 16,
                          color: Color(0xfff4be45),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${attraction.rating}',
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(attraction.type),
                const SizedBox(
                  height: 10,
                ),
                Text(attraction.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
