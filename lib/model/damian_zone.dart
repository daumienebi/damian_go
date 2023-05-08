import 'package:damian_go/model/user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DamianZone{
  final int id;
  final LatLng latLng;
  final DateTime zoneDate;
  final User user;

  DamianZone(this.id, this.latLng, this.zoneDate, this.user);

  // fromMap method to create a DamianZone object from a map
  factory DamianZone.fromMap(Map<String, dynamic> json) => DamianZone(
    json['id'] as int,
    LatLng(json['latLng']['latitude'] as double, json['latLng']['longitude'] as double),
    DateTime.parse(json['zoneDate'] as String),
    User.fromMap(json['user'] as Map<String, dynamic>),
  );

  // toMap method to convert a DamianZone object to a map
  Map<String, dynamic> toMap() => <String, dynamic>{
    'id': id,
    'latLng': {'latitude': latLng.latitude, 'longitude': latLng.longitude},
    'zoneDate': zoneDate.toIso8601String(),
    'user': user.toMap(),
  };
}