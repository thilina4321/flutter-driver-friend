import 'package:driver_friend/model/spare_shop.dart';
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

  List<SparePartShop> get spareShop {
    return _spareShop;
  }
}
