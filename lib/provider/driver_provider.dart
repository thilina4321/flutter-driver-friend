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
  double _rating;

  List<Mechanic> _nearMechanics = [];
  List<ServiceCenter> _nearService = [];
  List<SparePartShop> _nearSpare = [];
  List<Appointment> _appointments = [];
  List _cartItems = [];

  Driver get driver {
    return _driver;
  }

  double get rating {
    return _rating;
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

  List<Appointment> get appointments {
    return _appointments;
  }

  List get cart {
    return _cartItems;
  }

  Future<void> createDriver([Driver driver, id]) async {
    var data = {
      'userId': driver.userId,
      'nic': driver.nic,
      'mobile': driver.mobile,
      'vehicleNumber': driver.vehicleNumber,
      'vehicleColor': driver.vehicleColor,
      'longitude': driver.longitude,
      'latitude': driver.latitude,
      'city': driver.city,
      'mapImagePreview': driver.mapImagePreview,
    };

    try {
      if (id == null) {
        await dio.post('$url/add-data', data: data);
      } else {
        await dio.patch('$url/update/$id', data: data);
      }
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
          userName: driver['userName'],
          userId: driver['userId'],
          mobile: driver['mobile'],
          vehicleColor: driver['vehicleColor'],
          vehicleNumber: driver['vehicleNumber'],
          city: driver['city'],
          latitude: driver['latitude'],
          longitude: driver['longitude'],
          mapImagePreview: driver['mapImagePreview']);
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

  // Future<void> mechanicRating(int rating) async {
  //   await dio.post('/mechanic-rating', data: {'rating': rating});
  // }

  // Future<void> spareRating(int rating) async {
  //   await dio.post('/spare-rating', data: {'rating': rating});
  // }

  // Future<void> serviceRating(int rating) async {
  //   await dio.post('/service-rating', data: {'rating': rating});
  // }

  Future<void> nearMechanic() async {
    List<Mechanic> nearMechanics = [];
    try {
      var fetchedMechanic = await dio
          .get('https://driver-friend.herokuapp.com/api/drivers/near-mechanic');

      var mechanics = fetchedMechanic.data;

      mechanics.forEach((mechanic) {
        nearMechanics.add(
          Mechanic(
              id: mechanic['_id'],
              userId: mechanic['userId'],
              nic: mechanic['nic'],
              mobile: mechanic['mobile'],
              city: mechanic['city'],
              latitude: mechanic['latitude'],
              longitude: mechanic['longitude'],
              about: mechanic['about'],
              address: mechanic['address'],
              name: mechanic['userName'],
              rating: double.parse(mechanic['totalRating'].toString())),
        );
      });

      _nearMechanics = nearMechanics;

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
              userId: spares['userId']),
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
    var data = {
      'centerId': appointment.centerId,
      'date': appointment.date,
      'time': appointment.time,
      'status': appointment.status,
      'driverId': appointment.driverId,
      'centerMobile': appointment.centerMobile,
      'centerName': appointment.centerName,
      'serviceName': appointment.serviceName,
    };
    print(data);
    try {
      await dio.post('$url/make-appointment', data: data);
    } catch (e) {
      print(e.error);
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
      print(responseData);

      responseData.forEach((app) {
        appoins.add(Appointment(
            centerId: app['centerId'],
            driverId: app['driverId'],
            serviceName: app['serviceName'],
            centerMobile: app['centerMobile'],
            centerName: app['centerName'],
            status: app['status'],
            date: app['date'],
            time: app['time']));
      });
      _appointments = appoins;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  fetchCart() async {}

  Future findMyRatings(userType, id, driverId) async {
    var rating;
    try {
      if (userType == 'service') {
        rating = await dio.get('$url/my-service-rating/$id/$driverId');
      } else if (userType == 'spare') {
        rating = await dio.get('$url/my-spare-rating/$id/$driverId');
      } else if (userType == 'mechanic') {
        rating = await dio.get('$url/my-mechanic-rating/$id/$driverId');
      }
      _rating = double.parse(rating.data['rating'].toString());
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
