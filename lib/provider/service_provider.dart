import 'package:driver_friend/model/service_center.dart';
import 'package:flutter/material.dart';

class ServiceCenterProvider with ChangeNotifier {
  final List<ServiceCenter> _serviceCenter = [
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

  List<ServiceCenter> get serviceCenter {
    return _serviceCenter;
  }
}
