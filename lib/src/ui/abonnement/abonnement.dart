import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawqif/src/ui/widget/qr_code.dart';
import 'package:provider/provider.dart';
import 'package:mawqif/src/providers/reservation_provider/reservations.dart';

class Abonnement extends StatefulWidget {
  // String heureD;
  // String heureF;

  //get id => null;

  createState() {
    return ReservationState();
  }
}

class ReservationState extends State<Abonnement> {
  String id;
  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[50],
          iconTheme: IconThemeData(color: Colors.blueGrey[800]),
        ),
        body: FutureBuilder(
          future: Provider.of<Reservations>(context, listen: false)
              .fetchAndSetReservations(
            id,
          ),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.error != null) {
                return Center(
                  child: Text('An error occurred!'),
                );
                /*}else if (dataSnapshot.data == null) {
             return Center (child: Text('Aucune reservation'),);*/
              } else {
                return Consumer<Reservations>(
                    builder: (ctx, orderData, child) =>
                        /*ListView.builder(
                itemCount: orderData.items.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, i) => */
                        QrCode(
                            orderData.items[0].userId,
                            orderData.items[0].immatricule,
                            orderData.items[0].id,
                            orderData.items[0].ownerId)
                    // ),
                    );
              }
            }
          },
        ));
  }

  Future<String> getUserId() async {
    FirebaseUser currentUser;

    final FirebaseAuth auth = FirebaseAuth.instance;
    currentUser = await auth.currentUser();
    setState(() {
      id = currentUser.uid;
    });
    return currentUser.uid;
  }
}
