import 'package:flutter/material.dart';

class InfoSectionLoadingState extends StatelessWidget {
  const InfoSectionLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 100,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Fetching price data...',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
