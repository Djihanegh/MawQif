import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawqif/src/models/user.dart';

class Users with ChangeNotifier {
  List<User> users = [];

  bool loading = false;

  User _currentUser;

  User user = new User(uid: null);

  User get currentUser => _currentUser;

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }

  current(User user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> getUsers() async {
    try {
      QuerySnapshot snapshot =
          await Firestore.instance.collection("users").getDocuments();

      List<User> usersList = [];

      snapshot.documents.forEach((document) async {
        User user = User.fromMap(document.data);
        usersList.add(user);
      });
      users = usersList;
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }
/*
  Future<void> getUserById(String id) async {
    User _user = new User(uid: null);
    var snapshot = await Firestore.instance
        .collection("users")
        .where("userInfo", isEqualTo: id)
        .snapshots().map((data) =>
            data.documents.forEach((doc) => _user = User.fromMap(doc.data)));
            user= _user ;
  }

   User getUser(String id) { getUserById(id); 
    User _user = new User(uid: null);
     print(user.uid);
    _user.uid = user.uid;
            _user = user;
 print(_user.nom);
    return _user;
   }
*/
  User findById(String id) {
    refresh();
    User user = new User(uid: null);
    bool found = false;

    for (int i = 0; i < users.length; i++) {
      if (users.elementAt(i).uid == id) {
        user.uid = users.elementAt(i).uid;
        user.codePersonnel = users.elementAt(i).codePersonnel;
        user.email = users.elementAt(i).email;
        user.prenom = users.elementAt(i).prenom;
        user.nom = users.elementAt(i).nom;
        user.telephone = users.elementAt(i).telephone;

        found = true;
      }
    }
    if (!found) {
      print("USER NOT FOUND ");
      return null;
    }

    return user;
  }

  Future<void> updateProfile(String id , User user) async {
   // List<User> list = [];
    try{
        //  var snapshot =
     /*   final DocumentReference postRef = Firestore.instance.document('users');
Firestore.instance.runTransaction((Transaction tx) async {
  DocumentSnapshot postSnapshot = await tx.get(postRef);
  if (postSnapshot.exists) {
    await tx.update(postRef, <String, dynamic>{'likesCount': postSnapshot.data['likesCount'] + 1});
  }
});*/

       /*  final collRef = Firestore.instance.collection('gameLevels');
  DocumentReferance docReference = collRef.document();

  docReferance.setData(map).then((doc) {
    print('hop ${docReferance.documentID}');
  }).catchError((error) {
    print(error);
  });
          await Firestore.instance.collection("parking")
          .where((item) => item.uid == id)
          .*/

          

          

          {
     /* if (snapshot.documents.isNotEmpty) {
        list = snapshot.documents
            .map((snapshot) => User.fromMap(snapshot.data))
            .where((mappedItem) => mappedItem.uid== id )
            .toList();

            list[0]

            list.forEach((item) {
                    item.email=user.email;
                    item.telephone=user.telephone;
                    item.nom=user.nom;
                    item.prenom=user.prenom;
                    item.password=user.password;
                    item.immatriculations=user.immatriculations;
                    
            });*/

      }
    }catch(e)
      {
           print(e);
      }
      
  }
  

  void refresh() {
    getUsers();
  }
}
