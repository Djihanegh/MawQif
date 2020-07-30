import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';

//part 'parking.g.dart';
@JsonSerializable()
class Parking {
  DocumentReference docRef =
      Firestore.instance.collection('parking').document();

  String id;
  String nom;
  Map<String, dynamic> adresse;
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
  int users;
  int profit;
  bool nonvalide;
  String rating;
  bool liked;
  bool couvert;
  bool eclaire;
  bool souterrain;
  bool videosurveillance;
  bool poussettebagage;
  String hauteurmaximale;
  Parking({
    @required this.id,
    @required this.nom,
    @required this.adresse,
    @required this.imageURL,
    @required this.prix,
    this.heureDouverture,
    this.heureDeFermeture,
    this.users,
    this.profit,
    this.nonvalide,
    this.rating,
    this.liked = false,
    this.couvert,
    this.souterrain,
    this.videosurveillance,
    this.poussettebagage,
    this.hauteurmaximale,
    this.eclaire,
  });

  Parking.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    nom = data['nom'];
    adresse = data['addresse'];
    //imageURL = data['imageURL'];
    prix = data['prix'];
    // rue = data['rue'];
    location = data['point'];
    places = data['places'];
    status = data['status'];
    heureDouverture = data['heureDouverture'];
    heureDeFermeture = data['heureDeFermeture'];
    nTelephone = data['nTelephone'];
    email = data['email'];
    users = data['users'];
    profit = data['profit'];
    nonvalide = data['nonvalide'];
    //rating = data['rating'];
    liked = data['liked'];
    couvert = data['couvert'];
    eclaire = data['eclaire'];
    videosurveillance = data['videosurveillance'];
    souterrain = data['souterrain'];
    poussettebagage = data['poussettebagage'];
    //hauteurmaximale = data['hauteurmaximale'];
  }

  Map<String, dynamic> toJson() => {
        'addresse': adresse,
        'prix': prix,
        'rue': rue,
        'nom': nom,
        'id': id,
        'places': places,
        'users': users,
        'profit': profit,
        'rating': rating,
        'liked': liked,
        'id': docRef.documentID,
      };

  factory Parking.fromJson(Map<String, dynamic> parsedJson) {
    return Parking(
      id: parsedJson['id'],
      nom: parsedJson['nom'],
      adresse: parsedJson['addresse'],
      prix: parsedJson['prix'],
      imageURL: parsedJson[null],
      users: parsedJson['users'],
      profit: parsedJson['profit'],
      rating: parsedJson['rating'],
      liked: parsedJson['liked'],
      couvert: parsedJson['couvert'],
      eclaire: parsedJson['eclaire'],
      videosurveillance: parsedJson['videosurveillance'],
      souterrain: parsedJson['souterrain'],
      poussettebagage: parsedJson['poussettebagage'],
      hauteurmaximale: parsedJson['hauteurmaximale'],

      // heureDeFermeture: parsedJson['heureDeFermeture'],
    );
  }
}
