import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      //.orderBy("createdAt", descending: true)

      List<User> usersList = [];

      snapshot.documents.forEach((document) async {
        User user = User.fromMap(document.data);
        // print("UID==" + user.uid);
        //   print("codeP==" + user.codePersonnel);
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

    //return users.firstWhere((prod) => prod.uid == id );
    for (int i = 0; i < users.length; i++) {
      print("ELEMENT A " + users.elementAt(i).uid);
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
      Fluttertoast.showToast(
          msg: "Veuillez vous connectez svp !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }

    return user;
  }

  void refresh() {
    getUsers();
  }
}
