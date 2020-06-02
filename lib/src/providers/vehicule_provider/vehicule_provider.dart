import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mawqif/src/models/vehicule.dart';

class VehiculeProvider extends ChangeNotifier {
  List<Vehicule> list = [
    Vehicule(immatriculation: "jjfsjeflsd"),
    Vehicule(immatriculation: "chnqijdopqzkdpm"),
  ];

  void update(Vehicule value)
  {
    value.toggleDone();
    notifyListeners();
  }

  void delete(Vehicule vehicule )
  {
    list.remove(vehicule);
  }

  Future<void> addVehicule(Vehicule vehicule) async {
    try {
     await Firestore.instance.collection("vehicule").add({
       "vehiculeId": vehicule.vehiculeId,
       "userId": vehicule.userId,
       "immatriculation":vehicule.immatriculation,
      });
      list.add(vehicule);
      notifyListeners();
    } catch (erro) {
      print(erro);
    }
  }

  

}