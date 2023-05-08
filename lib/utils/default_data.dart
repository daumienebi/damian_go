import 'package:damian_go/model/damian_zone.dart';
import 'package:damian_go/model/user.dart';

/// Test data to properly construct the ui before switching to firestore
/// and other data sources
class DefaultData{
  List<DamianZone> _damianZones = [];
  List<User> _users = [];

  List<DamianZone> get getDamianZones => _getDamianZones();
  List<DamianZone> get getUsers => _getUsers();

  _getDamianZones(){
    return _damianZones = damianZones.map((element) => DamianZone.fromMap(element)).toList();
  }

  _getUsers(){
    return _users = users.map((element) => User.fromMap(element)).toList();
  }

  final damianZones = [];
  final users = [];
}