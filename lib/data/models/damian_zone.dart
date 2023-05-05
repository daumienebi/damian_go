import 'package:damian_go/data/models/user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DamianZone{

  final int id;
  final LatLng latLng;
  final DateTime zoneDate;
  final User user;

  DamianZone(this.id, this.latLng, this.zoneDate, this.user);
}