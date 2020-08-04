import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawqif/src/models/parking/parking.dart';

@JsonSerializable()
class ReservationModel {
  String id;
  String nom;
  String rue;
  String heureD;
  String heureF;
  Parking park;
  String userId;
  int codeReservation = 0;
  String status;
  String immatricule;
  String ownerId;

  ReservationModel(
      {this.id,
      this.nom,
      @required this.heureD,
      @required this.heureF,
      @required this.park,
      @required this.userId,
      @required this.immatricule,
      this.codeReservation,
      this.status,
      this.ownerId});

  ReservationModel.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    nom = data['nom'];
    //adresse = data ['addresse'];
    //prix = data ['prix'];
    //rue = data['rue'];
    heureD = data['heureD'];
    heureF = data['heureF'];
    park = data['Parking'];
    userId = data['userId'];
    codeReservation = data['codeRes'];
    status = data['status'];
  }
}
