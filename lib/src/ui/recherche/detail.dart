import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mawqif/src/providers/connection_provider/authh.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:mawqif/src/providers/parking_provider/parkings.dart';
import 'package:mawqif/src/providers/reservation_provider/reservations.dart';
import 'package:mawqif/src/models/Reservation.dart';
import 'package:mawqif/src/models/user.dart';
import 'package:mawqif/src/ui/r%C3%A9servation/r%C3%A9servation_screen.dart';
import 'package:mawqif/src/ui/recherche/calendar_view/calendar2.dart';
import 'package:mawqif/src/ui/recherche/calendar_view/calendar_screen.dart';
import 'package:mawqif/src/ui/recherche/recherche_screen.dart';
import 'package:mawqif/src/ui/map_wrapper.dart';

class DraggableSheet extends StatefulWidget {
  int i;
  DraggableSheet(this.i);
  @override
  _DraggableSheetState createState() => _DraggableSheetState();
}

class _DraggableSheetState extends State<DraggableSheet> {
  var maxHeight = 0.65;
                                                // Auth authh = new Auth ();

  @override
  Widget build(BuildContext context) {
    int placeDisponible = Provider.of<Parkings>(context).currentPark.places;
    Parkings parkNotifier = Provider.of<Parkings>(context);
    int prix = Provider.of<Parkings>(context).currentPark.prix;
    Calendar calendarNotifier = Provider.of<Calendar>(context);
    Calendarr claendarFinNotifier = Provider.of<Calendarr>(context);


    bool _isLoading = false;

    return Scaffold(
        body: DraggableScrollableSheet(
      initialChildSize: 0.25,
      maxChildSize: 1.0,
      minChildSize: 0.25,
      builder: (context, scrollController) {
        return Container(
            child: SingleChildScrollView(
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 1.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            height: MediaQuery.of(context).size.height * 1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                Provider.of<Parkings>(context).currentPark.nom,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22.4,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              SizedBox(
                                width: 110,
                              ),
                              //Expanded(child:
                              IconButton(
                                icon: Icon(Icons.map),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyApp()));
                                },
                              )
                              //)
                            ],
                          ),
                          /*                          SizedBox(
                            height: 2,
                          ),*/
                          Text(
                            Provider.of<Parkings>(context).currentPark.adresse,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                                fontSize: 12,
                                letterSpacing: 0.2),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(
                                    Icons.local_parking,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                color: Colors.grey[900],
                                elevation: 4,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "$placeDisponible places",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.4),
                              ),
                              SizedBox(
                                width: 24,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "$prix DA",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.4),
                              )
                            ],
                          )
                        ],
                        //)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0, top: 8),
                      child: ClipRRect(
                        /*child: Image.asset(
                          'image/garage.jpg',
                          fit: BoxFit.cover,
                          width: 120,
                          height: 110,*/

                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    'Heure de travail',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[400],
                        fontSize: 12,
                        letterSpacing: 0.2),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    Provider.of<Parkings>(context).horaireDeTravail(),
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[900],
                        fontSize: 18,
                        letterSpacing: 0.2),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    "ouvert",
                   // Provider.of<Parkings>(context).statusDeParking(),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                        fontSize: 12.4,
                        letterSpacing: 0.2),
                  ),
                ),
                SizedBox(
                  height: 38,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    'Contacts',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[400],
                        fontSize: 12,
                        letterSpacing: 0.2),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.call,
                        size: 16,
                        color: Colors.grey[700],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        Provider.of<Parkings>(context).currentPark.nTelephone,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[900],
                            fontSize: 18,
                            letterSpacing: 0.2),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.web_asset,
                        size: 16,
                        color: Colors.grey[700],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        Provider.of<Parkings>(context).currentPark.email,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[900],
                            fontSize: 14.4,
                            letterSpacing: 0.2),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 44,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    'Addresse',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[400],
                        fontSize: 12,
                        letterSpacing: 0.2),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    Provider.of<Parkings>(context).currentPark.rue,
                    //provider.items[widget.i].rue,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[900],
                        fontSize: 16.5,
                        letterSpacing: 0.2),
                  ),
                ),
                SizedBox(
                  height: 44,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    'Ma réservation',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[400],
                        fontSize: 12,
                        letterSpacing: 0.2),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    'De ${Provider.of<Calendar>(context).getDate()}-${Provider.of<Calendar>(context).getFmt()} A ${Provider.of<Calendar>(context).getDate()}-${Provider.of<Calendarr>(context).getFmt()}',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[900],
                        fontSize: 16.5,
                        letterSpacing: 0.2),
                  ),
                ),
                SizedBox(
                  height: 130,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 24),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      onPressed: () async {
                            final FirebaseAuth auth = FirebaseAuth.instance;
                                  Auth authh = new Auth();
                       final FirebaseUser currentUser =
                            await auth.currentUser();
                            print("UID=========== "+authh.userId);
                       
                               User user = new User(uid: authh.userId);
                        CircularProgressIndicator();
                        
                        if (parkNotifier.currentPark.places >= 1) {
                          _isLoading = false;
                          String id = Parkings.findID(parkNotifier.currentPark);
                          if (authh.userId != null || currentUser.uid != null ) {
                            int nb = parkNotifier.currentPark.places - 1;

                            Provider.of<Parkings>(context).updatePlaces(id, nb);

                            int nbUsers = parkNotifier.currentPark.users;
                            nbUsers++;
                            
                            parkNotifier.updateUsers(id, nbUsers);
                            int profit = parkNotifier.currentPark.profit;
                            profit=profit+parkNotifier.currentPark.prix;
                            parkNotifier.updateProfit(
                                id, profit);
                                ReservationModel product = new ReservationModel(
                            park: parkNotifier.currentPark,
                            heureD: calendarNotifier.getFmt(),
                            heureF: claendarFinNotifier.getFmt(),
                            userInfo: user,
                            status: "à venir");


                            Provider.of<Reservations>(context)
                                .addReservations(product);

                            Fluttertoast.showToast(
                                msg: "Réservation réussie !",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            Fluttertoast.showToast(
                                msg: "Connectez vous !",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            print("CONECTEZ VOUS !!!");
                          }
                          //print(id);
                          //print(parkNotifier.currentFood.places);
                        } else if (parkNotifier.currentPark.places == 0) {
                          print("ya plus de places dans ce parking");
                          Fluttertoast.showToast(
                              msg: "Parking complet !",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Recherche()));
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Reservation()));
                        // Navigator.pop(context);
                      },
                      color: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'RESERVER',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            wordSpacing: 4,
                            letterSpacing: 0.3),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
      },
    )
        // ]
        // )
        );
  }

  Widget _showDialogue(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Alerte !"),
            content: new Text(
                "Veuillez vous connecter pour réserver une place s'il vous plait"),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text("Close "),
              )
            ],
          );
        });
  }
}
