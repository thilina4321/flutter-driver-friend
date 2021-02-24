import 'dart:io';

class SparePartShop {
  String id;
  String userId;
  String address;
  String mobile;
  String about;
  String city;
  String openingTime;
  String closingTime;
  File profileImageUrl;
  double rating;
  double latitude;
  double longitude;
  String name;
  String mapImagePreview;

  SparePartShop(
      {this.about,
      this.mapImagePreview,
      this.name,
      this.userId,
      this.id,
      this.city,
      this.latitude,
      this.longitude,
      this.rating,
      this.address,
      this.closingTime,
      this.mobile,
      this.openingTime,
      this.profileImageUrl});
}
