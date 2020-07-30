import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawqif/src/ui/recherche/parkings_screen.dart';


class Menu extends StatefulWidget {
  final DocumentSnapshot document;

  const Menu({Key key, this.document}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MenuState();
  }
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
          ParkingScreen(document: widget.document),
    );}
}
