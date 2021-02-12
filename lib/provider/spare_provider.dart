import 'package:dio/dio.dart';
import 'package:driver_friend/model/part.dart';
import 'package:driver_friend/model/spare_shop.dart';
import 'package:flutter/material.dart';

class SpareShopProvider with ChangeNotifier {
  Dio dio = new Dio();
  final url = 'https://dirver-friend.herokuapp.com/api/sparepart-shops';
  List<SparePartShop> _spareShops = [
    SparePartShop(
        id: '2',
        rating: 5.0,
        name: 'Liyo Spare shop ',
        mobile: 077777777,
        address: 'Alpitiya')
  ];
  SparePartShop _spareShop;

  SparePartShop get spareShop {
    return _spareShop;
  }

  SparePartShop get spare {
    return _spareShops[0];
  }

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
    try {
      Dio dio = new Dio();
      var newSpareShop = await dio.post('$url/add-data', data: spareShop);

      // {
      //   'address': spareShop.address,
      //   'mobile': spareShop.mobile,
      //   'mapImageUrl': spareShop.mapImagePreview,
      //   'longitude': spareShop.longitude,
      //   'latitude': spareShop.latitude,
      //   'city': spareShop.city,
      //   'userType': spareShop.userType
      // }

      print(newSpareShop.data);
      _spareShops.add(newSpareShop.data);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> get fetchSpareShops async {
    List<SparePartShop> shops = [];

    try {
      var fetchedShops = await dio.get('$url/shops');
      shops = fetchedShops.data;
      _spareShops = shops;
      notifyListeners();
    } catch (e) {
      print(e);
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
    try {
      var shop = await dio.patch('$url/create-spare/$id', data: spare);
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
}
