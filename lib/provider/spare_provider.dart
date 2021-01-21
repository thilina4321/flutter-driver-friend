import 'package:driver_friend/model/spare_shop.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:flutter/material.dart';

class SpareShopProvider with ChangeNotifier {
  final List<SparePartShop> _spareShop = [
    SparePartShop(
        id: '2',
        rating: 3.0,
        name: 'Tharuka Spare shop ',
        mobile: 077777777,
        address: 'Dehiattakandiya'),
    SparePartShop(
        id: '3',
        rating: 4.0,
        name: 'Malikshi Spare Shop',
        mobile: 07666666,
        address: 'Horana'),
  ];

  SparePartShop get spare {
    return _spareShop[0];
  }

  List<SparePartShop> get spareShop {
    return _spareShop;
  }

  TempararyUser _tempararyUser = TempararyUser();

  addToTempararyUser(TempararyUser tempararyUser) {
    _tempararyUser.email = tempararyUser.email;
    _tempararyUser.name = tempararyUser.name;
    _tempararyUser.password = tempararyUser.password;
    _tempararyUser.userType = tempararyUser.userType;

    notifyListeners();
  }

  createSpareShop(SparePartShop spareshop) {
    spareshop.id = (_spareShop.length + 1).toString();
    spareshop.email = _tempararyUser.email;
    spareshop.name = _tempararyUser.name;
    spareshop.password = _tempararyUser.password;
    spareshop.userType = _tempararyUser.userType;

    print(spareshop.mobile);
    _spareShop.insert(0, spareshop);
    notifyListeners();
  }
}
