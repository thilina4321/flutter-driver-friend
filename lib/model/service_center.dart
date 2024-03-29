import 'dart:io';

import 'package:driver_friend/model/userType.dart';

class ServiceCenter {
  String id;
  String userId;
  String address;
  String mobile;
  String about;
  String openingTime;
  String closingTime;
  String profileImageUrl;
  String location;
  double rating;
  String name;
  int count;
  String city;

  double latitude;
  double longitude;
  String email;
  String password;
  UserType userType;
  String mapImagePreview;

  ServiceCenter(
      {this.id,
      this.count,
      this.userId,
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
