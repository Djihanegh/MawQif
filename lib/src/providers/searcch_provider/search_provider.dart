import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

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

  Future<GeoPoint> displayCurrentLocation() async {
    final __location = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(__location.latitude, __location.longitude);

    GeoPoint points = new GeoPoint(__location.latitude, __location.longitude);
    this.setMessage(
        placemark[0].administrativeArea + "," + placemark[0].locality);
    this.setLatitude(__location.latitude);
    this.setLongitude(__location.longitude);
    return points;
  }
}
