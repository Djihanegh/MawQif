import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawqif/src/models/reservation/reservation.dart';
import 'package:http/http.dart' as http;
import 'package:mawqif/src/models/exception/http_exception.dart';
import 'package:mawqif/src/models/user/user.dart';
import 'package:mawqif/src/providers/connection_provider/authh.dart';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Reservations with ChangeNotifier {
  Auth authh = new Auth();

  final Firestore _firestore = Firestore.instance;

  List<ReservationModel> items = [];

  List<ReservationModel> reservationItems = [];

  List<ReservationModel> get reservations {
    return [...items];
  }

  ReservationModel _currentReservation;

  UnmodifiableListView<ReservationModel> get resList =>
      UnmodifiableListView(items);

  ReservationModel get currentRes => _currentReservation;

  /*set ReservationList(List<ReservationModel> foodList) {
    items = foodList;
    notifyListeners();
  }
*/
  set currentRes(ReservationModel res) {
    currentRes = res;
    notifyListeners();
  }

  addReservation(ReservationModel res) {
    items.insert(0, res);
    notifyListeners();
  }

  deleteReservation(ReservationModel res) {
    items.removeWhere((_food) => _food.id == res.id);
    notifyListeners();
  }

  ReservationModel findById(String id) {
    return items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetReservations(String userId) async {
    /* const url = 'https://mawqif-6ac74.firebaseio.com/Reservation.json';
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final uid = extractedUserData['userId'];*/
    try {
      List<ReservationModel> loadedReservations = [];

      /* final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<ReservationModel> loadedReservations = [];
      extractedData.forEach((resId, resData) {
        String userInfo = User.fromJson(resData['userInfo']).uid;
        if (userInfo == uid) {
          loadedReservations.add(ReservationModel(
            id: resData['id'],
            heureD: resData['heureD'],
            heureF: resData['heureF'],
            park: Parking.fromJson(resData['park']),
            status: resData['status'],
          ));
        } else {
          return;
        }
      });
*/

      var snapshot = await _firestore
          .collection("loueur")
          .document()
          .collection("orders")
          .where("userInfo", isEqualTo: userId)
          .getDocuments();

      if (snapshot.documents.isNotEmpty) {
        loadedReservations = snapshot.documents
            .map((e) => ReservationModel.fromMap(e.data))
            .toList();
      }
      items = loadedReservations;

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> addReservations(ReservationModel product, String ownerId) async {
    const url = 'https://mawqif-6ac74.firebaseio.com/Reservation.json';

    try {
      /* final response = await http.post(
        url,
        body: json.encode({
          'id': product.id,
          'park': product.park,
          'heureD': product.heureD,
          'heureF': product.heureF,
          'userInfo': product.userId,
          'codeRes': product.codeReservation,
          'status': product.status,
        }),
      );
    */ //  print("reponse = " + response.body);
      final newProduct = ReservationModel(
          id: product.id,
          park: product.park,
          heureD: product.heureD,
          heureF: product.heureF,
          userId: product.userId,
          status: product.status);

      _firestore
          .collection("loueur")
          .document(ownerId)
          .collection("orders")
          .document(product.id)
          .setData({
        'id': product.id,
        'parkId': product.park.id,
        'heureD': product.heureD,
        'heureF': product.heureF,
        'userInfo': product.userId,
        'status': product.status,
      });

      reservationItems.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<bool> hasReserved() async {
    bool hasReserved = false;
    const url = 'https://mawqif-6ac74.firebaseio.com/Reservation.json';

    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final uid = extractedUserData['userId'];

    // Checking if the user has previous reservation
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return hasReserved = false;
      }
      final List<ReservationModel> loadedReservations = [];
      extractedData.forEach((resId, resData) {
        String userInfo = User.fromJson(resData['userInfo']).uid;
        if (userInfo == uid) {
          hasReserved = true;
        }
      });
    } catch (e) {
      print(e.toString());
    }
    return hasReserved;
  }

  Future<void> updateProduct(String id, ReservationModel newProduct) async {
    final prodIndex = items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = 'https://mawqif-6ac74.firebaseio.com/Reservation/$id.json';
      await http.patch(url,
          body: json.encode({
            /* 'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.prix*/
          }));
      items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://mawqif-6ac74.firebaseio.com/Reservation/$id.json';
    final existingProductIndex = items.indexWhere((prod) => prod.id == id);
    var existingProduct = items[existingProductIndex];
    items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
