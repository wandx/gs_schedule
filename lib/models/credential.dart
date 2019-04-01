import 'package:meta/meta.dart';

class Credential {
  final String username;
  final String password;

  Credential({@required this.username, @required this.password});

  toJson() {
    return {
      "username": this.username,
      "password": this.password,
    };
  }
}
