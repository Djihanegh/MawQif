import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopScreen extends StatefulWidget {
  final DocumentSnapshot document;

  const TopScreen(this.document);
  @override
  State<StatefulWidget> createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 30.0, top: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              title(),
              //  address(),
              SizedBox(
                height: 10,
              ),
              places()
            ],
            //)
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 18.0, top: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }

  Widget title() {
    return Row(
      children: <Widget>[
        Text(
          widget.document.data['nom'],
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 22.4,
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(
          width: 70,
        ),
        IconButton(
          icon: Icon(Icons.map),
          onPressed: () {
            /* Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyApp()));*/
          },
        )
      ],
    );
  }

  /*Widget address() {
    return Text(
      widget.document.data['addresse'],
      style: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.black54,
          fontSize: 12,
          letterSpacing: 0.2),
    );
  }*/

  Widget places() {
    return Row(
      children: <Widget>[
        Card(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Icon(
              Icons.local_parking,
              size: 16,
              color: Colors.white,
            ),
          ),
          color: Colors.grey[900],
          elevation: 4,
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          "${widget.document.data['places']} places",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.4),
        ),
        SizedBox(
          width: 24,
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          "${widget.document.data['prix']} DA",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.4),
        )
      ],
    );
  }
}
