import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mawqif/src/models/parking/parking.dart';
import 'package:flutter/material.dart';
import 'package:mawqif/src/providers/searcch_provider/search_provider.dart';
import 'package:mawqif/src/ui/filtering/filter_chip.dart';
import 'dart:math' as MATH;


class Parkings with ChangeNotifier {
  List<Parking> items = [];

  List<Parking> fav_items= [];

  List<Parking> get parks {
    return [...items];
  }

  CastFilter filter = new CastFilter();

  Parking currentPark;

  UnmodifiableListView<Parking> get parkList => UnmodifiableListView(items);


  updateUsers(String docID, int nb) {
    Firestore.instance
        .collection("parking")
        .document(docID)
        .setData({'users': nb}, merge: true);
  }

  updateProfit(String docID, int prix) {
    Firestore.instance
        .collection("parking")
        .document(docID)
        .setData({'profit': prix}, merge: true);
  }

  Parking findById(String id) {
    return items.firstWhere((prod) => prod.id == id);
  }

  Future<void> getParks() async {
    List<Parking> parkList = [];
    List<Parking> finalList = [];

    List<Parking> list = [];
    SearchProvider service = new SearchProvider();
    GeoPoint loc = await service.displayCurrentLocation();
    try {
      var snapshot =
          await Firestore.instance.collection("parking").getDocuments();
      if (snapshot.documents.isNotEmpty) {
        list = snapshot.documents
            .map((snapshot) => Parking.fromMap(snapshot.data))
            .where((mappedItem) => mappedItem.nonvalide != true)
            .toList();
      }

      for (int i = 0; i < list.length; i++) {
        Parking park = list.elementAt(i);

        GeoPoint points = park.location;

        double lat1 = points.latitude;
        double long1 = points.longitude;
        /* USER  COORDINATES */
        double lat2 = loc.latitude;
        double long2 = loc.longitude;

        final double distance2 =
            await Geolocator().distanceBetween(lat1, long1, lat2, long2);

        if (distance2 <= 6000) {
          parkList.add(park);
        } else {
          print("no");
        }
      }
      if (CastFilter.filters.isNotEmpty) {
        for (int i = 0; i < CastFilter.filters.length; i++) {
          print(CastFilter.filters.length);
          if (CastFilter.filters[i] == "Couvert") {
            parkList.forEach((item) {
              if (item.couvert == true) {
                finalList.add(item);
              }
            });
          }else if (CastFilter.filters[i] == "Souterrain") {
            parkList.forEach((item) {
              if (item.souterrain == true) {
                finalList.add(item);
              }
            });
          }else if (CastFilter.filters[i] == "Vidéo surveillance") {
            parkList.forEach((item) {
              if (item.videosurveillance == true) {
                finalList.add(item);
              }
            });
          }else if (CastFilter.filters[i] == "Eclairé") {
            parkList.forEach((item) {
              if (item.eclaire == true) {
                finalList.add(item);
              }
            });
          }
        }
      }
      if (finalList.isNotEmpty) {
        items = finalList;
      } else {
        items = parkList;
      }
    } catch (error) {
      print(error);

      throw error;
    }
  }


  
  static double calculerDistance(
      double lat1, double lat2, double long1, double long2) {
    double distance = MATH.cos((MATH.sin(lat1) * MATH.sin(lat2) +
            MATH.cos(lat1) * MATH.cos(lat2) * MATH.cos(long1 - long2))) *
        6371;
    return distance;
  }

  static double calculerDistancee(
      double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295; // Math.PI / 180
    var c = MATH.cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;

    return 12742 * MATH.asin(MATH.sqrt(a)); // 2 * R; R = 6371 km
  }

  updatePlaces(String docID, int newplaces) {
    Firestore.instance
        .collection("parking")
        .document(docID)
        .setData({'places': newplaces}, merge: true);
  }

  updateRatingStars(String rating, String docID) {
    Firestore.instance
        .collection("parking")
        .document(docID)
        .setData({'rating': rating}, merge: true);
  }

  
  
  /*String statusDeParking() {
    if (avaiblePark() == true) {
      currentPark.status = 'Ouvert';
      return 'Ouvert';
    } else {
      currentPark.status = 'Fermé';
      return 'Fermé';
    }
    //notifyListeners();
  }*/

  static String findID(Parking park) {
    String id;

    if (park.nom == "Parking stambouli") {
      id = "OuIKYvBmFh6r1iEN5g1J";
      /* } 
      else if(park.nom=="Parking ELISA")
      {
        id ="FJQsipFHEdBgtP4sSHmL" ;*/
    } else if (park.nom == "Parking Elborhane") {
      id = "ND6EXJ0xfglJ4rEAtLYE";
//}
      /*else if(park.nom == "Parking chabbou")
      {
        id="VI8N4YgoAhsdx1zESPeA";
      }else if(park.nom == "parking agha")
      {
        id="YKwQUEwIxiO0fsKOolD7";*/
    } else if (park.nom == "ggggggg") {
      id = "JfsfJzDKXJF0vxjuU5WV";
    } else if (park.nom == "joujou") {
      id = "8BFV4rgtIaSlRoeXEBsY";
    }
    return id;
  }

  /*bool isFavorite = false;
  void _setFavValue(bool newValue, int i) {
    items[i].liked = newValue;
    notifyListeners();
  }*/

  void toggleFavoriteStatus(int i, String docID)  {
    items[i].liked = !items[i].liked;
    notifyListeners();  
    changeStatus( i , docID);}

    void changeStatus(int i , String docID)  {

    DocumentReference reference =
         Firestore.instance.collection("parking").document(docID);
     Firestore.instance
        .collection("parking")
        .document(reference.documentID)
        .setData({'liked': items[i].liked}, merge: true);
  }


}