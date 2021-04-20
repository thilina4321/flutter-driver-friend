import 'package:dio/dio.dart';
import 'package:driver_friend/model/appointment.dart';
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
  List<Appointment> _appointments = [];
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

    print(data);

    try {
      await dio.post('$url/add-data', data: data);
    } catch (e) {
      print(e.toString());
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
        userName: driver['userName'],
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

  Future<void> nearMechanic() async {
    List<Mechanic> nearMechanics = [];
    try {
      var fetchedMechanic = await dio
          .get('https://driver-friend.herokuapp.com/api/drivers/near-mechanic');

      var mechanics = fetchedMechanic.data;

      mechanics.forEach((mechanic) {
        print(mechanic);
        nearMechanics.add(
          Mechanic(
            id: mechanic['_id'],
            nic: mechanic['nic'],
            mobile: mechanic['mobile'],
            city: mechanic['city'],
            latitude: mechanic['latitude'],
            longitude: mechanic['longitude'],
            about: mechanic['about'],
            address: mechanic['address'],
          ),
        );
      });

      _nearMechanics = nearMechanics;

      print(_nearMechanics);

      notifyListeners();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> nearService() async {
    List<ServiceCenter> nearS = [];
    try {
      var fetchedService = await dio
          .get('https://driver-friend.herokuapp.com/api/drivers/near-service');

      var services = fetchedService.data;

      services.forEach((service) {
        nearS.add(
          ServiceCenter(
              id: service['_id'],
              mobile: service['mobile'],
              city: service['city'],
              latitude: service['latitude'],
              longitude: service['longitude'],
              about: service['about'],
              address: service['address'],
              userId: service['userId']),
        );
      });
      _nearService = nearS;

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> nearSpare() async {
    try {
      var fetchedSpare = await dio
          .get('https://driver-friend.herokuapp.com/api/drivers/near-spare');

      var spares = fetchedSpare.data;

      spares.forEach((spare) {
        _nearSpare.add(
          SparePartShop(
            id: spares['_id'],
            mobile: spares['mobile'],
            city: spares['city'],
            latitude: spares['latitude'],
            longitude: spares['longitude'],
            about: spares['about'],
            address: spares['address'],
          ),
        );
      });

      print(_nearMechanics);

      notifyListeners();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future makeAppointment(Appointment appointment) async {
    try {
      await dio.post('$url/make-appointment', data: appointment);
    } catch (e) {
      throw e;
    }
  }

  makeAnOrder() async {
    try {} catch (e) {
      throw e;
    }
  }

  fetchAppointments(String id) async {
    List<Appointment> appoins = [];

    try {
      var response = await dio.get('$url/find-appointments/$id');

      var responseData = response.data['appointment'] as List;

      responseData.forEach((app) {
        appoins.add(Appointment(
            centerId: app['centerId'],
            driverId: app['driverId'],
            status: app['status'],
            date: app['date'],
            time: app['time']));
      });
      _appointments = appoins;
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  fetchCart() async {}
}
