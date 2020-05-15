import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawqif/src/providers/connection_provider/authh.dart';
import 'package:mawqif/src/providers/users/users.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {

  

@override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}
  class ProfileState extends State<Profile>{
    @override
  initState()  {
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Users>(context);
    final notifier = Provider.of<Auth>(context);
    // TODO: implement build
    return Scaffold(appBar: AppBar(title:Text("         MON PROFIL", 
    style: TextStyle(color: Colors.blueGrey[800]),),
    backgroundColor: Colors.blueGrey[50],
    actions: <Widget>[
      FlatButton(child: Text("Modifier", style:TextStyle(color: Colors.blue)), onPressed: () {},)
    ],),
    
    body: Column(children: <Widget>[
      Container(height: 50,),
      Container(child: Text("${provider.findById(notifier.userId).nom} ${provider.findById(notifier.userId).prenom}", style: TextStyle(color: Colors.blueGrey[800],fontSize: 25))),
      SizedBox(height: 10,),
      Container (child: Text("${provider.findById(notifier.userId).codePersonnel}", style: TextStyle(fontWeight: FontWeight.w200),),),
      SizedBox(height: 25,),
      Container(
        margin: EdgeInsets.symmetric(vertical:10,horizontal: 15),
        //decoration: BoxDecoration(border: Border.merge(a, b),
        child: Row(children: <Widget>[
        Icon(Icons.mail , color: Colors.blue),
       // Container(width: 5,),
        Column(children: <Widget>[
          Container(child: Text("          adresse e-mail", style: TextStyle(color: Colors.blue))),
          SizedBox(height: 5,),
          Container(child: Text("           ${provider.findById(notifier.userId).email}",),)

          
        ],)
      ],),),
      Container(
        margin: EdgeInsets.symmetric(vertical:10,horizontal: 15),
        //decoration: BoxDecoration(border: Border.merge(a, b),
        child: Row(children: <Widget>[
        Icon(Icons.phone , color: Colors.blue),
       // Container(width: 5,),
        Column(children: <Widget>[
          Container(child: Text("      Télephone", style: TextStyle(color: Colors.blue))),
          SizedBox(height: 5,),
          Container(child: Text("           ${provider.findById(notifier.userId).telephone}",),)

          
        ],)
      ],),),
      


    ],
    ),
    
    );
  }

  

}