import 'package:driver_friend/model/driver.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  final _user =
      User(name: 'Sai Pallavi', vehicleNumber: 'ABCD1818', vehicleType: 'Car');

  User get user {
    return _user;
  }
}
