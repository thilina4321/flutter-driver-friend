import 'package:dio/dio.dart';
import 'package:driver_friend/model/service-model.dart';
import 'package:driver_friend/model/service_center.dart';
import 'package:flutter/material.dart';

class ServiceCenterProvider with ChangeNotifier {
  Dio dio = new Dio();
  final url = 'https://driver-friend.herokuapp.com/api/service-centers';
  List<ServiceCenter> _serviceCenters = [];

  List<Service> _services = [];
  ServiceCenter _serviceCenter;

  List<ServiceCenter> get serviceCenters {
    return _serviceCenters;
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

  Future<void> fetchServiceCenter(id) async {
    print(id);
    try {
      var fetchedCenter = await dio.get('$url/service-center/$id');

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
      // var fetchedService = newService.data['service'];
      // _services.add(
      //   Service(
      //       id: fetchedService['_id'],
      //       name: service.name,
      //       description: service.description,
      //       price: service.price),
      // );

      // print(fetchedService);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> fetchServices(String centerId) async {
    List<Service> services = [];
    try {
      var fetchedServices = await dio.get('$url/services');
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

  Future<void> serviceRating(String id, double rating) async {
    try {
      var rating = await dio.post(
          'https://dirver-friend.herokuapp.com/api/drivers/service-rating');
      print(rating);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
