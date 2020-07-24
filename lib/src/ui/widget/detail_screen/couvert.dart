import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Couvert extends StatefulWidget {
  final DocumentSnapshot document;

  const Couvert(this.document);
  @override
  _CouvertState createState() => _CouvertState();
}

class _CouvertState extends State<Couvert> {
  @override
  Widget build(BuildContext context) {
    bool couvert = widget.document.data['couvert'];

    return Row(
      children: <Widget>[
        SizedBox(
          width: 20,
        ),
        couvert ? Icon(Icons.check_box) : Icon(Icons.clear),
        SizedBox(
          width: 10,
        ),
        Text("Couvert"),
      ],
    );
  }
}
