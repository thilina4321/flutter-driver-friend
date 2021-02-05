import 'package:driver_friend/model/userType.dart';
import 'package:driver_friend/provider/driver_provider.dart';
import 'package:driver_friend/provider/mechanic_provider.dart';
import 'package:driver_friend/provider/service_provider.dart';
import 'package:driver_friend/provider/spare_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/auth/logIn_screen.dart';
import 'package:driver_friend/screen/mechanic/mechnic_form_screen.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_form.dart';
import 'package:driver_friend/screen/sparePartShop/spare_part_shop_form_screen.dart';
import 'package:driver_friend/screen/driver/driver_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = '/signup';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var initialUser = UserType.driver;
  final _form = GlobalKey<FormState>();
  TempararyUser tempararyUser = TempararyUser();

  var confirmPassword = '';

  _saveTempararyUser() {
    _form.currentState.save();
    bool isValid = _form.currentState.validate();
    tempararyUser.userType = initialUser;
    print(tempararyUser.email);
    print(isValid);
    if (!isValid) {
      return;
    }

    switch (initialUser) {
      case UserType.mechanic:
        Provider.of<MechanicProvider>(context, listen: false)
            .addToTempararyUser(tempararyUser);
        Navigator.of(context).pushNamed(MechanicFormScreen.routeName);
        break;
      case UserType.sparePartShop:
        Provider.of<SpareShopProvider>(context, listen: false)
            .addToTempararyUser(tempararyUser);
        Navigator.of(context)
            .pushReplacementNamed(SparePartShopFormScreen.routeName);
        break;
      case UserType.serviceCenter:
        Provider.of<ServiceCenterProvider>(context, listen: false)
            .addToTempararyUser(tempararyUser);
        Navigator.of(context)
            .pushReplacementNamed(ServiceCenterFormScreen.routeName);
        break;
      default:
        Provider.of<DriverProvider>(context, listen: false)
            .addToTempararyUser(tempararyUser);
        Navigator.of(context).pushNamed(DriverFormScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    initialUser = Provider.of<UserProvider>(context).user;
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
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/logo.jpg'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Text(
                        'Welcome to Driver Freind',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Form(
                        key: _form,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                onSaved: (value) {
                                  tempararyUser.name = value;
                                },
                                validator: (value) {
                                  if (value == '') {
                                    return 'User Name is Required';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: 'User Name',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                onSaved: (value) {
                                  tempararyUser.email = value;
                                },
                                validator: (value) {
                                  if (value == '') {
                                    return 'Email is Required';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                onSaved: (value) {
                                  tempararyUser.password = value;
                                },
                                validator: (value) {
                                  if (value == '') {
                                    return 'Password is Required';
                                  }
                                  return null;
                                },
                                textInputAction: TextInputAction.next,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                textInputAction: TextInputAction.done,
                                obscureText: true,
                                onSaved: (value) {
                                  confirmPassword = value;
                                },
                                validator: (value) {
                                  if (value == '') {
                                    return 'Confirm your password';
                                  }
                                  if (confirmPassword !=
                                      tempararyUser.password) {
                                    return 'password should be matched';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Confirm Password',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  labelText: 'User Type',
                                ),
                                items: [
                                  DropdownMenuItem(
                                    value: UserType.driver,
                                    child: Text('Driver'),
                                  ),
                                  DropdownMenuItem(
                                    value: UserType.mechanic,
                                    child: Text('Mechanic'),
                                  ),
                                  DropdownMenuItem(
                                    value: UserType.serviceCenter,
                                    child: Text('Service Center'),
                                  ),
                                  DropdownMenuItem(
                                    value: UserType.sparePartShop,
                                    child: Text('Spare Part Shop'),
                                  ),
                                ],
                                onChanged: (val) {
                                  setState(() {
                                    initialUser = val;
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .userType(initialUser);
                                  });
                                  Provider.of<UserProvider>(context,
                                          listen: false)
                                      .userType(initialUser);
                                },
                                value: initialUser,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: RaisedButton(
                                  onPressed: _saveTempararyUser,
                                  color: Colors.purple,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 11),
                                    child: Text(
                                      'CREATE',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text('Already have an account ?'),
                            SizedBox(
                              height: 20,
                            ),
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/');
                                },
                                child: Text(
                                  'Switch To Loging',
                                  style: TextStyle(
                                    color: Colors.purple,
                                  ),
                                )),
                          ],
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
    );
  }
}
