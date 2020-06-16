import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';

class Search extends StatelessWidget with ChangeNotifier {
  String selectedCurrency, selectedType;
  String getWilaya() => selectedType;

  static String messages = "Ville... ";

  static var kGoogleApiKeyy = "AIzaSyBFAL1xVp6dbs7A8r3H05LCXGXjKhy7qbE";

  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKeyy);
  Position _location = Position(latitude: 0.0, longitude: 0.0);
  // String message =" ";

  String ville = "Ville..";
  static String rue = "";
  static double villelat;
  static double villelong;
  String _positionActuelle = "Ma position actuelle";

  String getVille() => ville;
  String getRue() => rue;
  String getMessage() => messages;
  void setMessages(String value) {
    ville = value;
    notifyListeners();
  }

  TextEditingController t1 = new TextEditingController();
  void initState() {
    t1 = TextEditingController();
  }

  void dispose() {
    super.dispose();
    t1.dispose();
  }

  Future<GeoPoint> displayCurrentLocation() async {
    final __location = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(__location.latitude, __location.longitude);
    /*print(placemark[0].country);
   print(placemark[0].position);
   print(placemark[0].locality);
   print(placemark[0].administrativeArea);
   print(placemark[0].postalCode);
   print(placemark[0].name);
  // print(placemark[0].subAdministratieArea);
   print(placemark[0].isoCountryCode);
   print(placemark[0].subLocality);
   print(placemark[0].subThoroughfare);
   print(placemark[0].thoroughfare);*/

    // message = "${_location.latitude} , ${_location.longitude}";
    ville = placemark[0].locality;
    messages = placemark[0].administrativeArea + "," + placemark[0].locality;
    villelat = __location.latitude ;
    villelong = __location.longitude;
    //Location location = new Location(ville_lat,ville_long);
    GeoPoint points = new GeoPoint(villelat, villelong);
    // __location.longitude ;
    rue = placemark[0].name;
    print("messages" + messages);
    //Text('$Search.ville = placemark[0].administrativeArea + "," + placemark[0].locality' , style: TextStyle( color:Colors.blue) ) ;
    //Text('$Provider.of<Search>.messages = placemark[0].administrativeArea + "," + placemark[0].locality' , style: TextStyle( color:Colors.blue) ) ;
    return points;
    // notifyListeners() ;
  }

  void getNearByPlaces(double _latitude, double _longtude) async {
    final location = Location(_location.latitude, _location.longitude);
    final result = await _places.searchNearbyWithRadius(location, 2500);
    if (result.status == "OK") {
      //this.places = result.results;
      // result.results.forEach((f) {
      print(result.results);
    }
  }

  //final Geolocator _geolocator = Geolocator();
  //final TextEditingController _addressTextController = TextEditingController();

  List<String> _placemarkCoords = [];

  /*Future<void> _onLookupCoordinatesPressed(BuildContext context) async {
    final List<Placemark> placemarks =
        await Future(() => _geolocator.placemarkFromAddress(t1.text))
            .catchError((onError) {});

    if (placemarks != null && placemarks.isNotEmpty) {
      final Placemark pos = placemarks[0];
      final List<String> coords = placemarks
          .map((placemark) =>
              pos.position?.latitude.toString() +
              ', ' +
              pos.position?.longitude.toString())
          .toList();

      _placemarkCoords = coords;
      notifyListeners();
    }
  }*/

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);

      //var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

     // var address = await Geocoder.local.findAddressesFromQuery(p.description);

      print(lat);
      print(lng);
    }
  }

  @override
  Widget build(BuildContext context) {
    //final loadedMessages = Provider.of<Search>(context).getMessage();
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text(
                '       Addresse de destination',
                style: TextStyle(
                    color: Colors.blueGrey, fontStyle: FontStyle.normal),
              ),
              backgroundColor: Colors.white,
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
            backgroundColor: Colors.white,
            body: Column(
              children: <Widget>[
                Container(
                  width: 15.0,
                  height: 2.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[50]))),
                  child: TextField(
                      /* onTap: () async {
                  Prediction p = await PlacesAutocomplete.show(
                  context: context, apiKey: kGoogleApiKey);
                  displayPrediction(p); },*/
                      controller: t1,
                      autofocus: true,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        labelText:
                            '${Provider.of<Search>(context).getMessage()}',
                        focusColor: Colors.grey,
                      ),
                      onSubmitted: (String value) async {
                        Provider.of<Search>(context).setMessages(value);
                      }),
                ),
                Container(height: 5.0, width: 5.0),
                Container(
                    child: FlatButton(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.gps_fixed,
                        color: Colors.blue,
                      ),
                      Container(
                        width: 15.0,
                      ),
                      Text(
                        _positionActuelle,
                        style: TextStyle(color: Colors.blueGrey[800]),
                      ),
                    ],
                  ),
                  onPressed: () {
                    String a = displayCurrentLocation() as String;
                    Provider.of<Search>(context).setMessages(a);
                  },
                )),
                Container(height: 5.0, width: 5.0),
                /*  Container( 
           child : FlatButton(child: Row(children: <Widget>[
                   Icon(Icons.gps_fixed , color:  Colors.blue,),
                   Container(width: 15.0,),
                   Text("_positionActuelle"),
                   
           ],), onPressed: () {

               _onLookupCoordinatesPressed(context);
               
              
           },
        
           )
         ),*/

                Flexible(
                    child: ListView.builder(
                  itemCount: _placemarkCoords.length,
                  itemBuilder: (context, index) =>
                      Text(_placemarkCoords[index]),
                )),
              ],
            )));
  }
}
