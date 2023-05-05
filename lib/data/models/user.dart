import 'package:damian_go/data/models/damian_zone.dart';

/// Class to take care of the users
class User {
  final String _id;
  final String _username;
  final String _email;
  final DateTime _registrationDate;
  final List<DamianZone> _damianZones;
  final List<User> _followers;
  final List<User> _following;

  /// Create the constructor
  User(this._id, this._username, this._registrationDate, this._damianZones,
      this._followers, this._following, this._email);

  // Getters
  String get id => _id;
  String get username => _username;
  String get email => _email;
  DateTime get registrationDate => _registrationDate;
  List<DamianZone> get damianZones => _damianZones;
  List<User> get followers => _followers;
  List<User> get following => _following;
}
