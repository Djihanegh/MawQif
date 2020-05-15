import 'package:flutter/material.dart';
import 'package:mawqif/src/providers/parking_provider/parkings.dart';
import 'package:mawqif/src/ui/widget/parkingItem.dart';
import 'package:provider/provider.dart';

class ParkingScreen extends StatefulWidget {
  

  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
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
    print("building Feed");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[50],
        iconTheme: IconThemeData(color: Colors.blueGrey[800]),
      ),
      body:parkNotifier.items== null ?  Center(child: CircularProgressIndicator()) : FutureBuilder(
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
                ParkingItem(orderData.items[i]),
              ),
            );
          }

         }

                }
         }
     
    )
    );
  }

 Widget _parkingItem(String titre , String sub , String image , String prix) {

    return Card (
      child :FlatButton(
      child:Column(children: <Widget>[
        
        Image.network(image , width: 300, height: 90,
                fit: BoxFit.fitWidth,),
          Container(
            margin: EdgeInsets.only(right:53),
            child: 
          Text(titre), ),
          Container(height: 7,),
          Container(
            margin: EdgeInsets.only(left:10),
            child:
          Text(sub),
          ),
       
       Container(child: Align(
          alignment: Alignment.topRight,
          child:Icon(Icons.chevron_right) )),
          Container(child:
          Align(
          alignment: Alignment.bottomRight,
          child:Text(prix+"DA")) ),

        ],), onPressed: () {},
    ));

  }
}
