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
  List<SparePart> _spareParts;

  SparePartShop get spareShop {
    return _spareShop;
  }

  List<SparePart> get spareParts {
    return [..._spareParts];
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

  Future<void> addParts(SparePart service) async {
    // FormData data = new FormData.fromMap({
    //   'name': part.name,
    //   'description': part.description,
    //   'price': part.price
    // });
    print(service.description);

    var data = {
      'name': service.name,
      'description': service.description,
      'price': service.price
    };
    try {
      var newService = await dio.post(
          'https://driver-friend.herokuapp.com/api/sparepart-shops/create-spare',
          data: data);
      var fetchedService = newService.data['spareParts'];
      print(fetchedService);
      // _spareParts.add(
      //   SparePart(
      //       id: fetchedService['_id'],
      //       name: service.name,
      //       description: service.description,
      //       price: service.price),
      // );

      print(fetchedService);
      notifyListeners();
      // print(fetchedParts);
      // notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> fetchParts() async {
    print('object');
    List<SparePart> parts = [];
    try {
      var fetchedParts = await dio.get(
          'https://driver-friend.herokuapp.com/api/sparepart-shops/spares');
      // print(fetchedParts.data);
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
      print(e);
      throw e;
    }
  }

  Future<void> deleteParts(String id) async {
    print(id);
    try {
      var s = await dio.delete(
          'https://driver-friend.herokuapp.com/api/sparepart-shops/delete-service/$id');
      _spareParts.removeWhere((part) => part.id == id);
      print(s);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  nearSpareShops(String city) {
    _spareShops = _spareShops.where((mechanic) => mechanic.city == city);
    notifyListeners();
  }
}
