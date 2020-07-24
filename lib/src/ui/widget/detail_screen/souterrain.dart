import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Souterrain extends StatefulWidget {
  final DocumentSnapshot document;

  const Souterrain(this.document);
  @override
  _SouterrainState createState() => _SouterrainState();
}

class _SouterrainState extends State<Souterrain> {
  @override
  Widget build(BuildContext context) {
    bool souterrain = widget.document.data['souterrain'];

    return Row(
      children: <Widget>[
        SizedBox(
          width: 20,
        ),
        souterrain ? Icon(Icons.check_box) : Icon(Icons.clear),
        SizedBox(
          width: 10,
        ),
        Text("Souterrain"),
      ],
    );
  }
}
