import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:driver_friend/model/mechanic_model.dart';
import 'package:driver_friend/model/userType.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MechanicProvider with ChangeNotifier {
  final cloudinary = CloudinaryPublic('ddo9tyz6e', 'gre6o5vv', cache: false);

  Dio dio = new Dio();
  final url = 'https://dirver-friend.herokuapp.com/api/mechanics';
  List<Mechanic> _mechanics = [];

  Mechanic _mechanic;

  List<Mechanic> get mechanics {
    return _mechanics;
  }

  Mechanic get mechanic {
    return _mechanic;
  }

  Future<void> serviceRating(rating, id, driverId, currentValue) async {
    var data = {'rating': rating, 'id': id, 'driverId': driverId};
    try {
      await dio.post(
          'https://driver-friend.herokuapp.com/api/drivers/mechanic-rating',
          data: data);
      if (currentValue == 0.0) {
        _mechanic.rating = (_mechanic.rating * _mechanic.count + rating) /
            (_mechanic.count + 1);
      } else {
        _mechanic.rating =
            _mechanic.rating + (rating - currentValue) / (_mechanic.count);
      }
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> fetchMechanic(id) async {
    try {
      var fetchedMechanic = await dio.get(
          'https://driver-friend.herokuapp.com/api/mechanics/mechanic/$id');

      var mechanic = fetchedMechanic.data['mechanic'];
      _mechanic = Mechanic(
        id: mechanic['_id'],
        name: mechanic['userName'],
        mapImagePreview: mechanic['mapImagePreview'],
        userId: mechanic['userId'],
        nic: mechanic['nic'],
        mobile: mechanic['mobile'],
        city: mechanic['city'],
        latitude: mechanic['latitude'],
        longitude: mechanic['longitude'],
        about: mechanic['about'],
        count: mechanic['count'],
        rating: mechanic['count'] == 0
            ? 0
            : double.parse(mechanic['totalRating'].toString()) /
                mechanic['count'],
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
      var mechanics = fetchedMechanic.data['mechanics'];
      mechanics.forEach((mechanic) {
        _mechanics.add(
          Mechanic(
              // id: mechanics['_id'],
              // nic: mechanics['nic'],
              // mobile: mechanics['mobile'],
              // city: mechanics['city'],
              // latitude: mechanics['latitude'],
              // longitude: mechanics['longitude'],
              // about: mechanics['about'],
              // address: mechanics['address']
              ),
        );
      });

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> createMechanic([Mechanic mechanic, id]) async {
    var data = {
      'userId': mechanic.userId,
      'nic': mechanic.nic,
      'address': mechanic.address,
      'mobile': mechanic.mobile,
      'longitude': mechanic.longitude,
      'latitude': mechanic.latitude,
      'city': mechanic.city,
      'about': mechanic.about,
      'mapImagePreview': mechanic.mapImagePreview,
    };
    try {
      if (id == null) {
        await dio.post(
            'https://driver-friend.herokuapp.com/api/mechanics/add-data',
            data: data);
      } else {
        await dio.patch(
            'https://driver-friend.herokuapp.com/api/mechanics/update/$id',
            data: data);
      }
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
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  selectMechanic(id) {
    try {
      final mechanic = _mechanics.firstWhere((mec) => mec.id == id);
      return mechanic;
    } catch (e) {}
  }

  nearMechanics(String city) {
    _mechanics = _mechanics.where((mechanic) => mechanic.city.contains(city));
    notifyListeners();
  }

  Future<void> mechanicRating(String id, double rating) async {
    try {
      await dio.post(
          'https://dirver-friend.herokuapp.com/api/drivers/mechanic-rating');
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future addProfilePicture(image, id) async {
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path,
            resourceType: CloudinaryResourceType.Image),
      );

      print(response.secureUrl);
      await dio.patch('$url/pro-pic/$id',
          data: {'profileImage': response.secureUrl});
    } on CloudinaryException catch (e) {
      throw e;
    }
  }
}
