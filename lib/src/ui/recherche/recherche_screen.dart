import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mawqif/src/providers/calendar_provider.dart/calendar_provider.dart';
import 'package:mawqif/src/providers/calendar_provider.dart/fincalendar_provider.dart';
import 'package:mawqif/src/providers/searcch_provider/address.dart';
import 'package:mawqif/src/providers/vehicule_provider/nomV_provider.dart';
import 'package:mawqif/src/ui/partners/partners.dart';
import 'package:mawqif/src/ui/recherche/calendar_view/calendar_screen.dart';
import 'package:mawqif/src/ui/recherche/parkings_screen.dart';
import 'package:mawqif/src/ui/recherche/search_screen.dart';
import 'package:mawqif/src/ui/widget/vehicule_type.dart';
import 'package:provider/provider.dart';
import 'package:mawqif/src/ui/recherche/calendar_view/calendar2.dart';

class Recherche extends StatelessWidget {
  @override
  Widget build(BuildContext inContext) {
    // var loadedMessages = Provider.of<SearchProvider>(inContext).getMessage();
    final provider = Provider.of<NomVehiculeProvider>(inContext);
    final providers = Provider.of<AddressProvider>(inContext);
    final calendarProvider = Provider.of<CalendarProvider>(inContext);
    final finCalendarProvider = Provider.of<FinCalendarProvider>(inContext);
    return MaterialApp(
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  bottom: TabBar(tabs: [
                    Tab(
                      icon: Icon(
                        Icons.date_range,
                        color: Colors.blue,
                      ),
                      child: Text('Réservation',
                          style: TextStyle(color: Colors.blue)),
                    ),
                    Tab(
                        icon: Icon(
                          Icons.contacts,
                          color: Colors.blue,
                        ),
                        child: Text('Abonnement',
                            style: TextStyle(color: Colors.blue))),
                  ]),
                ),
                body: TabBarView(
                  children: [
                    Column(children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(
                            left: 40.0, top: 60.0, right: 20.0, bottom: 60.0),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.place,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                  Container(
                                    height: 2.0,
                                  ),
                                  Text('Où voulez vous aller ?',
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.blue),
                                      textAlign: TextAlign.center),
                                  Container(
                                    height: 10.0,
                                    width: 10.0,
                                  ),
                                  Text(
                                    '${providers.address}',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.grey[400]),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.push(
                                  inContext,
                                  MaterialPageRoute(
                                      builder: (context) => Search()),
                                );
                              },
                            ),
                            Container(
                              height: 40.0,
                              width: 40.0,
                            ),
                            FlatButton(
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.time_to_leave, color: Colors.blue),
                                  Container(
                                    height: 2.0,
                                  ),
                                  Text('Type de votre véhicule ?',
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.blue),
                                      textAlign: TextAlign.center),
                                  Container(
                                    height: 10.0,
                                    width: 10.0,
                                  ),
                                  Text(
                                    '${provider.nomV}',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.grey[400]),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.push(
                                  inContext,
                                  MaterialPageRoute(
                                      builder: (context) => Vehicule()),
                                );
                              },
                            ),
                            Container(
                              height: 40.0,
                              width: 40.0,
                            ),
                            Container(
                              //  decoration: BoxDecoration
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                  Container(
                                    height: 2.0,
                                  ),
                                  Text('Quand ?',
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.blue),
                                      textAlign: TextAlign.center),
                                  Row(children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 43.0),
                                      child: FlatButton(
                                          child: Text(
                                            '${calendarProvider.getDate()} ',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.grey[400]),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              inContext,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Calendar()),
                                            );
                                          }),
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      color: Colors.blue,
                                    ),
                                    Padding(
                                      child: FlatButton(
                                          child: Text(
                                              '${finCalendarProvider.getDate()}',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.grey[400])),
                                          onPressed: () {
                                            Navigator.push(
                                              inContext,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Calendarr()),
                                            );
                                          }),
                                      padding: EdgeInsets.only(right: 12.0),
                                    )
                                  ]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 10.0,
                        width: 100.0,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.blue),
                          margin: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 15.0),
                          alignment: Alignment.bottomCenter,
                          child: FlatButton(
                            color: Colors.blue,
                            child: Text(
                              'Trouver une place',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  inContext,
                                  MaterialPageRoute(
                                      builder: (context) => PartnerScreen()));
                            },
                          ))
                    ]),
                    Icon(Icons.directions_transit),
                  ],
                ))));
  }
}
