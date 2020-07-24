import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HauteurMaximale extends StatefulWidget {
  final DocumentSnapshot document;

  const HauteurMaximale(this.document);

  @override
  State<StatefulWidget> createState() => _HauteurMaximaleState();
}

class _HauteurMaximaleState extends State<HauteurMaximale> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 20,
        ),
        Icon(Icons.clear),
        SizedBox(
          width: 10,
        ),
        Text("Hauteur maximale: ${widget.document.data['hauteurmaximale']} m"),
      ],
    );
  }
}
