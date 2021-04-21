import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:driver_friend/model/userType.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  String email;
  String password;
  String name;
  UserType userType;

  User({this.email, this.name, this.password, this.userType});
}

class UserProvider with ChangeNotifier {
  String _id;
  String _userName;
  String _role;
  String _token;
  var u;

  Dio dio = new Dio();
  final url = 'https://driver-friend.herokuapp.com/api/drivers';
  final signupurl = 'https://driver-friend.herokuapp.com/api';
  var _userType = UserType.driver;

  get token {
    if (_token == null) {
      return null;
    }
    return _token;
  }

  get role {
    return _role;
  }

  UserType get user {
    return _userType;
  }

  get me {
    return {
      'id': _id,
      'role': _role,
      'token': _token,
      'userName': _userName,
    };
  }

  Future<void> signup(User user) async {
    var data = {
      'email': user.email,
      'password': user.password,
      'userName': user.name
    };

    try {
      switch (user.userType) {
        case UserType.mechanic:
          u = await dio.post('$signupurl/mechanics/signup', data: data);
          break;
        case UserType.serviceCenter:
          u = await dio.post('$signupurl/service-centers/signup', data: data);
          break;
        case UserType.sparePartShop:
          u = await dio.post('$signupurl/sparepart-shops/signup', data: data);
          break;
        default:
          u = await dio.post('$signupurl/drivers/signup', data: data);
      }
      // print(u);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> login(email, password) async {
    try {
      var user = await dio
          .post('$url/login', data: {'email': email, 'password': password});

      var pref = await SharedPreferences.getInstance();

      var userData = json.encode({
        'id': user.data['user']['_id'],
        'role': user.data['user']['role'],
        'token': user.data['token'],
        'userName': user.data['user']['userName']
      });

      _id = user.data['user']['_id'];
      _token = user.data['token'];
      _role = user.data['user']['role'];
      _userName = user.data['user']['userName'];

      pref.setString('userData', userData);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  tryAutoLogin() async {
    var pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('userData')) {
      return;
    }
    var extractUserData = json.decode(pref.getString('userData'));
    _token = extractUserData['token'];
    _role = extractUserData['role'];
    _id = extractUserData['id'];
    _userName = extractUserData['userName'];
    notifyListeners();
  }

  logout(context) async {
    var pref = await SharedPreferences.getInstance();

    if (pref.containsKey('userData')) {
      print('ok');
      pref.clear();
    }
    _token = null;
    _role = null;
    notifyListeners();
    Navigator.of(context).pushReplacementNamed('/');
  }

  userType(newUser) {
    _userType = newUser;
    print(newUser);
    notifyListeners();
  }
}
