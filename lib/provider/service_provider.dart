import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dio/dio.dart';
import 'package:driver_friend/model/appointment.dart';
import 'package:driver_friend/model/service-model.dart';
import 'package:driver_friend/model/service_center.dart';
import 'package:flutter/material.dart';

class ServiceCenterProvider with ChangeNotifier {
  Dio dio = new Dio();
  final url = 'https://driver-friend.herokuapp.com/api/service-centers';
  List<ServiceCenter> _serviceCenters = [];
  final cloudinary = CloudinaryPublic('ddo9tyz6e', 'gre6o5vv', cache: false);

  List<Service> _services = [];
  ServiceCenter _serviceCenter;
  List<Appointment> _appointments = [];

  List<ServiceCenter> get serviceCenters {
    return _serviceCenters;
  }

  List<Appointment> get appointments {
    List<Appointment> _app = [];
    for (var i = _appointments.length - 1; i >= 0; i--) {
      _app.add(_appointments[i]);
    }
    return _app;
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
        profileImageUrl: serviceCenter['image'],
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
      await dio.delete('$url/delete-service-center/$id/$userId');
    } catch (e) {
      throw e;
    }
  }

  Future<void> addService(
      [Service service, id, bool isImageEdit = false]) async {
    var formData = {
      'name': service.name,
      'description': service.description,
      'price': service.price,
      'shopId': service.shopId,
    };
    try {
      if (id == null) {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(service.image,
              resourceType: CloudinaryResourceType.Image),
        );
        print(response.secureUrl);
        formData['image'] = response.secureUrl;

        await dio.post('$url/create-service', data: formData);
      } else {
        if (isImageEdit) {
          CloudinaryResponse response = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(service.image,
                resourceType: CloudinaryResourceType.Image),
          );
          formData['image'] = response.secureUrl;
        }
        await dio.patch('$url/edit-service/$id', data: formData);
      }

      notifyListeners();
    } on CloudinaryException catch (e) {
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
              image: service['image'],
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
    try {
      await dio.delete('$url/delete-service/$id');
    } catch (e) {
      throw e;
    }
  }

  selectServiceForEdit(String id) {
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
    var data = {'id': id, 'status': status};

    try {
      var a = await dio.patch(
          'https://driver-friend.herokuapp.com/api/service-centers/change-status',
          data: data);
    } catch (e) {
      throw e;
    }
  }

  Future addProfilePicture(image, id) async {
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path,
            resourceType: CloudinaryResourceType.Image),
      );

      await dio.patch(
          'https://driver-friend.herokuapp.com/api/service-centers/pro-pic/$id',
          data: {'profileImage': response.secureUrl});
    } on CloudinaryException catch (e) {
      throw e;
    }
  }
}
