import 'package:flutter/material.dart';
import 'dart:core';

class CommonErrorView extends StatelessWidget {
  const CommonErrorView({
    super.key,
    required this.visibile,
    required this.message,
    required this.onCloseTap,
  });

  final bool visibile;
  final String message;
  final Function() onCloseTap;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibile,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.red[100],
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            color: Colors.red.shade300,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onCloseTap,
                child: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
