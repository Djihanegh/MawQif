import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tirait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: Container(
          width: 44,
          height: 4,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}
