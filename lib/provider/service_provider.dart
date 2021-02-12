import 'package:dio/dio.dart';
import 'package:driver_friend/model/service-model.dart';
import 'package:driver_friend/model/service_center.dart';
import 'package:flutter/material.dart';

class ServiceCenterProvider with ChangeNotifier {
  Dio dio = new Dio();
  final url = 'https://dirver-friend.herokuapp.com/api/service-centers';
  final List<ServiceCenter> _serviceCenters = [
    ServiceCenter(
        id: '2',
        rating: 5.0,
        name: 'Tharuka Service Center',
        mobile: 05555555555,
        address: 'Dehiattakandiya')
  ];

  List<Service> _services;
  ServiceCenter _serviceCenter;

  ServiceCenter get service {
    return _serviceCenters[0];
  }

  List<ServiceCenter> get serviceCenters {
    return _serviceCenters;
  }

  ServiceCenter get serviceCenter {
    return _serviceCenter;
  }

  List<Service> get services {
    return [..._services];
  }

  Future<void> fetchServiceCenter() async {
    try {
      var serviceCenter = await dio.get('/service-centers');
      _serviceCenter = serviceCenter.data;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> createServiceCenter(ServiceCenter serviceCenter) async {
    try {
      var newServiceCenter =
          await dio.post('$url/add-data', data: serviceCenter);

      // {
      //   'address': serviceCenter.address,
      //   'mobile': serviceCenter.mobile,
      //   'mapImageUrl': serviceCenter.mapImagePreview,
      //   'longitude': serviceCenter.longitude,
      //   'latitude': serviceCenter.latitude,
      //   'city': serviceCenter.city,
      //   'userType': serviceCenter.userType
      // }

      print(newServiceCenter.data);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteServiceCenter(String id) async {
    try {
      var center = await dio.delete('$url/delete-service-center');
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
}
