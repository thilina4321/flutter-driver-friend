import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/faq/FAQ.dart';
import 'package:driver_friend/screen/faq/default_quiz_screen.dart';
import 'package:driver_friend/screen/driver/driver_form_screen.dart';
import 'package:driver_friend/screen/driver/driver_profile_screes.dart';
import 'package:driver_friend/screen/driver/driver_setting_screen.dart';
import 'package:driver_friend/screen/auth/logIn_screen.dart';
import 'package:driver_friend/screen/mechanic/Mechanic.dart';
import 'package:driver_friend/screen/mechanic/mechanic_contact_screen.dart';
import 'package:driver_friend/screen/mechanic/mechanic_setting.dart';
import 'package:driver_friend/screen/mechanic/mechanics_list.dart';
import 'package:driver_friend/screen/mechanic/mechnic_form_screen.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_form.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_list.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_profile.dart';
import 'package:driver_friend/screen/serviceCenter/service_settings.dart';
import 'package:driver_friend/screen/auth/signup_screen.dart';
import 'package:driver_friend/screen/sparePartShop/Spare_part_shop_profile_screen.dart';
import 'package:driver_friend/screen/sparePartShop/spare_part_shop.dart';
import 'package:driver_friend/screen/sparePartShop/spare_part_shop_form_screen.dart';
import 'package:driver_friend/screen/sparePartShop/spare_setting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Color(0xff2e1503),
          accentColorBrightness: Brightness.dark,
          textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              headline2: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(
                color: Colors.white,
              )),
        ),
        routes: {
          '/': (ctx) => SignUpScreen(),
          LogInScreen.routeName: (ctx) => LogInScreen(),
          FAQ.routeName: (ctx) => FAQ(),

          //driver section
          DriverProfileScreen.routeName: (ctx) => DriverProfileScreen(),
          DriverSettignScreen.routeName: (ctx) => DriverSettignScreen(),
          DriverFormScreen.routeName: (ctx) => DriverFormScreen(),

          //mechanic section
          MechanicListScreen.routeName: (ctx) => MechanicListScreen(),
          MechanicProfileScreen.routeName: (ctx) => MechanicProfileScreen(),
          MechanicFormScreen.routeName: (ctx) => MechanicFormScreen(),
          MechanicSettignScreen.routeName: (ctx) => MechanicSettignScreen(),
          MechanicContactScreen.routeName: (ctx) => MechanicContactScreen(),

          //service center section
          ServiceCenterProfileScreen.routeName: (ctx) =>
              ServiceCenterProfileScreen(),
          ServiceCenterFormScreen.routeName: (ctx) => ServiceCenterFormScreen(),
          ServiceCenterList.routeName: (ctx) => ServiceCenterList(),
          ServiceCenterSettignScreen.routeName: (ctx) =>
              ServiceCenterSettignScreen(),

          //spare part section
          SparepartShopListScreen.routeName: (ctx) => SparepartShopListScreen(),
          SparePartShopProfileScreen.routeName: (ctx) =>
              SparePartShopProfileScreen(),
          SparePartShopFormScreen.routeName: (ctx) => SparePartShopFormScreen(),
          SparePartShopSettignScreen.routeName: (ctx) =>
              SparePartShopSettignScreen(),

          DefaultQuestionScreen.routeName: (ctx) => DefaultQuestionScreen(),
        },
      ),
    );
  }
}
