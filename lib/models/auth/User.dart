import 'package:mission_distributor/models/network_link.dart';

class User {
  late int id;
  late String name;
  late String email;
  late String? emailVerifiedAt;
  late String? avatar;
  late String? mobile;
  late String? dob;
  late String? gender;
  late String createdAt;
  late String updatedAt;


  User();

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    avatar = NetworkLink(link: json['avatar'] ?? '').link;
    mobile = json['mobile'];
    dob = json['dob'];
    gender = json['gender'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
