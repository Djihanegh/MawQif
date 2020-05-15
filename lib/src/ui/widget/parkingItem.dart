import 'package:flutter/material.dart';
import 'package:mawqif/src/models/parking.dart';
import 'package:mawqif/src/providers/parking_provider/parkings.dart';
import 'package:provider/provider.dart';
import 'package:mawqif/src/ui/recherche/detail.dart';



class ParkingItem extends StatefulWidget {
 // final ReservationItems order;
  final Parking reservation ;
   int i;

  ParkingItem(this.reservation);

  @override
  _ParkingItemState createState() => _ParkingItemState();
}

class _ParkingItemState extends State<ParkingItem> {

  /*@override
  Widget build(BuildContext context) {
   // List<String> list = ["Annuler ", "Modifier", "Supprimer"];
    // String id= Provider.of<User>(context,listen: false).getCurrentId();
    return 
      Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              " ${widget.reservation.nom}"),
           subtitle: Text(              " ${widget.reservation.adresse}"

              //DateFormat('dd/MM/yyyy hh:mm').format('${widget.reservation.heureD}'),
            ),
            trailing: IconButton(
              icon: Icon(Icons.more_vert), onPressed: () {},
             /* onPressed: () {
                return Container ( child :ListView(
                 // itemCount: list.length,
                  //itemBuilder: (_,i) =>
                 /* children: list.map(
                    (data) => RaisedButton(child:Text(data), onPressed: () {} , )
                  ).toList()*/
                 /* Column(children: <Widget>[
                         RaisedButton(  child: Text("Annuler"), onPressed: () {}, ),
                  ],) */
                  
                    //PopupMenuItem(child: Text("Annuler"),)
                      
                     // RaisedButton(  child: Text(list[i]), onPressed: () {}, ),
                      // RaisedButton(  child: Text(list[i]), onPressed: () {}, ),

                  
                ) );

              },*/
              /*icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },*/
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
             // height: min(widget.order.products.length * 20.0 + 10, 100),
             /* child: ListView(
                children: widget.reservation.park
                    .map(
                      (prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                prod.nom,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${prod.places}x \$${prod.prix}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                    )
                    .toList(),
              ),*/
            )
        ],
      ),
    //) 
    );
  }*/

   @override
  Widget build(BuildContext context) {
     Parkings provider = Provider.of<Parkings>(context); 
            return FlatButton(
              child:
             Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 6,
                  color: Colors.blueGrey[50],
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                           '${widget.reservation.nom}',
                           //"helo",
                            style: TextStyle(
                                color: Colors.blueGrey[800],
                                fontWeight: FontWeight.w700,
                                fontSize: 17.5,
                                letterSpacing: 0.2
                            ),
                          ),
                          subtitle: Text(
                            '${widget.reservation.adresse}',
                           //"hi",
                            style: TextStyle(
                                color: Colors.blueGrey[800],
                                fontWeight: FontWeight.w400,
                                fontSize: 13.5,
                                letterSpacing: 0.1

                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                /*child: StarRating(
                                  size: 20,
                                  color: Colors.yellow[600],
                                  rating: recentList[index].rating,
                                ),*/
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Text(
                                  '${widget.reservation.prix}DA',
                               //"prix",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 17
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
           //   ),
            ), onPressed: () {
              provider.currentPark=widget.reservation;
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) =>

                      //SingleChildScrollView(
                      //  child:Container(
                      //     padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      DraggableSheet(widget.i),
                );
            },
            );
          }
    
}
