import 'package:flutter/cupertino.dart';

class NomVehiculeProvider extends ChangeNotifier {

  String nom;

  get nomV => nom;

  set setNomV (String nom){
    this.nom = nom;
    notifyListeners();
  }
}