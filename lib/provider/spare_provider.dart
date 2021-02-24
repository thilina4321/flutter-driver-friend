import 'package:dio/dio.dart';
import 'package:driver_friend/model/part.dart';
import 'package:driver_friend/model/spare_shop.dart';
import 'package:flutter/material.dart';

class SpareShopProvider with ChangeNotifier {
  Dio dio = new Dio();
  final url = 'https://dirver-friend.herokuapp.com/api/sparepart-shops';

  List<SparePartShop> _spareShops = [];
  SparePartShop _spareShop;
  List<SparePart> _spareParts = [];

  SparePartShop get spareShop {
    return _spareShop;
  }

  List<SparePartShop> get spareShops {
    return _spareShops;
  }

  List<SparePart> get spareParts {
    if (_spareParts.length == 0) {
      return [];
    }
    return [..._spareParts];
  }

  Future<void> login(data) async {
    try {
      var spareShop = await dio.post('$url/login',
          data: {'email': data.email, 'password': data.password});

      _spareShop = spareShop.data;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> createSpareShop(SparePartShop spareShop) async {
    var data = {
      'userId': spareShop.userId,
      'address': spareShop.address,
      'openTime': spareShop.openingTime,
      'closeTime': spareShop.closingTime,
      'mobile': spareShop.mobile,
      'about': spareShop.about,
      'longitude': spareShop.longitude,
      'latitude': spareShop.latitude,
      'city': spareShop.city,
    };

    try {
      Dio dio = new Dio();

      await dio.post(
          'https://driver-friend.herokuapp.com/api/sparepart-shops/add-data',
          data: data);

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> fetchSpareShop(id) async {
    try {
      var fetchedShops = await dio.get(
          'https://driver-friend.herokuapp.com/api/sparepart-shops/spare-shop/$id');

      var shops = fetchedShops.data['spareshop'];

      _spareShop = SparePartShop(
        id: shops['_id'],
        userId: shops['userId'],
        mobile: shops['mobile'],
        city: shops['city'],
        rating: double.parse(shops['totalRating'].toString()),
        latitude: shops['latitude'],
        longitude: shops['longitude'],
        openingTime: shops['openTime'].toString(),
        closingTime: shops['closeTime'].toString(),
        about: shops['about'],
        address: shops['address'],
      );
      print(_spareShop.id);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> editSpareShop(String id, SparePartShop spare) async {
    try {
      var shop = await dio.patch('$url/edit-spare/$id', data: spare);

      int shopIndex = _spareShops.indexWhere((shop) => shop.id == id);
      _spareShops[shopIndex] = shop.data;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteShop(String id, String userId) async {
    print(id);
    print(userId);
    try {
      await dio.delete(
          'https://dirver-friend.herokuapp.com/api/sparepart-shops/delete-spareshop/$id/$userId');
    } catch (e) {
      throw e;
    }
  }

  Future<void> addParts(SparePart service) async {
    var data = {
      'name': service.name,
      'description': service.description,
      'price': service.price
    };
    try {
      await dio.post(
          'https://driver-friend.herokuapp.com/api/sparepart-shops/create-spare',
          data: data);

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> fetchParts() async {
    List<SparePart> parts = [];

    try {
      var fetchedParts = await dio.get(
          'https://driver-friend.herokuapp.com/api/sparepart-shops/spares');

      var getParts = fetchedParts.data['spareParts'];

      getParts.forEach((part) {
        parts.add(
          SparePart(
              id: part['_id'],
              name: part['name'],
              price: part['price'].toString(),
              description: part['description']),
        );
      });
      _spareParts = parts;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteParts(String id) async {
    try {
      await dio.delete(
          'https://driver-friend.herokuapp.com/api/sparepart-shops/delete-spare/$id');

      _spareParts.removeWhere((part) => part.id == id);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  nearSpareShops(String city) {
    _spareShops = _spareShops.where((mechanic) => mechanic.city == city);
    notifyListeners();
  }

  Future<void> spareRating(String id, double rating) async {
    try {
      var rating = await dio
          .post('https://dirver-friend.herokuapp.com/api/drivers/spare-rating');
      print(rating);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
