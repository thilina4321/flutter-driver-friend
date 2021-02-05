import 'dart:io';

import 'package:driver_friend/model/userType.dart';

class ServiceCenter {
  String id;
  String address;
  int mobile;
  String about;
  String openingTime;
  String closingTime;
  File profileImageUrl;
  String location;
  double rating;
  String name;
  String city;

  double latitude;
  double longitude;
  String email;
  String password;
  UserType userType;
  String mapImagePreview;

  ServiceCenter(
      {this.id,
      this.city,
      this.mapImagePreview,
      this.about,
      this.email,
      this.password,
      this.userType,
      this.latitude,
      this.longitude,
      this.name,
      this.rating,
      this.address,
      this.closingTime,
      this.location,
      this.mobile,
      this.openingTime,
      this.profileImageUrl});
}
