import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mawqif/src/models/reservation/reservation.dart';
import 'package:mawqif/src/providers/reservation_provider/reservations.dart';
import 'package:provider/provider.dart';

class ReservationItems extends StatefulWidget {
  // final ReservationItems order;
  final ReservationModel reservation;
  final int index;

  ReservationItems(this.reservation, this.index);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<ReservationItems> {
  //var _expanded = false;
  /* @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }*/

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Reservations>(context);
    List<String> list = ["Annuler ", "Modifier", "Supprimer"];
    //String id= Provider.of<User>(context,listen: false).getCurrentId();
    // final productId = ModalRoute.of(context).settings.arguments as String;
    // print(productId);

    return Dismissible(
      key: new Key(widget.reservation.id),
      onDismissed: (direction) {
        // provider.items.removeAt(widget.index);
        DatabaseReference dbRef =
            FirebaseDatabase.instance.reference().child("Reservation");
        dbRef
            .orderByChild("id")
            .equalTo(widget.reservation.id)
            .once()
            .then((DataSnapshot snapshot) {
          Map<dynamic, dynamic> children = snapshot.value;
          children.forEach((key, value) {
            FirebaseDatabase.instance
                .reference()
                .child('Reservation')
                .child(key)
                .remove();
          });
        });
        /*  .onChildAdded
            .listen((Event event) {
          FirebaseDatabase.instance
              .reference()
              .child('Reservation')
              .child(event.snapshot.key)
              .remove();
        }, onError: (Object o) {
          
          final DatabaseError error = o;
          print('ERRROOOOOOOR: ${error.code} ${error.message}');
        });*/

        /*  final result =
            dbRef.orderByChild("id").equalTo(widget.reservation.park.id);*/
        print("RESULLLTT===" + dbRef.toString());
        provider.deleteProduct(dbRef.toString());
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text("Réservation annuler !")));
      },
      //onDoubleTap:  Provider.of<Reservations>(context).deleteProduct(productId),
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('${widget.reservation.park.nom}'),
              subtitle: Text(" ${widget.reservation.heureD} PM -"
                  "${widget.reservation.heureF} PM"
                  //DateFormat('dd/MM/yyyy hh:mm').format('${widget.reservation.heureD}'),
                  ),
              trailing: IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  return Container(
                      child: ListView(
                          // itemCount: list.length,
                          //itemBuilder: (_,i) =>
                          children: list
                              .map((data) => RaisedButton(
                                    child: Text(data),
                                    onPressed: () {},
                                  ))
                              .toList()
                          /* Column(children: <Widget>[
                         RaisedButton(  child: Text("Annuler"), onPressed: () {}, ),
                  ],) */

                          //PopupMenuItem(child: Text("Annuler"),)

                          // RaisedButton(  child: Text(list[i]), onPressed: () {}, ),
                          // RaisedButton(  child: Text(list[i]), onPressed: () {}, ),

                          ));
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
                child: Align(
                  child: Text("status: ${widget.reservation.status} ",
                      textAlign: TextAlign.start),
                  alignment: Alignment.topLeft,
                ))
          ],
        ),
      ),
    );
  }
}
