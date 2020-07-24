import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawqif/src/models/parking/parking.dart';
import 'package:mawqif/src/models/user/user.dart';
//part 'reservation.g.dart';

@JsonSerializable()

class ReservationModel  {
     
    String id;
    String nom;
    String rue ;
    String heureD ;
    String heureF ;
    Parking park ;
    User userInfo ;
    int codeReservation=0;
    String status; 

   
    

  ReservationModel(
    {
      this.id,
      this.nom,
     @required this.heureD,
     @required this.heureF,
     @required this.park ,
     @required this.userInfo,
     this.codeReservation,
     this.status,
    });

    
    ReservationModel.fromMap(Map<String,dynamic> data )
    {
      id= data ['id'];
      nom= data ['nom'];
      //adresse = data ['addresse'];
      //prix = data ['prix'];
      //rue = data['rue'];
      heureD = data['heureD'];
      heureF = data ['heureF'];
      park= data ['Parking'];
      userInfo= data ['User'];
      codeReservation=data['codeRes'];
      status=data['status'];
    }



}