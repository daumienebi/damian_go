import 'package:damian_go/model/damian_zone.dart';

/// Class to take care of the users
class User {
  final String _id;
  final String _username;
  final String _email;
  final bool _isVerified;
  final DateTime _registrationDate;
  final List<DamianZone> _damianZones;
  final List<User> _followers;
  final List<User> _following;

  /// Create the constructor
  User(this._id, this._username, this._registrationDate, this._damianZones,
      this._followers, this._following, this._email, this._isVerified);

  // Getters
  String get id => _id;
  String get username => _username;
  String get email => _email;
  bool get isVerified => _isVerified;
  DateTime get registrationDate => _registrationDate;
  List<DamianZone> get damianZones => _damianZones;
  List<User> get followers => _followers;
  List<User> get following => _following;

  // fromMap method to create a User object from a map
  factory User.fromMap(Map<String, dynamic> json) {
    final damianZones = List<DamianZone>.from((json['damianZones'] as List<dynamic>)
        .map((dynamic item) => DamianZone.fromMap(item as Map<String, dynamic>)));
    final followers =
    List<User>.from((json['followers'] as List<dynamic>).map((dynamic item) => User.fromMap(item as Map<String, dynamic>)));
    final following =
    List<User>.from((json['following'] as List<dynamic>).map((dynamic item) => User.fromMap(item as Map<String, dynamic>)));

    return User(
      json['id'] as String,
      json['username'] as String,
      DateTime.parse(json['registrationDate']),
      damianZones,
      followers,
      following,
      json['email'] as String,
      json['isVerified'] as bool,
    );
  }

  // toMap method to convert a User object to a map
  Map<String, dynamic> toMap() => <String, dynamic>{
    'id': id,
    'username': username,
    'email': email,
    'isVerified': isVerified,
    'registrationDate': registrationDate.toIso8601String(),
    'damianZones': List<dynamic>.from(damianZones.map((DamianZone item) => item.toMap())),
    'followers': List<dynamic>.from(followers.map((User item) => item.toMap())),
    'following': List<dynamic>.from(following.map((User item) => item.toMap())),
  };

}
