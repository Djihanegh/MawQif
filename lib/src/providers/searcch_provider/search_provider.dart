import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
class SearchProvider extends ChangeNotifier {
  String _ville = "Ville..";

  String _messages = "Ville..";

  double _lat;

  double _long;

  String get ville => _ville;

  String get message => _messages;

  double get latitude => _lat;

  double get longitude => _long;

  void setVille(String ville) {
    this._ville = ville;
    notifyListeners();
  }

  void setMessage(String msg) {
    this._messages = msg;
    notifyListeners();
  }

  void setLatitude(double lat) {
    this._lat = lat;
    notifyListeners();
  }

  void setLongitude(double long) {
    this._long = long;
    notifyListeners();
  }



  static var kGoogleApiKeyy = "AIzaSyBFAL1xVp6dbs7A8r3H05LCXGXjKhy7qbE";

  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKeyy);
  Position _location = Position(latitude: 0.0, longitude: 0.0);

  

  Future<GeoPoint> displayCurrentLocation() async {
    final __location = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(__location.latitude, __location.longitude);
   
    GeoPoint points = new GeoPoint(__location.latitude, __location.longitude);
    this.setMessage(placemark[0].administrativeArea + "," + placemark[0].locality);
    print("AAAAAAAAA"+placemark[0].administrativeArea + "," + placemark[0].locality);
    this.setLatitude(__location.latitude);
    this.setLongitude(__location.longitude);
    return points;
  }

  void getNearByPlaces(double _latitude, double _longtude) async {
    final location = Location(_location.latitude, _location.longitude);
    final result = await _places.searchNearbyWithRadius(location, 2500);
    if (result.status == "OK") {
    }
  }


  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;
    }
  }

}
