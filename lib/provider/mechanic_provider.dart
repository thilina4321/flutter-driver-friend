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
      mobile: '0776543322',
    )
  ];

  Mechanic _mechanic;

  List<Mechanic> get mechanics {
    return _mechanics;
  }

  Mechanic get mechanic {
    return _mechanic;
  }

  Future<void> fetchMechanic(id) async {
    print(id);

    try {
      var fetchedMechanic = await dio.get(
          'https://driver-friend.herokuapp.com/api/mechanics/mechanic/$id');
      print(fetchedMechanic.data);
      var mechanic = fetchedMechanic.data['mechanic'];
      _mechanic = Mechanic(
        id: mechanic['_id'],
        nic: mechanic['nic'],
        mobile: mechanic['mobile'],
        city: mechanic['city'],
        latitude: mechanic['latitude'],
        longitude: mechanic['longitude'],
        about: mechanic['about'],
        address: mechanic['address'],
      );

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> fetchMechanics() async {
    try {
      var fetchedMechanic = await dio
          .get('https://driver-friend.herokuapp.com/api/mechanics/mechanics');
      print(fetchedMechanic.data);
      var mechanics = fetchedMechanic.data['mechanics'];
      mechanics.forEach((mechanic) {
        _mechanics.add(
          Mechanic(
              id: mechanics['_id'],
              nic: mechanics['nic'],
              mobile: mechanics['mobile'],
              city: mechanics['city'],
              latitude: mechanics['latitude'],
              longitude: mechanics['longitude'],
              about: mechanics['about'],
              address: mechanics['address']),
        );
      });

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> createMechanic(Mechanic mechanic) async {
    var data = {
      'userId': mechanic.userId,
      'nic': mechanic.nic,
      'address': mechanic.address,
      'mobile': mechanic.mobile,
      'longitude': mechanic.longitude,
      'latitude': mechanic.latitude,
      'city': mechanic.city,
      'about': mechanic.about
    };
    try {
      await dio.post(
          'https://driver-friend.herokuapp.com/api/mechanics/add-data',
          data: data);
    } catch (e) {
      throw e;
    }
  }

  Future<void> editMechanic(Mechanic mechanic) async {
    try {
      var updatedMechanic = await dio.post('$url/update', data: mechanic);
      _mechanic = updatedMechanic.data;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteMechanic(String id, String userId) async {
    try {
      var mechanic = await dio.post('$url/delete-mechanic/$id/$userId');
      print(mechanic.data);
      notifyListeners();
    } catch (e) {
      throw e;
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

  nearMechanics(String city) {
    _mechanics = _mechanics.where((mechanic) => mechanic.city.contains(city));
    notifyListeners();
  }

  Future<void> mechanicRating(String id, double rating) async {
    try {
      var rating = await dio.post(
          'https://dirver-friend.herokuapp.com/api/drivers/mechanic-rating');
      print(rating);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
