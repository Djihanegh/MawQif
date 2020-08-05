import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode extends StatefulWidget {
  String uid;
  String immatricule;
  String ownerId;
  String id;

  QrCode(this.uid, this.immatricule, this.ownerId, this.id);
  @override
  State<StatefulWidget> createState() {
    return QrCodeState();
  }
}

class QrCodeState extends State<QrCode> {
  String status = "Pas encore accepte";

  @override
  void initState() {
    listenNumbers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: QrImage(
            data:
                'User ID : ${widget.uid}   Immatricule :  ${widget.immatricule}',
            version: QrVersions.auto,
            size: 320,
            gapless: false,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          child: Text("Veuillez scanner ce Qr code à l'entrée du parking svp."),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          child: Text(
            "$status",
            style: TextStyle(color: Colors.red),
          ),
        )
      ],
    )));
  }

  listenNumbers() {
    Stream<QuerySnapshot> streamNumbers = Firestore.instance
        .collection('loueur')
        .document(widget.ownerId)
        .collection("orders")
        .where("id", isEqualTo: widget.id)
        .snapshots();

    streamNumbers.listen((snapshot) {
      snapshot.documents.forEach((doc) {
        String _status = doc.data['status'];
        print("STATUSSSS $status");

        setState(() {
          status = _status;
        });
      });
    });
  }
}
