import 'package:dio/dio.dart';
import 'package:driver_friend/model/drivert.dart';
import 'package:driver_friend/model/mechanic_model.dart';
import 'package:driver_friend/model/service_center.dart';
import 'package:driver_friend/model/spare_shop.dart';
import 'package:flutter/material.dart';

class DriverProvider with ChangeNotifier {
  final url = 'https://driver-friend.herokuapp.com/api/drivers';
  Dio dio = new Dio();
  Driver _driver;

  List<Mechanic> _nearMechanics = [];
  List<ServiceCenter> _nearService = [];
  List<SparePartShop> _nearSpare = [];

  Driver get driver {
    return _driver;
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
    var data = {
      'driverId': driver.id,
      'nic': driver.nic,
      'mobile': driver.mobile,
      'vehicleNumber': driver.vehicleNumber,
      'vehicleColor': driver.vehicleColor,
      'longitude': driver.longitude,
      'latitude': driver.latitude,
      'city': driver.city
    };
    print(data);
    try {
      var newDriver = await dio.post('$url/add-data', data: data);
      var driver = newDriver.data['driver'];

      _driver = Driver(
          id: driver['driverId'],
          nic: driver['nic'],
          mobile: driver['mobile'],
          vehicleNumber: driver['vehicleNumber'],
          vehicleColor: driver['vehicleColor'],
          longitude: driver['longitude'],
          latitude: driver['latitude']);
      print(_driver.latitude);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchDriver(id) async {
    try {
      var fetchedDriver = await dio.get('$url/driver/$id');
      print(fetchedDriver.data);
      var driver = fetchedDriver.data['driver'];
      _driver = Driver(
        id: driver['_id'],
        nic: driver['nic'],
        mobile: driver['mobile'],
        vehicleColor: driver['vehicleColor'],
        vehicleNumber: driver['vehicleNumber'],
        city: driver['city'],
        latitude: driver['latitude'],
        longitude: driver['longitude'],
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }

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
    var mechanics = await dio.get('$url/near-mechanic');
    _nearMechanics = mechanics.data;
    notifyListeners();
  }

  Future<void> nearService() async {
    var service = await dio.get('$url/near-service');
    _nearService = service.data;

    notifyListeners();
  }

  Future<void> nearSpare() async {
    var spare = await dio.get('$url/near-spare');
    _nearSpare = spare.data;
    notifyListeners();
  }
}
