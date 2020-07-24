import 'package:flutter/material.dart';

class OuvertTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: Text(
        "ouvert",
        style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.green,
            fontSize: 12.4,
            letterSpacing: 0.2),
      ),
    );
  }
}
