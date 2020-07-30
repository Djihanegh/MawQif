import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mawqif/src/models/parking/parking.dart';
import 'package:mawqif/src/providers/parking_provider/parkings.dart';
import 'package:mawqif/src/ui/filtering/filter_chip.dart';
import 'package:mawqif/src/ui/widget/parkingItem.dart';
import 'package:provider/provider.dart';

class ParkingScreen extends StatefulWidget {
  final DocumentSnapshot document;

  const ParkingScreen({Key key, this.document}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ParkingState();
  }
}

class ParkingState extends State<ParkingScreen> {
  List<Parking> list = [];
  initState() {
   /* Parkings parkNotifier = Provider.of<Parkings>(context, listen: false);
   setState(() {
     list=parkNotifier.getMenuu(widget.document.data["userId"]) as List<Parking>;
   });  */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[50],
          iconTheme: IconThemeData(color: Colors.blueGrey[800]),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CastFilter()));
              },
            )
          ],
        ),
        body: 
            /*parkNotifier.items == null
            ? Text("vide")
            : StreamBuilder<QuerySnapshot>(
                stream: parkNotifier.getParks(),
                /*Firestore.instance
            .collection('loueur')
            .document('JAY4Idk3b4gs8kqhGEHt6KS27hg1')
            .collection('parking')
            .snapshots(),*/
                builder: (context, snapshot) {
                  //Parking park = snapshot.data.documents;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.error != null) {
                      return Center(
                        child: Text('An error occurred!'),
                      );
                    } else {
                      if (parkNotifier.items == null) {
                        print("VIDE");
                      } /*else {
                        print("non vide ");*/
                        /*return new ListView.builder(
              itemCount: snapshot.data.documents.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data.documents[index];

                return ParkingItem(document, index);
              },
            );*/
                        return ListView.builder(
                          itemCount: parkNotifier.items.length,
                          itemBuilder: (ctx, i) =>
                              ParkingItem(i, parkNotifier.items[i]),
                        );
                      
                    }
                  }
                })*/

        SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                new Container(height: 500, child: parksList(context, widget.document.data['userId'])),
              ],
            ))
            // parkNotifier.items.isEmpty ?  Center(child: CircularProgressIndicator()) :
           /* FutureBuilder<List<Parking>>(
                future: parkNotifier.getMenuu(widget.document.data['userId']),
                builder: (BuildContext context, AsyncSnapshot dataSnapshot) {
                  if (dataSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (dataSnapshot.error != null) {
                      return Center(
                        child: Text('An error occurred!'),
                      );
                    }
                    /*else { if(parkNotifier.items== null )
          {
            print("VIDE");
          }*/ /*else {
            print("non vide ");*/
                    return ListView.builder(
                      itemCount: dataSnapshot.data.documents.length,
                      itemBuilder: (ctx, i) =>
                          ParkingItem(dataSnapshot.data.documents[i], i),
                    );
                  }
                })*/);
  }

  Widget parksList(BuildContext context , String id) {
   // Parkings parkNotifier = Provider.of<Parkings>(context);

    return StreamBuilder<QuerySnapshot>(
            stream: 
            Firestore.instance
            .collection('loueur')
            .document(id)
            .collection('parking')
            .snapshots(),
            builder: (context, snapshot) {
             // Parking park = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.error != null) {
                  return Center(
                    child: Text('An error occurred!'),
                  );
                }/* else {
                  if (parkNotifier.items == null) {
                    print("VIDE");
                  } *//*else {
                    print("non vide ");*/
                    /*return new ListView.builder(
              itemCount: snapshot.data.documents.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data.documents[index];

                return ParkingItem(document, index);
              },
            );*/
              }
                    return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (ctx, i) =>
                          ParkingItem(snapshot.data.documents[i] , i),
                    );
                  
                }
              
            );
  }

  /* Widget chefList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('loueur').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          else {
            return new ListView.builder(
              itemCount: snapshot.data.documents.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data.documents[index];
                return KitchenCard(document: document);
              },
            );
          }
        });
  }*/

}
