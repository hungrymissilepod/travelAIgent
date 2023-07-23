import 'package:flutter/material.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Hi Jake!',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Where to?',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),

          /// TODO: show user image?
          /// Or just show first initial of name?
          ///
          /// TODO: navigat to ProfileView
          const CircleAvatar(
            child: Text('J'),
          ),
        ],
      ),
    );
  }
}
