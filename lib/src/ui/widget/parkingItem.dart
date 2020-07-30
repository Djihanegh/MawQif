import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mawqif/src/models/parking/parking.dart';
import 'package:mawqif/src/ui/widget/rating.dart';
import 'package:mawqif/src/ui/recherche/detail.dart';

@immutable
class ParkingItem extends StatefulWidget {
  // final ReservationItems order;
  //final Parking reservation;
  final int i;
  final DocumentSnapshot document;

  ParkingItem(
    this.document,
    this.i,
   // this.reservation
  );

  @override
  _ParkingItemState createState() => _ParkingItemState();
}

class _ParkingItemState extends State<ParkingItem> {
  double rating = 3.5;
  @override
  Widget build(BuildContext context) {
    //Parkings provider = Provider.of<Parkings>(context);
    //bool favorite = widget.reservation.liked;

    return FlatButton(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 6,
        color: Colors.blueGrey[50],
        child: Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Column(
            children: <Widget>[
              listTile(),
              row(),
            ],
          ),
        ),
      ),
      onPressed: () {
        //provider.currentPark = widget.reservation;
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
         // builder: (context) => DraggableSheet(widget.i,widget.reservation),
        );
      },
    );
  }

  Widget price() {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Text( '',
     //   '${widget.reservation.prix}DA',
        style: TextStyle(
            color: Colors.blue, fontWeight: FontWeight.w800, fontSize: 17),
      ),
    );
  }

  Widget ratingwidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: StarRating(
        color: Colors.yellow[600],
        //rating: double.parse(widget.reservation.rating),
        // onRatingChanged: (rating) =>
        //setState(() => this.rating = rating),

        /* provider.updateRatingStars(rating.toString(),
                                  widget.document.data['id'])*/
      ),
    );
  }

  Widget listTile() {
    return ListTile(
        title: titleTile(),
        subtitle: subtitileListTile(),
        trailing: trailing());
  }

  Widget titleTile() {
    return Text('ggt',
    //  '${widget.reservation.nom}',
      style: TextStyle(
          color: Colors.blueGrey[800],
          fontWeight: FontWeight.w700,
          fontSize: 17.5,
          letterSpacing: 0.2),
    );
  }

  Widget subtitileListTile() {
    return Text("dfe",
    // '${widget.reservation.adresse}',
      style: TextStyle(
          color: Colors.blueGrey[800],
          fontWeight: FontWeight.w400,
          fontSize: 13.5,
          letterSpacing: 0.1),
    );
  }

  Widget trailing() {
    return IconButton(
      icon: Icon( Icons.favorite
       // widget.document.data['liked'] ? Icons.favorite : Icons.favorite_border,
      ),
      color: Theme.of(context).accentColor,
      onPressed: () {
        setState(() {
          /*provider.toggleFavoriteStatus(
                          widget.i, widget.reservation.id);*/
      /*    if (widget.document.data['liked'] == true) {
            widget.document.data['liked'] = false;
          } else {
            widget.document.data['liked'] = true;
            //provider.fav_items.add(widget.reservation);
          }*/
        });
      },
    );
  }

  Widget row() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[ratingwidget(), price()],
      ),
    );
  }
}
