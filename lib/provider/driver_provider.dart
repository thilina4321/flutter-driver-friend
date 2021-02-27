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
  List _appointments = [];
  List _cartItems = [];

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

  List get appointments {
    return _appointments;
  }

  List get cart {
    return _cartItems;
  }

  Future<void> createDriver(Driver driver) async {
    var data = {
      'userId': driver.userId,
      'nic': driver.nic,
      'mobile': driver.mobile,
      'vehicleNumber': driver.vehicleNumber,
      'vehicleColor': driver.vehicleColor,
      'longitude': driver.longitude,
      'latitude': driver.latitude,
      'city': driver.city
    };
    try {
      await dio.post('$url/add-data', data: data);
    } catch (e) {
      throw e;
    }
  }

  Future<void> fetchDriver(id) async {
    try {
      var fetchedDriver = await dio.get('$url/driver/$id');

      var driver = fetchedDriver.data['driver'];
      _driver = Driver(
        id: driver['_id'],
        nic: driver['nic'],
        userId: driver['userId'],
        mobile: driver['mobile'],
        vehicleColor: driver['vehicleColor'],
        vehicleNumber: driver['vehicleNumber'],
        city: driver['city'],
        latitude: driver['latitude'],
        longitude: driver['longitude'],
      );
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> editDriver(Driver driver) async {
    try {
      var newDriver = await dio.patch('/update/${driver.id}', data: driver);
      _driver = newDriver.data;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteDriver(String id, String userId) async {
    print(id);
    try {
      var driver = await dio.delete('$url/delete-driver/$id/$userId');
      print(driver.data);
    } catch (e) {
      throw e;
    }
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

  // Future<void> nearMechanic() async {
  //   try {
  //     var mechanics = await dio.get('$url/near-mechanic');
  //     print(_nearMechanics);
  //     _nearMechanics = mechanics.data;
  //     notifyListeners();
  //   } catch (e) {
  //     throw e;
  //     // print(e);
  //   }
  // }

  nearMechanic() {}

  Future<void> nearService() async {
    try {
      var service = await dio.get('$url/near-servicer');
      _nearService = service.data;
      print(_nearService);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> nearSpare() async {
    try {
      var spare = await dio.get('$url/near-spare');

      _nearSpare = spare.data;
      print(_nearSpare);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  makeAppointment() async {
    try {} catch (e) {
      throw e;
    }
  }

  makeAnOrder() async {
    try {} catch (e) {
      throw e;
    }
  }

  fetchAppointments() async {}

  fetchCart() async {}
}
