import 'package:driver_friend/model/userType.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = '/signup';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var initialUser = UserType.driver;

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
                Icon(
                  Icons.car_rental,
                  size: 80,
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
                  child: Column(
                    children: [
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
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
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              icon: Icon(Icons.lock_outline),
                              labelText: 'Password',
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
                            decoration: InputDecoration(
                              icon: Icon(Icons.lock_outline),
                              labelText: 'Confirm Password',
                              border: InputBorder.none,
                            ),
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
                            });
                            Provider.of<UserProvider>(context, listen: false)
                                .userType(initialUser);
                          },
                          value: initialUser,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed('/');
                          },
                          color: Colors.purple,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              'Continue to register',
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
