import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawqif/src/providers/connection_provider/authh.dart';
import 'package:mawqif/src/providers/users/users.dart';
import 'package:mawqif/src/providers/vehicule_provider/vehicule_provider.dart';
import 'package:mawqif/src/ui/Edit/edit_screen.dart';
import 'package:mawqif/src/ui/widget/matricule_list.dart';
import 'package:provider/provider.dart';

import 'addmatricule_screen.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final vehiculeProvider = Provider.of<VehiculeProvider>(context);
    final provider = Provider.of<Users>(context);
    final notifier = Provider.of<Auth>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "         MON PROFIL",
          style: TextStyle(color: Colors.blueGrey[800]),
        ),
        backgroundColor: Colors.blueGrey[50],
        actions: <Widget>[
          FlatButton(
            child: Text("Modifier", style: TextStyle(color: Colors.blue)),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()));
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50,
          ),
          Container(
              child: Text(
                  "${provider.findById(notifier.userId).nom} ${provider.findById(notifier.userId).prenom}",
                  style: TextStyle(color: Colors.blueGrey[800], fontSize: 25))),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              "${provider.findById(notifier.userId).codePersonnel}",
              style: TextStyle(fontWeight: FontWeight.w200),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              children: <Widget>[
                Icon(Icons.mail, color: Colors.blue),
                Column(
                  children: <Widget>[
                    Container(
                        child: Text("          adresse e-mail",
                            style: TextStyle(color: Colors.blue))),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        "           ${provider.findById(notifier.userId).email}",
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              children: <Widget>[
                Icon(Icons.phone, color: Colors.blue),
                Column(
                  children: <Widget>[
                    Container(
                        child: Text("      Télephone",
                            style: TextStyle(color: Colors.blue))),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        "           ${provider.findById(notifier.userId).telephone}",
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                        child: Text("      Vos immatriculations",
                            style: TextStyle(color: Colors.blue))),
                    SizedBox(
                      height: 5,
                    ),
                   
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  color: Colors.blue,
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => SingleChildScrollView(
                            child: Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: AddMatriculeScreen())));
                                  },
                ),
              ],
            ),
          ),
           Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0))),
                        child: TasksList(),
                      ),
                    )
        ],
      ),
    );
  }
}
