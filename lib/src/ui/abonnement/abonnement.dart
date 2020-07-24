import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawqif/src/ui/widget/qr_code.dart';
import 'package:provider/provider.dart';
import 'package:mawqif/src/providers/reservation_provider/reservations.dart';
class Abonnement extends StatefulWidget {
  String heureD;
  String heureF;
 
  get id => null;

  createState() {
    return ReservationState();
  }
}

class ReservationState extends State<Abonnement> {

  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[50],
        iconTheme: IconThemeData(color: Colors.blueGrey[800]),
              ),
        body: FutureBuilder(
      future: Provider.of<Reservations>(context, listen: false)
          .fetchAndSetReservations(),
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
              builder: (ctx, orderData, child) => /*ListView.builder(
                itemCount: orderData.items.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, i) => */
               QrCode(orderData.items[0].userInfo)
            // ),
            );
          }
        }
      },
    ));
  }
}
