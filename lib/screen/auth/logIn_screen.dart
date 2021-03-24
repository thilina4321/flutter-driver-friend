import 'package:driver_friend/model/userType.dart';
import 'package:driver_friend/screen/auth/signup_screen.dart';
import 'package:driver_friend/screen/driver/driver_profile_screes.dart';
import 'package:driver_friend/screen/mechanic/Mechanic.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_profile.dart';
import 'package:driver_friend/screen/sparePartShop/Spare_part_shop_profile_screen.dart';
import 'package:flutter/material.dart';

import 'package:driver_friend/provider/user_provider.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  static String routeName = '/login';

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  var initialUser = UserType.driver;
  final _form = GlobalKey<FormState>();
  var me;
  bool isLoading = false;

  Map<String, String> user = {'email': '', 'password': ''};

  Future<void> _login() async {
    _form.currentState.save();
    bool isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<UserProvider>(context, listen: false)
          .login(user['email'], user['password']);

      me = await Provider.of<UserProvider>(context, listen: false).me;
      setState(() {
        isLoading = false;
      });
      _form.currentState.reset();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: e.toString().contains('422')
                  ? Text('Email or password is incorrect')
                  : Text(
                      'Sorry something gone wrong, try again later',
                    ),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
    }

    // print(me);

    switch (me['role']) {
      case 'mechanic':
        Navigator.of(context).pushNamed(MechanicProfileScreen.routeName);
        break;

      case 'serviceCenter':
        Navigator.of(context).pushNamed(ServiceCenterProfileScreen.routeName);
        break;

      case 'sparePartShop':
        Navigator.of(context).pushNamed(SparePartShopProfileScreen.routeName);
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
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Form(
                    key: _form,
                    child: Card(
                      elevation: 1,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onSaved: (value) {
                                user['email'] = value;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: 'Email',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              obscureText: true,
                              onSaved: (value) {
                                user['password'] = value;
                              },
                              decoration: InputDecoration(
                                labelText: 'Password',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            width: double.infinity,
                            child: RaisedButton(
                              onPressed: _login,
                              color: Colors.purple,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: isLoading
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Text(
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
