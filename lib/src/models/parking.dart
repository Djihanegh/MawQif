import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';



class Parking {
  DocumentReference docRef =
      Firestore.instance.collection('parking').document();
  String id;
  String nom;
  String adresse;
  int places;
  int placesOccupe;
  String imageURL;
  int prix;
  Position point;
  String rue;
  String kmTo;
  String timeTo;
  String status;
  GeoPoint location;
  String nTelephone;
  String email;
  String heureDouverture;
  String heureDeFermeture;
  int users ;
  int profit ;
  bool nonvalide;

  Parking(
      {@required this.id,
      @required this.nom,
      @required this.adresse,
      @required this.imageURL,
      @required this.prix,
      this.heureDouverture ,
      this.heureDeFermeture,
      this.users,
      this.profit,
      this.nonvalide,
      
      });

      Parking.fromMap(Map<String, dynamic> data) {
    id = docRef.documentID;
    nom = data['nom'];
    adresse = data['addresse'];
    imageURL = data['imageURL'];
    prix = data['prix'];
    rue = data['rue'];
    location = data['point'];
    places = data['places'];
    status = data['status'];
    heureDouverture = data['heureDouverture'];
    heureDeFermeture = data['heureDeFermeture'];
    nTelephone= data ['nTelephone'];
    email = data ['email'];
    users= data ['users'];
    profit=data['profit'];
    nonvalide=data['nonvalide'];


  }

  Map<String, dynamic> toJson() => {
        'addresse': adresse,
        'prix': prix,
        'rue': rue,
        'nom': nom,
        'id': id,
        'places': places,
        'users':users,
        'profit':profit,
      };

  factory Parking.fromJson(Map<String, dynamic> parsedJson) {
    return Parking(
        id: parsedJson['id'],
        nom: parsedJson['nom'],
        adresse: parsedJson['addresse'],
        prix: parsedJson['prix'],
        imageURL: parsedJson[null],
        users: parsedJson['users'],
        profit:parsedJson['profit'],
       // heureDeFermeture: parsedJson['heureDeFermeture'],

    );
  }

  
}
