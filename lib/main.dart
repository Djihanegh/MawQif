import 'package:flutter/material.dart';
import 'package:mawqif/src/providers/vehicule_provider/vehicule_provider.dart';
import 'package:provider/provider.dart';
import 'package:mawqif/src/providers/connection_provider/authh.dart';
import 'package:mawqif/src/ui/filtering/filter_chip.dart';
import 'package:mawqif/src/ui/réservation/authentification/auth_screen.dart';

import './src/models/user.dart';
import './src/providers/map/states.dart';
import './src/providers/parking_provider/parkings.dart';
import './src/providers/reservation_provider/reservations.dart';
import './src/providers/users/users.dart';
import './src/ui/home_screen.dart';
import './src/ui/recherche/calendar_view/calendar2.dart';
import './src/ui/recherche/calendar_view/calendar_screen.dart';
import './src/ui/recherche/search_screen.dart';
import './src/utils/loading.dart';
var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => MyApp(),
  //"/intro": (BuildContext context) => MyApp(),
};
void main() {
  runApp(
      /*MaterialApp(home: new RootPage(auth: new Auth())) );*/
      MultiProvider(
          providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(
          create: (context) => Parkings(),
        ),
        /* ChangeNotifierProvider(
          create: (context) => Recherche2(),
        ),*/
        ChangeNotifierProvider(create: (context) => Search()),
        ChangeNotifierProvider(create: (context) => Calendarr()),
        ChangeNotifierProvider(create: (context) => Calendar()),
        ChangeNotifierProvider(create: (context) => AppState()),
        ChangeNotifierProvider(create: (context) => VehiculeProvider()),

        /*ChangeNotifierProxyProvider<Auth, ReservationModel>(
          /*create: (Auth auth, Reservations previousProducts,) => Reservations(
                auth.token,
                previousProducts == null ? [] : previousProducts.items,),*/
           update: (BuildContext context, Auth value, ReservationModel previous)
               => Reservations(value.token, previous == null ? [] : previous.items,value.userId,),
                create: (BuildContext context) => ReservationModel(),

        ),*/

        ChangeNotifierProvider(create: (context) => Reservations()),
        ChangeNotifierProvider(create: (context) => User()),
        ChangeNotifierProvider(create: (context) => Users()),
        ChangeNotifierProvider(create: (context) => AppState()),
        ChangeNotifierProvider(create: (context) => CastFilter()),
      ],
          child:
              // Abonnement()));

              MaterialApp(
                  home: Consumer<Auth>(
                      builder: (ctx, auth, _) => MaterialApp(
                          home: auth.isAuth
                              ? MyApp()
                              : FutureBuilder(
                                  future: auth.tryAutoLogin(),
                                  builder: (ctx, authResultSnapshot) =>
                                      authResultSnapshot.connectionState ==
                                              ConnectionState.waiting
                                          ? LoadingScreen() 
                                          : AuthScreen(),
                                ))))));
}

/*class MyMyApp extends StatelessWidget {
 


   static var kGoogleApiKeyy = "AIzaSyBFAL1xVp6dbs7A8r3H05LCXGXjKhy7qbE";
   var location ;
   var lat ='36.9255183';
   var long = '36.9255183';
   var radius = '800';
   var types = 'parking';
   List<String> msp =["heloo"];
  

  
  void didChangeDependencies() async{
        
        msp = await searchNearBy();
        if(msp == null )
        {print('OKKK');}
        print(msp);
        
  }  

  Future  searchNearBy () async {
    var dio = Dio();
    var urll = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=36.754238,3.058807&radius=2500&type=parking&key=AIzaSyBFAL1xVp6dbs7A8r3H05LCXGXjKhy7qbE';

    var parameters = {
      'key': kGoogleApiKeyy,
      'location': '$lat , $long',
      'radius': '800',
      //'keyword': keyword,
    };
    var response = await dio.get(urll); 
    var list = response.data['results'].map<String>((result) => result['name'].toString()).toList();
    msp=list ;
    
    
    print(list);
    //return list ;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold ( body: Column(
                    children: <Widget>[
 RaisedButton(
   child:  Text('press here '),
    onPressed:()
    {
      //didChangeDependencies();
      searchNearBy();
    },
 ) ,
  Text(msp.toString()),
                    ],
    )
                     );
                   
  }
}*/

/*main() {
  runApp(MyAppAAA());
}*/
/*class MyAppiiii extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coding with Curry',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.lightBlue,
      ),
      home: Home()
    
       
      );
  }*/

/*import 'dart:async';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:mawqif/src/ui/place_detail.dart';

const kGoogleApiKey = "AIzaSyBFAL1xVp6dbs7A8r3H05LCXGXjKhy7qbE";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

void main() {
  runApp(MaterialApp(
    title: "PlaceZ",
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController mapController;
  List<PlacesSearchResult> places = [];
  bool isLoading = false;
  String errorMessage;

  @override
  Widget build(BuildContext context) {
    Widget expandedChild;
    if (isLoading) {
      expandedChild = Center(child: CircularProgressIndicator(value: null));
    } else if (errorMessage != null) {
      expandedChild = Center(
        child: Text(errorMessage),
      );
    } else {
      expandedChild = buildPlacesList();
    }

    return Scaffold(
        key: homeScaffoldKey,
        appBar: AppBar(
          title: const Text("PlaceZ"),
          actions: <Widget>[
            isLoading
                ? IconButton(
                    icon: Icon(Icons.timer),
                    onPressed: () {},
                  )
                : IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      refresh();
                    },
                  ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _handlePressButton();
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: SizedBox(
                  height: 200.0,
                  child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      /*options: GoogleMapOptions(*/
                          myLocationEnabled: true,
                          initialCameraPosition:
                          CameraPosition(target: LatLng(0.0, 0.0)))),
            ),
            Expanded(child: expandedChild)
          ],
        ));
  }

  void refresh() async {
    final center = await getUserLocation();

    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: center == null ? LatLng(0, 0) : center, zoom: 15.0)));
    getNearbyPlaces(center);
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    refresh();
  }

  Future<LatLng> getUserLocation() async {
    var currentLocation ;
    final location = LocationManager.Location();
    try {
      currentLocation = await location.getLocation();
      final lat = currentLocation["latitude"];
      final lng = currentLocation["longitude"];
      final center = LatLng(lat, lng);
      return center;
    } on Exception {
      currentLocation = null;
      return null;
    }
  }

  void getNearbyPlaces(LatLng center) async {
    setState(() {
      this.isLoading = true;
      this.errorMessage = null;
    });

    final location = Location(center.latitude, center.longitude);
    final result = await _places.searchNearbyWithRadius(location, 2500);
    setState(() {
      this.isLoading = false;
      if (result.status == "OK") {
        this.places = result.results;
        result.results.forEach((f) {
          final markerOptions = Marker(
              position:
                  LatLng(f.geometry.location.lat, f.geometry.location.lng),
              infoWindow: InfoWindow(title: '${f.name}' , snippet:'${f.types?.first}'));
          //mapController.add(MarkerOptions);
        });
      } else {
        this.errorMessage = result.errorMessage;
      }
    });
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  Future<void> _handlePressButton() async {
    try {
      final center = await getUserLocation();
      Prediction p = await PlacesAutocomplete.show(
          context: context,
          strictbounds: center == null ? false : true,
          apiKey: kGoogleApiKey,
          onError: onError,
          mode: Mode.fullscreen,
          language: "en",
          location: center == null
              ? null
              : Location(center.latitude, center.longitude),
          radius: center == null ? null : 10000);

      showDetailPlace(p.placeId);
    } catch (e) {
      return;
    }
  }

  Future<Null> showDetailPlace(String placeId) async {
    if (placeId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PlaceDetailWidget(placeId)),
      );
    }
  }

  ListView buildPlacesList() {
    final placesWidget = places.map((f) {
      List<Widget> list = [
        Padding(
          padding: EdgeInsets.only(bottom: 4.0),
          child: Text(
            f.name,
            style: Theme.of(context).textTheme.subtitle,
          ),
        )
      ];
      if (f.formattedAddress != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.formattedAddress,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ));
      }

      if (f.vicinity != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.vicinity,
            style: Theme.of(context).textTheme.body1,
          ),
        ));
      }

      if (f.types?.first != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.types.first,
            style: Theme.of(context).textTheme.caption,
          ),
        ));
      }

      return Padding(
        padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
        child: Card(
          child: InkWell(
            onTap: () {
              showDetailPlace(f.placeId);
            },
            highlightColor: Colors.lightBlueAccent,
            splashColor: Colors.red,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: list,
              ),
            ),
          ),
        ),
      );
    }).toList();

    return ListView(shrinkWrap: true, children: placesWidget);
  }
}*/
