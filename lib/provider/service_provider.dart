import 'package:dio/dio.dart';
import 'package:driver_friend/model/service-model.dart';
import 'package:driver_friend/model/service_center.dart';
import 'package:flutter/material.dart';

class ServiceCenterProvider with ChangeNotifier {
  Dio dio = new Dio();
  final url = 'https://driver-friend.herokuapp.com/api/service-centers';
  List<ServiceCenter> _serviceCenters = [
    // ServiceCenter(
    //     id: '2',
    //     rating: 5.0,
    //     name: 'Tharuka Service Center',
    //     mobile: 05555555555,
    //     address: 'Dehiattakandiya')
  ];

  List<Service> _services;
  ServiceCenter _serviceCenter;

  // ServiceCenter get service {
  //   return _serviceCenters[0];
  // }

  List<ServiceCenter> get serviceCenters {
    return _serviceCenters;
  }

  ServiceCenter get serviceCenter {
    return _serviceCenter;
  }

  List<Service> get services {
    return [..._services];
  }

  Future<void> fetchServiceCenter(id) async {
    try {
      var fetchedCenter = await dio.get('$url/service-center/$id');
      print(fetchedCenter.data);

      var serviceCenter = fetchedCenter.data['serviceCenter'];

      _serviceCenter = ServiceCenter(
        id: serviceCenter['_id'],
        mobile: serviceCenter['mobile'],
        city: serviceCenter['city'],
        latitude: serviceCenter['latitude'],
        longitude: serviceCenter['longitude'],
      );

      // _serviceCenter = serviceCenter.data;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> createServiceCenter(ServiceCenter serviceCenter) async {
    print(serviceCenter.id);
    var data = {
      'centerId': serviceCenter.id,
      'address': serviceCenter.address,
      'mobile': serviceCenter.mobile,
      'longitude': serviceCenter.longitude,
      'latitude': serviceCenter.latitude,
      'city': serviceCenter.city,
      'userType': serviceCenter.userType
    };
    try {
      var newServiceCenter = await dio.post(
          'https://driver-friend.herokuapp.com/api/service-centers/add-data',
          data: data);
      var ser = newServiceCenter.data['serviceCenter'];
      print(ser);
      _serviceCenter = ServiceCenter(
          id: ser['centerId'],
          mobile: ser['mobile'],
          about: ser['about'],
          longitude: ser['longitude'],
          latitude: ser['latitude'],
          city: ser['city']);

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteServiceCenter(String id) async {
    try {
      var center = await dio.delete('$url/delete-service-center/$id');
      print(center);
    } catch (e) {
      print(e);
    }
  }

  Future<void> addService(Service service) async {
    try {
      var newService = await dio.post('$url/add-service', data: service);
      print(service);
      _services.add(newService.data);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchServices(String id) async {
    List<Service> services = [];
    try {
      var fetchedServices = await dio.get('$url/services');
      services = fetchedServices.data;
      _services = services;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteService(String id) async {
    try {
      var service = await dio.delete('$url/delete-service/$id');
      print(service.data);
    } catch (e) {
      print(e);
    }
  }

  nearServiceCenters(String city) {
    _serviceCenters =
        _serviceCenters.where((mechanic) => mechanic.city == city);
    notifyListeners();
  }
}
