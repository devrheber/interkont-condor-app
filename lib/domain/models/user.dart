import 'package:flutter/foundation.dart';

class User {
  const User({@required this.username, @required this.token});
  final String username;
  final String token;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json['username'],
        token: json['user_token'],
      );
}
