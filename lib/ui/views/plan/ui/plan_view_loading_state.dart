import 'package:flutter/material.dart';

class PlanViewLoadingState extends StatelessWidget {
  const PlanViewLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
