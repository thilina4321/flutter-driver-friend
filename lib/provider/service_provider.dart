import 'package:dio/dio.dart';
import 'package:driver_friend/model/appointment.dart';
import 'package:driver_friend/model/service-model.dart';
import 'package:driver_friend/model/service_center.dart';
import 'package:flutter/material.dart';

class ServiceCenterProvider with ChangeNotifier {
  Dio dio = new Dio();
  final url = 'https://driver-friend.herokuapp.com/api/service-centers';
  List<ServiceCenter> _serviceCenters = [];

  List<Service> _services = [];
  ServiceCenter _serviceCenter;
  List<Appointment> _appointments = [];

  List<ServiceCenter> get serviceCenters {
    return _serviceCenters;
  }

  List<Appointment> get appointments {
    return _appointments;
  }

  ServiceCenter get serviceCenter {
    return _serviceCenter;
  }

  List<Service> get services {
    if (_services.length == 0) {
      return [];
    }
    return [..._services];
  }

  Future<void> serviceRating(rating, id, driverId, currentValue) async {
    var data = {'rating': rating, 'id': id, 'driverId': driverId};
    try {
      await dio.post(
          'https://driver-friend.herokuapp.com/api/drivers/service-rating',
          data: data);
      if (currentValue == 0.0) {
        _serviceCenter.rating =
            (_serviceCenter.rating * _serviceCenter.count + rating) /
                (_serviceCenter.count + 1);
      } else {
        _serviceCenter.rating = _serviceCenter.rating +
            (rating - currentValue) / (_serviceCenter.count);
        print(_serviceCenter.rating);
      }
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> fetchServiceCenter(id) async {
    try {
      var fetchedCenter = await dio.get('$url/service-center/$id');

      var serviceCenter = fetchedCenter.data['serviceCenter'];

      _serviceCenter = ServiceCenter(
        id: serviceCenter['_id'],
        name: serviceCenter['userName'],
        userId: serviceCenter['userId'],
        mobile: serviceCenter['mobile'],
        // mapImagePreview: serviceCenter[''],
        city: serviceCenter['city'],
        latitude: serviceCenter['latitude'],
        longitude: serviceCenter['longitude'],
        address: serviceCenter['address'],
        openingTime: serviceCenter['openTime'],
        closingTime: serviceCenter['closeTime'],
        rating: double.parse(serviceCenter['totalRating'].toString()) /
            serviceCenter['count'],
        count: serviceCenter['count'],
      );

      // _serviceCenter = serviceCenter.data;
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> createServiceCenter(ServiceCenter serviceCenter) async {
    var data = {
      'userId': serviceCenter.userId,
      'address': serviceCenter.address,
      'mobile': serviceCenter.mobile,
      'longitude': serviceCenter.longitude,
      'latitude': serviceCenter.latitude,
      'city': serviceCenter.city,
      'userType': serviceCenter.userType,
      'openTime': serviceCenter.openingTime,
      'closeTime': serviceCenter.closingTime,
      'mapImagePreview': serviceCenter.mapImagePreview
    };
    try {
      await dio.post(
          'https://driver-friend.herokuapp.com/api/service-centers/add-data',
          data: data);
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteServiceCenter(String id, String userId) async {
    try {
      var center = await dio.delete('$url/delete-service-center/$id/$userId');
      print(center);
    } catch (e) {
      print(e);
    }
  }

  Future<void> addService(Service service) async {
    // var formData = FormData.fromMap({
    //   'name': service.name,
    //   'description': service.description,
    //   'price': service.price,
    //   'shopId': service.shopId
    // });

    var formData = {
      'name': service.name,
      'description': service.description,
      'price': service.price,
      'shopId': service.shopId
    };
    try {
      await dio.post('$url/create-service', data: formData);

      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> fetchServices(String centerId) async {
    List<Service> services = [];
    try {
      var fetchedServices = await dio.get(
          'https://driver-friend.herokuapp.com/api/service-centers/services/$centerId');
      var getServices = fetchedServices.data['services'];

      getServices.forEach((service) {
        services.add(
          Service(
              id: service['_id'],
              name: service['name'],
              price: service['price'].toString(),
              description: service['description']),
        );
      });
      _services = services;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteService(String id) async {
    try {
      await dio.delete('$url/delete-service/$id');
    } catch (e) {
      throw e;
    }
  }

  selectServiceForEdit(String id) async {
    Service service = _services.firstWhere((element) => element.id == id);
    return service;
  }

  nearServiceCenters(String city) {
    _serviceCenters =
        _serviceCenters.where((mechanic) => mechanic.city == city);
    notifyListeners();
  }

  Future getAppointments(id) async {
    List<Appointment> appointments = [];
    try {
      var response = await dio.get('$url/get-appointments/$id');
      var resData = response.data['appointment'];

      resData.forEach((element) => appointments.add(Appointment(
          centerId: element['centerId'],
          driverId: element['driverId'],
          status: element['status'],
          id: element['_id'],
          serviceName: element['serviceName'],
          date: element['date'],
          time: element['time'])));

      _appointments = appointments;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future changeAppointmentStatus(String id, String status) async {
    var data = {id: id, status: status};

    try {
      var a = await dio.post(
          'https://driver-friend.herokuapp.com/api/service-centers/change-status/607e8bcb67e4fa0015b5c8b0',
          data: data);
      print(a.data);
    } catch (e) {
      throw e;
    }
  }
}
