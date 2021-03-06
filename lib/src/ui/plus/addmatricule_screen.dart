import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawqif/src/models/vehicule/vehicule.dart';
import 'package:mawqif/src/providers/connection_provider/authh.dart';
import 'package:mawqif/src/providers/vehicule_provider/vehicule_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddMatriculeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = new TextEditingController();
    Auth auth = new Auth();
    Vehicule vehicule = new Vehicule(
        userId: null, immatriculation: null, vehiculeId: null, isChecked: null);

    String newImmatricule = "";
    return Container(
        height: 350,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0))),
            child: Column(
              children: <Widget>[
                Text(
                  "Entrez un immatricule",
                  textAlign: TextAlign.center,
                ),
                TextFormField(
                  controller: textEditingController,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  onSaved: (value) {
                    newImmatricule = value;
                    vehicule = new Vehicule(
                        immatriculation: "sdfsdfsdfs",
                        userId: auth.userId,
                        vehiculeId: Uuid.NAMESPACE_DNS, isChecked: null);
                  },
                ),
                FlatButton(
                  child: Text("Ajouter"),
                  onPressed: () {
                    Provider.of<VehiculeProvider>(context)
                        .addVehicule(vehicule);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ));
  }
}
