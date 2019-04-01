import 'package:gs_schedule/models/package.dart';

class User {
  final String id;
  final String email;
  final String username;
  final bool isActive;
  final String description;
  final String expiredAt;
  final Package package;

  User({
    this.id,
    this.email,
    this.username,
    this.isActive,
    this.description,
    this.expiredAt,
    this.package,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["user"]["id"],
      email: json["user"]["email"],
      username: json["user"]["username"],
      isActive: json["user"]["is_active"] == 1,
      description: json["user"]["description"],
      expiredAt: json["user"]["expired_at"],
      package: Package.fromJson(json["package"]),
    );
  }

  toJson() {
    return {
      "id": this.id,
      "email": this.email,
      "username": this.username,
      "is_active": this.isActive,
      "description": this.description,
      "package": this.package.name,
    };
  }
}
