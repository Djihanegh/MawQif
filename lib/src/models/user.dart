
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class User with ChangeNotifier {

  String uid ;
  static String id ;
  String codePersonnel;
  static int code ;
  List<String> immatriculations;
  String nom;
  String prenom ;
  String telephone;
  String email ;
  String password;

  User({@required this.uid ,
   this.codePersonnel ,
    this.immatriculations,
    this.nom,
    this.prenom,
    this.telephone,
    this.email,
    this.password,
    });

   Map <String,dynamic> toJson() =>
    {
        'userInfo': uid,
        'codeP':codePersonnel,
        'telephone':telephone,
        'nom':nom,
        'prenom':prenom,
        'email':email
        //'matricule':immatriculations,
    };

    User.fromMap(Map<String,dynamic > data )
    {
         uid=data['userInfo'];
         codePersonnel=data['codeP'];
         telephone=data['telephone'];
         nom=data['nom'];
         prenom=data['prenom'];
         email=data['email'];
    }

    String getCurrentId() => uid;

 factory User.fromJson(Map<String, dynamic> parsedJson){
    return User(
      uid: parsedJson['userInfo'],
      codePersonnel:parsedJson['codeP'],
      nom:parsedJson['nom'],
      prenom: parsedJson['prenom'],
      telephone: parsedJson['telephone'],
      email: parsedJson['email']
    );
  }

  static String getCodePersonnel (String uid){
    String code ;
    Firestore.instance.collection("users")
    .where("userInfo" , isEqualTo: uid)
    .snapshots()
    .listen((data) => data.documents.forEach((doc) => code=doc['codeP']));
    return code ;
  }
}