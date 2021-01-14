import 'package:driver_friend/model/userType.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/widget/driver_drawer.dart';
import 'package:driver_friend/widget/mechanic_drawer.dart';
import 'package:driver_friend/widget/service_center_drawer.dart';
import 'package:driver_friend/widget/spare_part_shop_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var mainUser;
  var appDrawer;
  @override
  void initState() {
    mainUser = Provider.of<UserProvider>(context, listen: false).appUser;
    print(mainUser);
    if (mainUser == UserType.driver) {
      appDrawer = DriverDrawer();
    } else if (mainUser == UserType.mechanic) {
      appDrawer = MechanicDrawer();
    } else if (mainUser == UserType.serviceCenter) {
      appDrawer = ServiceCenterDrawer();
    } else {
      appDrawer = SparePartShopDrawer();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: appDrawer,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Driver Friend'),
      ),
    );
  }
}
