import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mawqif/src/ui/parking/parkings.dart';

class PartnerCard extends StatefulWidget {
  final DocumentSnapshot document;
  final int i;

  const PartnerCard({Key key, this.document, this.i}) : super(key: key);

  @override
  _PartnerCardState createState() => _PartnerCardState();
}

class _PartnerCardState extends State<PartnerCard> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Padding(
        padding: EdgeInsets.only(left: 25.0, top: 25.0, bottom: 10.0),
        child: Container(
            height: 200.0,
            width: 200.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 3.0,
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3.0)
                ]),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 138.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0)),
                           /* image: DecorationImage(
                                image: NetworkImage(
                                    widget.document.data['imageUrl']),
                                fit: BoxFit.cover)*/),
                      ),
                      /*Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white.withOpacity(0.5)),
                            child: Center(
                              child: Icon(Icons.favorite, color: Colors.red),
                            ),
                          ),
                        ),
                      )*/
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      widget.document.data['nom'],
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0),
                    ),
                  ),
                  /* SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '',
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                              color: Colors.grey.withOpacity(0.5)),
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          '',
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                              color: Colors.grey.withOpacity(0.5)),
                        ),
                      ],
                    ),
                  ),*/
                  /* SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: <Widget>[
                       /* Icon(Icons.star, color: Colors.yellow, size: 14.0),
                        Icon(Icons.star, color: Colors.yellow, size: 14.0),
                        Icon(Icons.star, color: Colors.yellow, size: 14.0),
                        Icon(Icons.star, color: Colors.yellow, size: 14.0),
                        Icon(Icons.star_border, color: Colors.grey, size: 14.0),
                        SizedBox(width: 10.0),
                        Text(
                          '4.5',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0,
                          ),
                        ),*/
                      ],
                    ),
                  )*/
                ])),
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Menu(
                  document: widget.document,
                )));
      },
    );
  }
}
