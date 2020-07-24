import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PoussetteBagage extends StatefulWidget {
  final DocumentSnapshot document;
  PoussetteBagage(this.document);
  @override
  _PoussetteBagageState createState() => _PoussetteBagageState();
}

class _PoussetteBagageState extends State<PoussetteBagage> {
  @override
  Widget build(BuildContext context) {
    bool poussette = widget.document.data['poussettebagage'];

    return Row(
      children: <Widget>[
        SizedBox(
          width: 20,
        ),
        poussette ? Icon(Icons.check_box) : Icon(Icons.clear),
        SizedBox(
          width: 10,
        ),
        Text("Pratique avec poussette ou bagage"),
      ],
    );
  }
}
