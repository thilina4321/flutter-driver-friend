import 'package:driver_friend/model/driver.dart';
import 'package:driver_friend/model/userType.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  final _user =
      User(name: 'Sai Pallavi', vehicleNumber: 'ABCD1818', vehicleType: 'Car');

  User get user {
    return _user;
  }

  var _userType = UserType.driver;

  UserType get appUser {
    print('Ape user ' + _userType.toString());
    return _userType;
  }

  UserType userType(newUser) {
    print('new' + newUser.toString());
    _userType = newUser;
    notifyListeners();
    return _userType;
  }
}
