import 'package:dio/dio.dart';
import 'package:driver_friend/model/service-model.dart';
import 'package:driver_friend/model/service_center.dart';
import 'package:flutter/material.dart';

class ServiceCenterProvider with ChangeNotifier {
  Dio dio = new Dio();
  final url = 'https://driver-friend.herokuapp.com/api/service-centers';
  List<ServiceCenter> _serviceCenters = [];

  List<SparePart> _services;
  ServiceCenter _serviceCenter;

  List<ServiceCenter> get serviceCenters {
    return _serviceCenters;
  }

  ServiceCenter get serviceCenter {
    return _serviceCenter;
  }

  List<SparePart> get services {
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
        address: serviceCenter['address'],
        openingTime: serviceCenter['openTime'],
        closingTime: serviceCenter['closeTime'],
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
      'userType': serviceCenter.userType,
      'openTime': serviceCenter.openingTime,
      'closeTime': serviceCenter.closingTime,
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
          address: ser['address'],
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

  Future<void> addService(SparePart service) async {
    // FormData data = new FormData.fromMap({
    //   'name': service.name,
    //   'description': service.description,
    //   'price': service.price
    // });
    var data = {
      'name': service.name,
      'description': service.description,
      'price': service.price
    };
    try {
      var newService = await dio.post('$url/create-service', data: data);
      var fetchedService = newService.data['service'];
      _services.add(
        SparePart(
            id: fetchedService['_id'],
            name: service.name,
            description: service.description,
            price: service.price),
      );

      print(fetchedService);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> fetchServices() async {
    List<SparePart> services = [];
    try {
      var fetchedServices = await dio.get('$url/services');
      var getServices = fetchedServices.data['services'];
      getServices.forEach((service) {
        services.add(
          SparePart(
              id: service['_id'],
              name: service['name'],
              price: service['price'].toString(),
              description: service['description']),
        );
      });
      _services = services;
      print(getServices);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteService(String id) async {
    print(id);
    try {
      await dio.delete('$url/delete-service/$id');
      _services.removeWhere((service) => service.id == id);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  nearServiceCenters(String city) {
    _serviceCenters =
        _serviceCenters.where((mechanic) => mechanic.city == city);
    notifyListeners();
  }
}
