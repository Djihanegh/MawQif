import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawqif/src/models/user.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode extends StatefulWidget {
  User user = new User();

  QrCode(this.user);
  @override
  State<StatefulWidget> createState() {
    return QrCodeState();
  }
}

class QrCodeState extends State<QrCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        
        Container(
          alignment: Alignment.center,
          child: QrImage(
            data:
                'User ID : ${widget.user.uid}   Immatricule :  ${widget.user.immatriculations}',
            version: QrVersions.auto,
            size: 320,
            gapless: false,
          ),
        ),
        SizedBox(height: 20,),
        Container(child: Text("Veuillez scanner ce Qr code à l'entrée du parking svp."),)
      ],
    )));
  }
}
