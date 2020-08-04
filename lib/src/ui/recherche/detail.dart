import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mawqif/src/models/parking/parking.dart';
import 'package:mawqif/src/providers/calendar_provider.dart/calendar_provider.dart';
import 'package:mawqif/src/providers/calendar_provider.dart/fincalendar_provider.dart';
import 'package:mawqif/src/ui/widget/detail_screen/caracteristic_title.dart';
import 'package:mawqif/src/ui/widget/detail_screen/contact_title.dart';
import 'package:mawqif/src/ui/widget/detail_screen/couvert.dart';
import 'package:mawqif/src/ui/widget/detail_screen/eclaire.dart';
import 'package:mawqif/src/ui/widget/detail_screen/hauteur_maximale.dart';
import 'package:mawqif/src/ui/widget/detail_screen/heure_de_travail.dart';
import 'package:mawqif/src/ui/widget/detail_screen/ouvert_title.dart';
import 'package:mawqif/src/ui/widget/detail_screen/poussette.dart';
import 'package:mawqif/src/ui/widget/detail_screen/souterrain.dart';
import 'package:mawqif/src/ui/widget/detail_screen/tirait.dart';
import 'package:mawqif/src/ui/widget/detail_screen/top_screen.dart';
import 'package:mawqif/src/ui/widget/detail_screen/video_surveillance.dart';
import 'package:mawqif/src/ui/widget/qr_code.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mawqif/src/providers/parking_provider/parkings.dart';
import 'package:mawqif/src/providers/reservation_provider/reservations.dart';
import 'package:mawqif/src/models/reservation/reservation.dart';
import 'package:mawqif/src/models/user/user.dart';
import 'package:mawqif/src/ui/recherche/recherche_screen.dart';
import 'package:uuid/uuid.dart';

@immutable
class DraggableSheet extends StatefulWidget {
  final int i;
  final DocumentSnapshot document;
  DraggableSheet(this.i, this.document);
  @override
  _DraggableSheetState createState() => _DraggableSheetState();
}

class _DraggableSheetState extends State<DraggableSheet> {
  var maxHeight = 0.65;
  String ownerId;
  String id;
  @override
  Widget build(BuildContext context) {
    final resProvider = Provider.of<Reservations>(context);
    final parkNotifier = Provider.of<Parkings>(context);
    var calendarNotifier = Provider.of<CalendarProvider>(context);
    var claendarFinNotifier = Provider.of<FinCalendarProvider>(context);
    bool _reserver = false;
    bool _isLoading = false;

    String immatricule;
    TextEditingController textController = new TextEditingController();

    return Scaffold(
        body: DraggableScrollableSheet(
      initialChildSize: 0.25,
      maxChildSize: 1.0,
      minChildSize: 0.25,
      builder: (context, scrollController) {
        return Container(
            child: SingleChildScrollView(
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 1.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            height: MediaQuery.of(context).size.height * 1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Tirait(),
                TopScreen(widget.document),
                SizedBox(
                  height: 16,
                ),
                HeureDeTravail(),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    horaireDeTravail(),
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[900],
                        fontSize: 18,
                        letterSpacing: 0.2),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                OuvertTitle(),
                SizedBox(
                  height: 30,
                ),
                ContactTitle(),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.call,
                        size: 16,
                        color: Colors.grey[700],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.document.data['nTelephone'],
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[900],
                            fontSize: 18,
                            letterSpacing: 0.2),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.web_asset,
                        size: 16,
                        color: Colors.grey[700],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.document.data['email'],
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[900],
                            fontSize: 14.4,
                            letterSpacing: 0.2),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                CaracteristicTitle(),
                SizedBox(
                  height: 8,
                ),
                HauteurMaximale(widget.document),
                Couvert(widget.document),
                Souterrain(widget.document),
                Eclaire(widget.document),
                VideoSurveillance(widget.document),
                PoussetteBagage(widget.document),
                Padding(
                    padding: const EdgeInsets.only(left: 30, top: 30),
                    child: TextFormField(
                      controller: textController,
                      onChanged: (value) {
                        immatricule = value;
                      },
                      validator: (value) =>
                          value.isEmpty ? 'immatricule est obligatoire' : null,
                      decoration: InputDecoration(
                        hintText: "N° d'immatricule",
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 24),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      onPressed: () async {
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        final FirebaseUser currentUser =
                            await auth.currentUser();

                        User user = new User(
                            uid: currentUser.uid,
                            immatriculations: immatricule);
                        CircularProgressIndicator();
                        bool hasReserved = await resProvider.hasReserved();
                        if (widget.document.data['places'] >= 1 &&
                            hasReserved == false &&
                            textController.text.isNotEmpty) {
                          _isLoading = false;
                          id = widget.document.data['id'];

                          if (currentUser.uid != null) {
                            int nb = widget.document.data['places'] - 1;
                            parkNotifier.updatePlaces(id, nb, ownerId);

                            int nbUsers = widget.document.data['users'];
                            nbUsers++;

                            ownerId = widget.document.data["ownerId"];

                            parkNotifier.updateUsers(id, nbUsers, ownerId);
                            int profit = widget.document.data['profit'];
                            profit = profit + widget.document.data['prix'];
                            parkNotifier.updateProfit(id, profit, ownerId);

                            Parking park = new Parking(
                                id: widget.document.data['id'],
                                nom: widget.document.data['nom'],
                                prix: widget.document.data['prix'],
                                adresse: widget.document.data['addresse'],
                                imageURL: widget.document.data['imageUrl']);

                            ReservationModel product = new ReservationModel(
                                id: Uuid.NAMESPACE_URL,
                                park: park,
                                heureD: calendarNotifier.getFmt(),
                                heureF: claendarFinNotifier.getFmt(),
                                userId: currentUser.uid,
                                immatricule: immatricule,
                                status: "à venir");

                            resProvider.addReservations(product, ownerId);

                            _reserver = true;

                            Fluttertoast.showToast(
                                msg: "Réservation réussie !",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            Fluttertoast.showToast(
                                msg: "Connectez vous !",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        } else if (widget.document.data['places'] == 0) {
                          Fluttertoast.showToast(
                              msg: "Parking complet !",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Recherche()));
                        } else if (hasReserved == true) {
                          Fluttertoast.showToast(
                              msg: "Vous avez déjà réservé une place !",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else if (textController.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Matricule est obligatoire !",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                        if (_reserver) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QrCode(currentUser.uid,
                                      immatricule, ownerId, id)));
                        }
                      },
                      color: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'RESERVER',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            wordSpacing: 4,
                            letterSpacing: 0.3),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
      },
    ));
  }

  String horaireDeTravail() {
    String hD = widget.document.data['heureDouverture'];
    String hF = widget.document.data['heureDeFermeture'];
    return "$hD AM - $hF PM ";
  }
}
