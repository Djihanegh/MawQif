import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:mawqif/src/models/parking.dart';
import 'package:mawqif/src/models/user.dart';

class ReservationModel  extends ChangeNotifier{
               DatabaseReference dbRef =
            FirebaseDatabase.instance.reference().child("Reservation");
     
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