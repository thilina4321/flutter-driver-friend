import 'dart:io';

import 'package:driver_friend/model/userType.dart';

class Mechanic {
  String id;
  String email;
  String password;
  String mapImagePreview;
  String name;
  String nic;
  String city;

  String mobile;
  String address;
  String about;
  int location;
  File profileImageUrl;
  double rating;
  UserType userType;
  double latitude;
  double longitude;

  Mechanic(
      {this.nic,
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
      this.location,
      this.rating,
      this.mobile});
}
