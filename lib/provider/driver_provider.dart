import 'package:dio/dio.dart';
import 'package:driver_friend/model/drivert.dart';
import 'package:driver_friend/model/mechanic_model.dart';
import 'package:driver_friend/model/service_center.dart';
import 'package:driver_friend/model/spare_shop.dart';
import 'package:flutter/material.dart';

class DriverProvider with ChangeNotifier {
  final url = 'https://dirver-friend.herokuapp.com/api/drivers';
  Dio dio = new Dio();
  List<Driver> _drivers = [];
  Driver _driver;

  List<Mechanic> _nearMechanics = [];
  List<ServiceCenter> _nearService = [];
  List<SparePartShop> _nearSpare = [];

  Driver get driver {
    if (_drivers.length == 0) {
      return Driver();
    }
    return _drivers[0];
  }

  Driver get me {
    return _driver;
  }

  List<Driver> get drivers {
    return [..._drivers];
  }

  List<Mechanic> get nearMechanics {
    return [..._nearMechanics];
  }

  List<ServiceCenter> get nearServices {
    return [..._nearService];
  }

  List<SparePartShop> get nearSpares {
    return [..._nearSpare];
  }

  Future<void> createDriver(Driver driver) async {
    try {
      var newDriver = await dio.post('$url/add-data', data: {
        'nic': driver.nic,
        'mobile': driver.mobile,
        'vehicleNumber': driver.vehicleNumber,
        'vehicleColor': driver.vehicleColor,
        'mapImageUrl': driver.mapImagePreview,
        'longitude': driver.longitude,
        'latitude': driver.latitude,
        'city': driver.city
      });

      print(newDriver.data);
      _drivers.add(newDriver.data);
      notifyListeners();

      print(newDriver.data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchDriver() async {
    var driver = await dio.get('path');
    _driver = driver.data;
    notifyListeners();
  }

  Future<void> editDriver(Driver driver) async {
    var newDriver = await dio.patch('/update/${driver.id}', data: driver);
    _driver = newDriver.data;
    notifyListeners();
  }

  Future<void> deleteDriver(String id) async {
    var driver = await dio.delete('/delete-driver');
    print(driver.data);
    notifyListeners();
  }

  Future<void> mechanicRating(int rating) async {
    await dio.post('/mechanic-rating', data: {'rating': rating});
  }

  Future<void> spareRating(int rating) async {
    await dio.post('/spare-rating', data: {'rating': rating});
  }

  Future<void> serviceRating(int rating) async {
    await dio.post('/service-rating', data: {'rating': rating});
  }

  Future<void> nearMechanic() async {
    var mechanics = await dio.get('/near-mechanic');
    _nearMechanics = mechanics.data;
    notifyListeners();
  }

  Future<void> nearService() async {
    var service = await dio.get('/near-service');
    _nearService = service.data;
    notifyListeners();
  }

  Future<void> nearSpare() async {
    var spare = await dio.get('/near-spare');
    _nearSpare = spare.data;
    notifyListeners();
  }
}
