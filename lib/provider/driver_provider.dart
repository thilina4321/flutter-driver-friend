import 'package:driver_friend/model/drivert.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:flutter/material.dart';

class DriverProvider with ChangeNotifier {
  List<Driver> _drivers = [];
  TempararyUser _tempararyUser = TempararyUser();

  Driver get driver {
    return _drivers[0];
  }

  addToTempararyUser(TempararyUser tempararyUser) {
    _tempararyUser.email = tempararyUser.email;
    _tempararyUser.name = tempararyUser.name;
    _tempararyUser.password = tempararyUser.password;
    _tempararyUser.userType = tempararyUser.userType;
    print(_tempararyUser.userType);
    print(_tempararyUser.email);
    notifyListeners();
  }

  createDriver(Driver driver) {
    driver.id = (_drivers.length + 1).toString();
    driver.email = _tempararyUser.email;
    driver.name = _tempararyUser.name;
    driver.password = _tempararyUser.password;
    driver.userType = _tempararyUser.userType;
    print(driver.email);
    print(driver.nic);

    _drivers.add(driver);
    notifyListeners();
  }

  List<Driver> get drivers {
    return [..._drivers];
  }
}
