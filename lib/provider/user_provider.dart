import 'package:driver_friend/model/driver.dart';
import 'package:driver_friend/model/userType.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  final _user = User(vehicleNumber: 'ABCD1818');

  User get user {
    return _user;
  }

  var _userType = UserType.driver;

  UserType get appUser {
    return _userType;
  }

  UserType userType(newUser) {
    _userType = newUser;
    notifyListeners();
    return _userType;
  }
}
