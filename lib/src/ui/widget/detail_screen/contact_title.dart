import 'package:flutter/material.dart';

class ContactTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: Text(
        'Contacts',
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[400],
            fontSize: 12,
            letterSpacing: 0.2),
      ),
    );
  }
}
