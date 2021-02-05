import 'package:driver_friend/model/userType.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/auth/signup_screen.dart';
import 'package:driver_friend/screen/driver/driver_form_screen.dart';
import 'package:driver_friend/screen/driver/driver_profile_screes.dart';
import 'package:driver_friend/screen/mechanic/Mechanic.dart';
import 'package:driver_friend/screen/mechanic/mechnic_form_screen.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_form.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_profile.dart';
import 'package:driver_friend/screen/sparePartShop/Spare_part_shop_profile_screen.dart';
import 'package:driver_friend/screen/sparePartShop/spare_part_shop_form_screen.dart';
import 'package:driver_friend/widget/polyline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';

class LogInScreen extends StatefulWidget {
  static String routeName = '/login';

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  var initialUser = UserType.driver;
  final _form = GlobalKey<FormState>();

  _saveTempararyUser() {
    _form.currentState.save();
    bool isValid = _form.currentState.validate();

    print(isValid);
    // if (!isValid) {
    //   return;
    // }

    switch (initialUser) {
      case UserType.mechanic:
        Navigator.of(context).pushNamed(MechanicProfileScreen.routeName);
        break;
      case UserType.sparePartShop:
        Navigator.of(context)
            .pushReplacementNamed(SparePartShopProfileScreen.routeName);
        break;
      case UserType.serviceCenter:
        Navigator.of(context)
            .pushReplacementNamed(ServiceCenterProfileScreen.routeName);
        break;
      default:
        Navigator.of(context).pushNamed(DriverProfileScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // FlatButton(
                //     onPressed: () {
                //       Navigator.of(context).pushNamed(PolyLineScreen.routeName);
                //     },
                //     child: Text('map')),
                Row(
                  children: [
                    Icon(
                      Icons.car_rental,
                      size: 80,
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(SignUpScreen.routeName);
                          },
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Welcome to Driver Freind',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'The system that help for drivers to overcome their issues.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Form(
                  key: _form,
                  child: Column(
                    children: [
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              icon: Icon(Icons.email_outlined),
                              labelText: 'Email',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                            decoration: InputDecoration(
                              icon: Icon(Icons.lock_outline),
                              labelText: 'Password',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: DropdownButtonFormField(
                      //     decoration: InputDecoration(
                      //       labelText: 'User Type',
                      //     ),
                      //     items: [
                      //       DropdownMenuItem(
                      //         value: UserType.driver,
                      //         child: Text('Driver'),
                      //       ),
                      //       DropdownMenuItem(
                      //         value: UserType.mechanic,
                      //         child: Text('Mechanic'),
                      //       ),
                      //       DropdownMenuItem(
                      //         value: UserType.serviceCenter,
                      //         child: Text('Service Center'),
                      //       ),
                      //       DropdownMenuItem(
                      //         value: UserType.sparePartShop,
                      //         child: Text('Spare Part Shop'),
                      //       ),
                      //     ],
                      //     onChanged: (val) {
                      //       setState(() {
                      //         initialUser = val;
                      //         Provider.of<UserProvider>(context, listen: false)
                      //             .userType(initialUser);
                      //       });
                      //       Provider.of<UserProvider>(context, listen: false)
                      //           .userType(initialUser);
                      //     },
                      //     value: initialUser,
                      //   ),
                      // ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: _saveTempararyUser,
                          color: Colors.purple,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              'Continue to log In',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
