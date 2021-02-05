import 'dart:io';

import 'package:driver_friend/model/userType.dart';

class SparePartShop {
  String id;
  String email;
  String password;
  UserType userType;
  String address;
  int mobile;
  String about;
  String city;
  String openingTime;
  String closingTime;
  File profileImageUrl;
  String location;
  String mapImagePreview;
  double rating;
  String name;
  double latitude;
  double longitude;

  SparePartShop(
      {this.about,
      this.id,
      this.email,
      this.city,
      this.password,
      this.userType,
      this.mapImagePreview,
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
