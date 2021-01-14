import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_form.dart';
import 'package:driver_friend/widget/service_center_drawer.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceCenterProfileScreen extends StatelessWidget {
  static String routeName = '/service_center-profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      drawer: ServiceCenterDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/ser_cover.PNG',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 70,
                  left: MediaQuery.of(context).size.width / 4,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/images/ser_pro.jpg'),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 180,
                  child: FlatButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.photo_camera,
                        size: 23,
                        color: Colors.white,
                      )),
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
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                'Liyo Service Center',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(3),
              child: Card(
                elevation: 3,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    children: [
                      Text(
                        'Change Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(ServiceCenterFormScreen.routeName);
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
              children: [
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Contacts',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Services',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 250,
              width: double.infinity,
              child: Image.asset(
                'assets/images/ser_loc.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
