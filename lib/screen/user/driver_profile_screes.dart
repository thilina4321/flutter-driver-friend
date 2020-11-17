import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/FAQ.dart';
import 'package:driver_friend/screen/mechanics_screen.dart';
import 'package:driver_friend/screen/service_center_screen.dart';
import 'package:driver_friend/screen/spare_part_shops_screen.dart';
import 'package:driver_friend/screen/user/driver_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DriverProfileScreen extends StatelessWidget {
  static String routeName = '/driver-profile';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Image.asset(
                'assets/images/sai.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${user.name}',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${user.name} is a vehicle owner of the driver friend mobile application',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: Card(
                elevation: 3,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    children: [
                      Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(DriverFormScreen.routeName);
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    'Your DashBoard',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 100,
                          child: FlatButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(MechanicsScreen.routeName);
                            },
                            child: Card(
                              elevation: 3,
                              child: Center(child: Text('Mechanics')),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 100,
                          child: FlatButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(ServiceCentersScreen.routeName);
                            },
                            child: Card(
                              elevation: 3,
                              child: Center(child: Text('Service Centers')),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 100,
                          child: FlatButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(SparePartShopsScreen.routeName);
                            },
                            child: Card(
                              elevation: 3,
                              child: Center(child: Text('Spare Part Shop')),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Get Help From Experts',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      elevation: 3,
                      child: FlatButton.icon(
                          onPressed: () {
                            Navigator.of(context).pushNamed(FAQ.routeName);
                          },
                          icon: Icon(Icons.question_answer_rounded,
                              color: Colors.green),
                          label: Text('FAQ Section')),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
