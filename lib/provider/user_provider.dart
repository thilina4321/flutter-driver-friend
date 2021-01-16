import 'package:driver_friend/model/driver.dart';
import 'package:driver_friend/model/mechanic_model.dart';
import 'package:driver_friend/model/service_center.dart';
import 'package:driver_friend/model/spare_shop.dart';
import 'package:driver_friend/model/userType.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  var _userType = UserType.driver;

  final Mechanic _mechanic = Mechanic(
      id: '3',
      rating: 4.5,
      userType: UserType.mechanic,
      name: "Fernando",
      address: '66 Homagama',
      mobile: 0712345433);

  final ServiceCenter _serviceCenter = ServiceCenter(
      id: '1',
      rating: 4.5,
      name: 'Liyo Service Center',
      mobile: 0777777777,
      address: 'Alpitiya');

  final SparePartShop _spareShop = SparePartShop(
      id: '2',
      rating: 3.0,
      name: 'Tharuka Spare shop ',
      mobile: 077777777,
      address: 'Dehiattakandiya');

  SparePartShop get spareShop {
    return _spareShop;
  }

  ServiceCenter get serviceCenter {
    return _serviceCenter;
  }

  Mechanic get mechanic {
    return _mechanic;
  }

  UserType get user {
    return _userType;
  }

  userType(newUser) {
    _userType = newUser;
    print(newUser);
    notifyListeners();
  }
}
