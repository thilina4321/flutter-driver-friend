import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/faq/FAQ.dart';
import 'package:driver_friend/screen/driver/driver_form_screen.dart';
import 'package:driver_friend/screen/mechanic/mechanics_list.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_list.dart';
import 'package:driver_friend/screen/sparePartShop/spare_part_shop_list.dart';
import 'package:driver_friend/widget/driver_drawer.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class DriverProfileScreen extends StatefulWidget {
  static String routeName = '/driver-profile';

  @override
  _DriverProfileScreenState createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  File _profileImage;

  final picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      drawer: DriverDrawer(),
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
                    'assets/images/car.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 70,
                  left: MediaQuery.of(context).size.width / 4,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/images/dri_pro.jpg'),
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
                        onPressed: getProfileImage),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Janitha Perera',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Janitha Perera is a vehicle owner of the driver friend mobile application',
                textAlign: TextAlign.center,
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
                        'Change Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 50,
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
                      fontWeight: FontWeight.bold,
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
                                  .pushNamed(MechanicListScreen.routeName);
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
                                  .pushNamed(ServiceCenterList.routeName);
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
                                  .pushNamed(SparepartShopListScreen.routeName);
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
                      fontWeight: FontWeight.bold,
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
