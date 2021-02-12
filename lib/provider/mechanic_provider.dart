import 'package:driver_friend/model/mechanic_model.dart';
import 'package:driver_friend/model/userType.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MechanicProvider with ChangeNotifier {
  Dio dio = new Dio();
  final url = 'https://dirver-friend.herokuapp.com/api/mechanics';
  List<Mechanic> _mechanics = [
    Mechanic(
      id: '1',
      rating: 4.0,
      name: "Minol",
      address: '64/1 Aracchnikattuwa',
      userType: UserType.mechanic,
      mobile: 0776543322,
    )
  ];

  Mechanic _mechanic;

  List<Mechanic> get mechanics {
    return _mechanics;
  }

  Mechanic get mechanic {
    return _mechanic;
  }

  Future<void> fetchMechanic() async {
    try {
      var mechanic = await dio.get('$url/mechanics');
      mechanic = mechanic.data;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> createMechanic(Mechanic mechanic) async {
    try {
      var newDriver = await dio.post('$url/add-data', data: mechanic);

      // {
      //   'nic': mechanic.nic,
      //   'address': mechanic.address,
      //   'mobile': mechanic.mobile,
      //   'mapImageUrl': mechanic.mapImagePreview,
      //   'longitude': mechanic.longitude,
      //   'latitude': mechanic.latitude,
      //   'city': mechanic.city,
      //   'userType': mechanic.userType
      // }

      print(newDriver.data);
      notifyListeners();

      print(newDriver.data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> editMechanic(Mechanic mechanic) async {
    try {
      var updatedMechanic = await dio.post('$url/update', data: mechanic);
      _mechanic = updatedMechanic.data;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteMechanic(String id) async {
    try {
      var mechanic = await dio.post('$url/delete-mechanic');
      print(mechanic.data);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  selectMechanic(id) {
    try {
      final mechanic = _mechanics.firstWhere((mec) => mec.id == id);
      return mechanic;
    } catch (e) {
      print(e);
    }
  }
}
