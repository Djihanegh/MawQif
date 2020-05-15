import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mawqif/src/models/Reservation.dart';
import 'package:http/http.dart' as http;
import 'package:mawqif/src/models/parking.dart';
import 'package:mawqif/src/models/user.dart';
import 'package:mawqif/src/providers/connection_provider/authh.dart';
import 'dart:collection';

class Reservations with ChangeNotifier {
   final String authToken ="";

  final String _userId = null;

  List<ReservationModel> items = [];

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
    items.removeWhere((_food) => _food.id == res.id) ;
    notifyListeners();
  }

  ReservationModel findById(String id) {
    return items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetReservations() async {
    const url = 'https://mawqif-6ac74.firebaseio.com/Reservation.json';
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser currentUser = await auth.currentUser();
    Auth authh =new Auth();
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<ReservationModel> loadedReservations = [];
      extractedData.forEach((resId, resData) {
        String userInfo = User.fromJson(resData['userInfo']).uid;
        if (userInfo == authh.userId || userInfo == currentUser.uid) {
          loadedReservations.add(ReservationModel(
              id: resId,
              nom: resData['nom'],
              heureD: resData['heureD'],
              heureF: resData['heureF'],
              park: Parking.fromJson(resData['park']),
              userInfo: User.fromJson(resData['userInfo']),
              codeReservation: resData['codeRes'],
              status: resData['status']));
        } else {
          print("NOT EQUAL ");
        }
      });

      items = loadedReservations;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addReservations(ReservationModel product) async {
    const url = 'https://mawqif-6ac74.firebaseio.com/Reservation.json?';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          //'id': product.id,
          // 'nom': product.nom,
          'park': product.park,
          'heureD': product.heureD,
          'heureF': product.heureF,
          'userInfo': product.userInfo,
          'codeRes': product.codeReservation,
          'status': product.status,
        }),
      );
      print("reponse = " + response.body);
      final newProduct = ReservationModel(
          // id: product.id,
          // nom: product.nom,
          park: product.park,
          heureD: product.heureD,
          heureF: product.heureF,
          userInfo: product.userInfo,
          status: product.status
          //codeReservation: 1,
          //dateF: json.decode(response.body)['name'],
          );

      items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Auth user = Auth();
  //var userId = Auth.userId ;
  Future<void> addOrder(ReservationModel product) async {
    final url = 'https://mawqif-6ac74.firebaseio.com/Reservation.json';
    //final timestamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'id': product.id,
        'nom': product.nom,
        'park': product.park,
        'heureD': product.heureD,
        'heureF': product.heureF,
        'todo': product.userInfo,
      }),
    );
    items.insert(
      0,
      ReservationModel(
        id: json.decode(response.body)['id'],
        nom: json.decode(response.body)['nom'],
        heureD: json.decode(response.body)['heureD'],
        heureF: json.decode(response.body)['heureF'],
        park: json.decode(response.body)['park'],
        userInfo: json.decode(response.body)['userInfo'],
      ),
    );
    notifyListeners();
  }
}
