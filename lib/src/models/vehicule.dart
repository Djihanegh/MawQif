import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicule.g.dart';

@JsonSerializable()
class Vehicule {
  String vehiculeId;
  String userId;
  String immatriculation;
  bool isDone;

  Vehicule({
    @required userId,
    @required immatriculation,
    @required vehiculeId,
    @required isChecked,
    this.isDone = false,
  });

  void toggleDone() {
    this.isDone = !isDone;
  }
}
