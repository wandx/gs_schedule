import 'package:meta/meta.dart';

class Credential {
  String username;
  String password;

  Credential({@required this.username, @required this.password});

  Map<String,dynamic> toJson() {
    return {
      "username": this.username,
      "password": this.password,
    };
  }

  Map<String,dynamic> toMap() {
    return {
      "username": this.username,
      "password": this.password,
    };
  }
}
