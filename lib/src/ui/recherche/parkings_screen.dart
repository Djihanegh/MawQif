import 'package:flutter/material.dart';
import 'package:mawqif/src/providers/parking_provider/parkings.dart';
import 'package:mawqif/src/ui/filtering/filter_chip.dart';
import 'package:mawqif/src/ui/widget/parkingItem.dart';
import 'package:provider/provider.dart';

class ParkingScreen extends StatefulWidget {
  

  
  @override
  State<StatefulWidget> createState() {
    return ParkingState();
  }
}
  class ParkingState extends State<ParkingScreen>
  {
     initState()  {
    Parkings parkNotifier = Provider.of<Parkings>(context, listen: false);
    parkNotifier.getParks();
     
  
  }
@override
  Widget build(BuildContext context) {
    Parkings parkNotifier = Provider.of<Parkings>(context);
  /*  CastFilter notifier = Provider.of<CastFilter>(context);
    CastFilter cast = new CastFilter();*/

    print("building Feed");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[50],
        iconTheme: IconThemeData(color: Colors.blueGrey[800]),
        actions: <Widget>[
           IconButton(icon: Icon(Icons.filter_list), onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context) =>   CastFilter()));
        },)
  
        ],
      ),
      body:  parkNotifier.items.isEmpty ?  Center(child: CircularProgressIndicator()) : FutureBuilder(
        future:parkNotifier.getParks(),
         builder: (BuildContext context, AsyncSnapshot dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (dataSnapshot.error != null) {
            return Center(
              child: Text('An error occurred!'),
            );
          } else { if(parkNotifier.items== null )
          {
            print("VIDE");
          }else {
            print("non vide ");
            return Consumer<Parkings>(
              builder: (ctx, orderData, child) => ListView.builder(
                itemCount: orderData.items.length,
                itemBuilder: (ctx, i) => 
                ParkingItem(orderData.items[i] , i),
              ),
            );
          }

         }

                }
         }
      )
      
     
    
    );
  }

}
