import 'dart:io';

import 'package:driver_friend/model/userType.dart';

class Driver {
  String id;
  String email;
  String password;
  String name;
  String nic;
  String mobile;
  String vehicleNumber;
  String vehicleColor;
  File profileImageUrl;
  File vehicleImageUrl;
  UserType userType;
  double latitude;
  double longitude;
  String mapImagePreview;

  Driver(
      {this.id,
      this.name,
      this.mapImagePreview,
      this.latitude,
      this.longitude,
      this.userType,
      this.email,
      this.password,
      this.nic,
      this.mobile,
      this.vehicleNumber,
      this.vehicleColor,
      this.profileImageUrl,
      this.vehicleImageUrl});
}