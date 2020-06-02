import 'package:flutter/material.dart';
import 'package:mawqif/src/models/parking.dart';
import 'package:mawqif/src/providers/parking_provider/parkings.dart';
import 'package:mawqif/src/ui/widget/rating.dart';
import 'package:provider/provider.dart';
import 'package:mawqif/src/ui/recherche/detail.dart';

class ParkingItem extends StatefulWidget {
  // final ReservationItems order;
  final Parking reservation;
  int i;

  ParkingItem(this.reservation, this.i);

  @override
  _ParkingItemState createState() => _ParkingItemState();
}

class _ParkingItemState extends State<ParkingItem> {
  double rating = 3.5;
  @override
  Widget build(BuildContext context) {
    Parkings provider = Provider.of<Parkings>(context);
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
              ListTile(
                title: Text(
                  '${widget.reservation.nom}',
                  style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontWeight: FontWeight.w700,
                      fontSize: 17.5,
                      letterSpacing: 0.2),
                ),
                subtitle: Text(
                  '${widget.reservation.adresse}',
                  style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontWeight: FontWeight.w400,
                      fontSize: 13.5,
                      letterSpacing: 0.1),
                ),
                trailing: //Consumer<Parkings>(
                    // builder: (ctx, product, _) =>
                    IconButton(
                  icon: Icon(
                    widget.reservation.liked
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    setState(() {
                      /*provider.toggleFavoriteStatus(
                          widget.i, widget.reservation.id);*/
                      if (widget.reservation.liked == true) {
                        
                        widget.reservation.liked = false;
                      } else {
                        widget.reservation.liked = true;
                        provider.fav_items.add(widget.reservation);
                      }
                    });
                  },
                ),
                //),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: StarRating(
                          // size: 20,
                          color: Colors.yellow[600],
                          rating: double.parse(widget.reservation.rating),
                          onRatingChanged: (rating) =>
                              //setState(() => this.rating = rating),

                              provider.updateRatingStars(
                                  rating.toString(), widget.reservation.id)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Text(
                        '${widget.reservation.prix}DA',
                        //"prix",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w800,
                            fontSize: 17),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      //    ),
      onPressed: () {
        provider.currentPark = widget.reservation;
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
