import 'package:driver_friend/model/service_center.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:flutter/material.dart';

class ServiceCenterProvider with ChangeNotifier {
  final List<ServiceCenter> _serviceCenters = [
    ServiceCenter(
        id: '2',
        rating: 3.0,
        name: 'Tharuka Service Center',
        mobile: 05555555555,
        address: 'Dehiattakandiya'),
    ServiceCenter(
        id: '3',
        rating: 4.0,
        name: 'Malikshi Service Center',
        mobile: 0666666666,
        address: 'Horana'),
  ];

  ServiceCenter get service {
    return _serviceCenters[0];
  }

  List<ServiceCenter> get serviceCenter {
    return _serviceCenters;
  }

  TempararyUser _tempararyUser = TempararyUser();
  addToTempararyUser(TempararyUser tempararyUser) {
    _tempararyUser.email = tempararyUser.email;
    _tempararyUser.name = tempararyUser.name;
    _tempararyUser.password = tempararyUser.password;
    _tempararyUser.userType = tempararyUser.userType;

    notifyListeners();
  }

  createMechanic(ServiceCenter service) {
    service.id = (_serviceCenters.length + 1).toString();
    service.email = _tempararyUser.email;
    service.name = _tempararyUser.name;
    service.password = _tempararyUser.password;
    service.userType = _tempararyUser.userType;

    _serviceCenters.add(service);
    notifyListeners();
  }
}
