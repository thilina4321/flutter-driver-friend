import 'package:dio/dio.dart';
import 'package:driver_friend/model/drivert.dart';
import 'package:driver_friend/model/mechanic_model.dart';
import 'package:driver_friend/model/service_center.dart';
import 'package:driver_friend/model/spare_shop.dart';
import 'package:driver_friend/model/userType.dart';
import 'package:flutter/cupertino.dart';

class User {
  String email;
  String password;
  String name;
  UserType userType;

  User({this.email, this.name, this.password, this.userType});
}

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

  Future<void> signup(User user) async {
    var data = {
      'email': user.email,
      'password': user.password,
      'userName': user.name,
    };
    Dio dio = new Dio();
    const url = 'https://driver-friend.herokuapp.com/api';
    var u;

    try {
      switch (user.userType) {
        case UserType.mechanic:
          u = await dio.post('$url/drivers/signup', data: data);
          break;
        case UserType.sparePartShop:
          u = await dio.post('$url/drivers/signup', data: data);
          break;
        case UserType.serviceCenter:
          u = await dio.post('$url/drivers/signup', data: data);
          break;
        default:
          u = await dio.post('$url/drivers/signup', data: data);
      }
      print(u);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  userType(newUser) {
    _userType = newUser;
    print(newUser);
    notifyListeners();
  }
}
