import 'package:dio/dio.dart';
import 'package:driver_friend/model/part.dart';
import 'package:driver_friend/model/spare_shop.dart';
import 'package:flutter/material.dart';

class SpareShopProvider with ChangeNotifier {
  Dio dio = new Dio();
  final url = 'https://dirver-friend.herokuapp.com/api/sparepart-shops';
  List<SparePartShop> _spareShops = [
    // SparePartShop(
    //     id: '2',
    //     rating: 5.0,
    //     name: 'Liyo Spare shop ',
    //     mobile: 077777777,
    //     address: 'Alpitiya')
  ];
  SparePartShop _spareShop;

  SparePartShop get spareShop {
    return _spareShop;
  }

  // SparePartShop get spare {
  //   return _spareShops[0];
  // }

  List<SparePartShop> get spareShops {
    return _spareShops;
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
      'shopId': spareShop.id,
      'address': spareShop.address,
      'mapImageUrl': spareShop.mapImagePreview,
      'longitude': spareShop.longitude,
      'latitude': spareShop.latitude,
      'city': spareShop.city,
      'userType': spareShop.userType
    };
    try {
      Dio dio = new Dio();
      var newSpareShop = await dio.post(
          'https://driver-friend.herokuapp.com/api/sparepart-shops/add-data',
          data: data);

      print(newSpareShop.data);
      var ser = newSpareShop.data['spareshop'];

      _spareShop = SparePartShop(
          id: ser['shopId'],
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

  Future<void> fetchSpareShop(id) async {
    print(id);
    try {
      var fetchedShops = await dio.get(
          'https://driver-friend.herokuapp.com/api/sparepart-shops/spare-shop/$id');
      // print(fetchedShops.data);
      var shops = fetchedShops.data['spareshop'];
      // print(shops);
      _spareShop = SparePartShop(
        id: shops['_id'],
        mobile: shops['mobile'],
        city: shops['city'],
        latitude: shops['latitude'],
        longitude: shops['longitude'],
      );
      print(_spareShop.city);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> editSpareShop(String id, SparePartShop spare) async {
    try {
      var shop = await dio.patch('$url/delete-spare/$id', data: spare);
      int shopIndex = _spareShops.indexWhere((shop) => shop.id == id);
      _spareShops[shopIndex] = shop.data;
      notifyListeners();
      print(shop.data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteShop(String id) async {
    try {
      var shop = await dio.delete('$url/delete-spare/$id');
      print(shop.data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> createPart(String id, SparePart part) async {
    var data;
    try {
      var shop = await dio.patch('$url/create-spare/$id', data: data);
      print(shop.data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchParts() async {
    try {
      var shop = await dio.get('$url/spares');
      print(shop.data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deletePart(String id) async {
    try {
      var shop = await dio.delete('$url/delete-spare/$id');
      print(shop.data);
    } catch (e) {
      print(e);
    }
  }

  nearSpareShops(String city) {
    _spareShops = _spareShops.where((mechanic) => mechanic.city == city);
    notifyListeners();
  }
}
