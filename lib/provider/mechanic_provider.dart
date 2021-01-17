import 'package:driver_friend/model/mechanic_model.dart';
import 'package:driver_friend/model/userType.dart';
import 'package:driver_friend/provider/user_provider.dart';
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

  Mechanic get mechanic {
    return _mechanics[0];
  }

  TempararyUser _tempararyUser = TempararyUser();
  addToTempararyUser(TempararyUser tempararyUser) {
    _tempararyUser.email = tempararyUser.email;
    _tempararyUser.name = tempararyUser.name;
    _tempararyUser.password = tempararyUser.password;
    _tempararyUser.userType = tempararyUser.userType;
    print(_tempararyUser.userType);
    print(_tempararyUser.email);
    notifyListeners();
  }

  createMechanic(Mechanic mechanic) {
    mechanic.id = (_mechanics.length + 1).toString();
    mechanic.email = _tempararyUser.email;
    mechanic.name = _tempararyUser.name;
    mechanic.password = _tempararyUser.password;
    mechanic.userType = _tempararyUser.userType;

    _mechanics.add(mechanic);
    notifyListeners();
  }

  List<Mechanic> get mechanics {
    return _mechanics;
  }

  selectMechanic(id) {
    final mechanic = _mechanics.firstWhere((mec) => mec.id == id);
    return mechanic;
  }
}
