import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/FAQ.dart';
import 'package:driver_friend/screen/default_quiz_screen.dart';
import 'package:driver_friend/screen/home_screen.dart';
import 'package:driver_friend/screen/log_In_screen.dart';
import 'package:driver_friend/screen/mechanics_screen.dart';
import 'package:driver_friend/screen/service_center_screen.dart';
import 'package:driver_friend/screen/sing_up_screen.dart';
import 'package:driver_friend/screen/spare_part_shops_screen.dart';
import 'package:driver_friend/screen/user/driver_form_screen.dart';
import 'package:driver_friend/screen/user/driver_profile_screes.dart';
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
          '/': (ctx) => LogInScreen(),
          SignUpScreen.routeName: (ctx) => SignUpScreen(),
          FAQ.routeName: (ctx) => FAQ(),
          DefaultQuestionScreen.routeName: (ctx) => DefaultQuestionScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          DriverProfileScreen.routeName: (ctx) => DriverProfileScreen(),
          DriverFormScreen.routeName: (ctx) => DriverFormScreen(),
          MechanicsScreen.routeName: (ctx) => MechanicsScreen(),
          ServiceCentersScreen.routeName: (ctx) => ServiceCentersScreen(),
          SparePartShopsScreen.routeName: (ctx) => SparePartShopsScreen(),
        },
      ),
    );
  }
}
