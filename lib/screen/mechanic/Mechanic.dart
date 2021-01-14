import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/FAQ.dart';
import 'package:driver_friend/screen/mechanic/mechnic_form_screen.dart';
import 'package:driver_friend/screen/mechanics_screen.dart';
import 'package:driver_friend/screen/service_center_screen.dart';
import 'package:driver_friend/screen/spare_part_shops_screen.dart';
import 'package:driver_friend/screen/driver/driver_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MechanicProfileScreen extends StatelessWidget {
  static String routeName = '/mechanic-profile';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/mec_cover.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 150,
                  left: MediaQuery.of(context).size.width / 4,
                  child: Container(
                    color: Colors.black45,
                    child: Column(
                      children: [
                        Text(
                          'Prageesha',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        FlatButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Arrachchikattuwa',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.green,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.green,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.green,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.green,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.green,
                            ),
                            Text(
                              '5.0',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 180,
                  child: Container(
                    color: Colors.black45,
                    child: FlatButton.icon(
                        label: Text(
                          'Edit cover photo',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        icon: Icon(
                          Icons.photo_camera,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () {}),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
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
                        'About',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        'More',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(MechanicFormScreen.routeName);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.purple,
                      ),
                      Text(
                        'Contact Us',
                        style: TextStyle(
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 50,
                        color: Colors.purple,
                      ),
                      Text(
                        'Location',
                        style: TextStyle(
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Description about technishiant engine and garage',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    height: 50,
                    width: 130,
                    margin: EdgeInsets.all(5),
                    child: Image.asset(
                      'assets/images/mec_1.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 130,
                    margin: EdgeInsets.all(5),
                    child: Image.asset(
                      'assets/images/mec_3.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 130,
                    margin: EdgeInsets.all(5),
                    child: Image.asset(
                      'assets/images/mec_1.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 130,
                    margin: EdgeInsets.all(5),
                    child: Image.asset(
                      'assets/images/mec_3.jpeg',
                      fit: BoxFit.cover,
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
