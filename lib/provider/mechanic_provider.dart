import 'package:driver_friend/model/mechanic_model.dart';
import 'package:driver_friend/model/userType.dart';
import 'package:flutter/material.dart';

class MechanicProvider with ChangeNotifier {
  List<Mechanic> _mechanics = [
    Mechanic(
        id: '1',
        rating: 2.0,
        name: "Minol",
        address: '64/1 Aracchnikattuwa',
        userType: UserType.mechanic,
        mobile: 0776543322),
    Mechanic(
        id: '2',
        rating: 5.0,
        userType: UserType.mechanic,
        name: "Pragesha",
        address: '55 Halawatha',
        mobile: 0765552244),
  ];

  List<Mechanic> get mechanics {
    return _mechanics;
  }

  selectMechanic(id) {
    final mechanic = _mechanics.firstWhere((mec) => mec.id == id);
    return mechanic;
  }
}
