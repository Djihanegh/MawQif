import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mawqif/src/ui/plus/plus.dart';
import 'package:mawqif/src/ui/réservation/réservation_screen.dart';
import 'package:mawqif/src/ui/recherche/recherche_screen.dart';
import 'abonnement/abonnement.dart';


class Destination {
  const Destination(this.title, this.btn , this.color);
  final String title;
  final Icon btn;
  final Color color;
  
}

const List<Destination> allDestinations = <Destination>[
  Destination('Recherche', Icon(Icons.search , color: Colors.blue, ) , Colors.white),
  Destination('Réservations', Icon(Icons.date_range , color: Colors.blue, )  , Colors.white),
  Destination('Abonnements',Icon(Icons.contacts , color: Colors.blue, ), Colors.white),
  Destination('Plus', Icon(Icons.person , color: Colors.blue, )  , Colors.white),
];

class MyApp extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
      home: _DestinationView(),
    );
  }
}


class _DestinationView extends StatefulWidget {
  
   _DestinationView({Key key, this.destination}) : super(key: key);

  final Destination destination;

  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<_DestinationView> {
 
 
 
  int _selectedIndex = 0;

    List<Widget> _widgetOptions = <Widget>[
      Recherche(),
      Reservation(),
      Abonnement(),
      Plus()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
     body:Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
  bottomNavigationBar: BottomNavigationBar(

        items: allDestinations.map((Destination destination) {
          return BottomNavigationBarItem(
            icon: destination.btn,
            backgroundColor: destination.color,
            title: Text(destination.title)
          );
        }).toList(),
 
 
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,

        onTap: _onItemTapped,

  ),
  );
  }
}

  