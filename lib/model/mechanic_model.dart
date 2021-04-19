import 'dart:io';

import 'package:driver_friend/model/userType.dart';

class Mechanic {
  String id;
  String userId;
  String email;
  String password;
  String mapImagePreview;
  String name;
  String nic;
  String city;

  String mobile;
  String address;
  String about;
  File profileImageUrl;
  double rating;
  UserType userType;
  double latitude;
  double longitude;

  Mechanic(
      {this.nic,
      this.userId,
      this.city,
      this.latitude,
      this.longitude,
      this.userType,
      this.email,
      this.password,
      this.mapImagePreview,
      this.id,
      this.name,
      this.about,
      this.address,
      this.profileImageUrl,
      this.rating,
      this.mobile});
}
