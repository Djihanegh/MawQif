import 'package:flutter/cupertino.dart';

class AddressProvider extends ChangeNotifier {

  String address;

  String get adress => address ;

  set setadress(String adr){
    this.address = adr ;
    notifyListeners();
  }
}