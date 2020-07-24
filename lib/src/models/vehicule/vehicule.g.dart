// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicule _$VehiculeFromJson(Map<String, dynamic> json) {
  return Vehicule()
    ..vehiculeId = json['vehiculeId'] as String
    ..userId = json['userId'] as String
    ..immatriculation = json['immatriculation'] as String;
}

Map<String, dynamic> _$VehiculeToJson(Vehicule instance) => <String, dynamic>{
      'vehiculeId': instance.vehiculeId,
      'userId': instance.userId,
      'immatriculation': instance.immatriculation,
    };
