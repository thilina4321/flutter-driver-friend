import 'package:driver_friend/model/drivert.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DriverProvider with ChangeNotifier {
  List<Driver> _drivers = [];
  TempararyUser _tempararyUser = TempararyUser();

  Driver get driver {
    if (_drivers.length == 0) {
      return Driver();
    }
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

  Future<void> simple(String filename) async {
    try {
      var driver = await http.get('http://127.0.0.1/api/simple');
      if (driver.statusCode == 200) {
        print(driver);
      } else {
        print('some error');
      }

      // var req = http.MultipartRequest(
      //     'POST', Uri.parse('http://localhost:3000/api/simple'));

      // print('hello world --- 2');

      // req.files.add(await http.MultipartFile.fromPath('images', filename));
      // print('hello world --- 3');
      // req.send();
      // print('hello world --- 4');
    } catch (e) {
      print('hello world ---- Error');
      print(e);
    }
  }

  Future<void> createDriver(Driver driver) async {
    driver.id = (_drivers.length + 1).toString();
    driver.email = _tempararyUser.email;
    driver.name = _tempararyUser.name;
    driver.password = _tempararyUser.password;
    driver.userType = _tempararyUser.userType;

    try {
      await http.post('http://localhost:3000/api/drivers/add-data',
          body: json.encode(driver), headers: {'Authorizarion': ''});
      var a = http.MultipartRequest('POST', Uri.parse('uri'));

      a.files.add(await http.MultipartFile.fromPath('field', 'filePath'));
      a.fields['name'] = 'name';
      var b = await a.send();
      _drivers.add(driver);
      notifyListeners();
    } catch (e) {}
  }

  List<Driver> get drivers {
    return [..._drivers];
  }
}
