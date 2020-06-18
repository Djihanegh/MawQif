import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawqif/src/models/parking.dart';
import 'package:mawqif/src/models/user.dart';
import 'package:mawqif/src/providers/reservation_provider/reservations.dart';
import 'package:provider/provider.dart';
import 'package:mawqif/src/ui/widget/reservation_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReservationItem {
  String heureD;
  String heureF;
  Parking park;
  User userInfo;
}

class Reservation extends StatefulWidget {
  get id => null;

  createState() {
    return ReservationState();
  }
}

class ReservationState extends State<Reservation> {
  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[50],
          iconTheme: IconThemeData(color: Colors.blueGrey[800]),
          actions: <Widget>[
            /*FlatButton(
              child: Text(
                "Se déconnecter",
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                _save('0');
                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new AuthScreen(),
                ));
              },
            ),*/
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<Reservations>(context, listen: false)
              .fetchAndSetReservations(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (dataSnapshot.error != null) {
              return Center(
                child: Text('Erreur veuillez réessayer!'),
              );
            
            }
            /*else if(dataSnapshot.data == null ) {
            return Center(child: Text("Vous n'avez aucune réservation actuellement "),);
          }*/

            else {
              return Consumer<Reservations>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.items.length,
                  itemBuilder: (ctx, i) =>
                      ReservationItems(orderData.items[i], i),
                ),
              );
            }
          },
        ));
  }
}
