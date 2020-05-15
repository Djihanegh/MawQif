import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:mawqif/src/providers/reservation_provider/reservations.dart' as ord;
import 'package:mawqif/src/models/Reservation.dart';
import 'package:mawqif/src/models/user.dart';
import 'package:provider/provider.dart';



class ReservationItems extends StatefulWidget {
 // final ReservationItems order;
  final ReservationModel reservation ;

  ReservationItems(this.reservation);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<ReservationItems> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    List<String> list = ["Annuler ", "Modifier", "Supprimer"];
     String id= Provider.of<User>(context,listen: false).getCurrentId();
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('${widget.reservation.park.nom}'),
            subtitle: Text(
              " ${widget.reservation.heureD} PM -" "${widget.reservation.heureF} PM"
              //DateFormat('dd/MM/yyyy hh:mm').format('${widget.reservation.heureD}'),
            ),
            trailing: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                return Container ( child :ListView(
                 // itemCount: list.length,
                  //itemBuilder: (_,i) =>
                  children: list.map(
                    (data) => RaisedButton(child:Text(data), onPressed: () {} , )
                  ).toList()
                 /* Column(children: <Widget>[
                         RaisedButton(  child: Text("Annuler"), onPressed: () {}, ),
                  ],) */
                  
                    //PopupMenuItem(child: Text("Annuler"),)
                      
                     // RaisedButton(  child: Text(list[i]), onPressed: () {}, ),
                      // RaisedButton(  child: Text(list[i]), onPressed: () {}, ),

                  
                ) );

              },
              /*icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },*/
            ),
          ),
         // if (_expanded)
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
              child: Align(child:Text("status: ${widget.reservation.status} " , textAlign: TextAlign.start),
              alignment: Alignment.topLeft,
               )
               
            )
        ],
      ),
    );
  }
}
