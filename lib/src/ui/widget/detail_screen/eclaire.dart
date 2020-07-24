import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Eclaire extends StatefulWidget {
  final DocumentSnapshot document;
  Eclaire(this.document);
  @override
  _EclaireState createState() => _EclaireState();
}

class _EclaireState extends State<Eclaire> {
  @override
  Widget build(BuildContext context) {
    bool eclaire = widget.document.data['eclaire'];

    return Row(
      children: <Widget>[
        SizedBox(
          width: 20,
        ),
        eclaire ? Icon(Icons.check_box) : Icon(Icons.clear),
        SizedBox(
          width: 10,
        ),
        Text("Eclairé"),
      ],
    );
  }
}
