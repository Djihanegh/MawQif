import 'package:flutter/material.dart';

class HeureDeTravail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: Text(
        'Heure de travail',
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[400],
            fontSize: 12,
            letterSpacing: 0.2),
      ),
    );
  }
}
