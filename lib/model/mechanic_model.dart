import 'package:driver_friend/model/userType.dart';

class Mechanic {
  String id;
  String name;
  String nic;
  int mobile;
  String address;
  String about;
  int location;
  String imageUrl;
  double rating;
  UserType userType;

  Mechanic(
      {this.nic,
      this.userType,
      this.id,
      this.name,
      this.about,
      this.address,
      this.imageUrl,
      this.location,
      this.rating,
      this.mobile});
}
