import 'dart:io';

import 'package:driver_friend/model/mechanic_model.dart';
import 'package:driver_friend/model/userType.dart';
import 'package:driver_friend/provider/driver_provider.dart';
import 'package:driver_friend/provider/mechanic_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/faq/FAQ.dart';
import 'package:driver_friend/screen/map/map_screen.dart';
import 'package:driver_friend/screen/mechanic/mechanic_contact_screen.dart';
import 'package:driver_friend/screen/mechanic/mechnic_form_screen.dart';
import 'package:driver_friend/widget/driver_drawer.dart';
import 'package:driver_friend/widget/mechanic_drawer.dart';
import 'package:driver_friend/widget/rating.dart';
import 'package:driver_friend/widget/static_map_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MechanicProfileScreen extends StatefulWidget {
  static String routeName = '/mechanic-profile';

  @override
  _MechanicProfileScreenState createState() => _MechanicProfileScreenState();
}

class _MechanicProfileScreenState extends State<MechanicProfileScreen> {
  Mechanic mechanic = Mechanic();

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      await Provider.of<MechanicProvider>(context, listen: false)
          .addProfilePicture(pickedFile, me['id']);
    } else {
      print('No image selected.');
    }

    setState(() {});
  }

  var me;
  var id;

  @override
  Widget build(BuildContext context) {
    me = Provider.of<UserProvider>(context, listen: false).me;

    if (me['role'] != 'mechanic') {
      id = ModalRoute.of(context).settings.arguments;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      drawer: me['role'] == 'mechanic' ? MechanicDrawer() : DriverDrawer(),
      body: FutureBuilder(
        future: me['role'] != 'mechanic'
            ? Provider.of<MechanicProvider>(context, listen: false)
                .fetchMechanic(id)
            : Provider.of<MechanicProvider>(context, listen: false)
                .fetchMechanic(me['id']),
        builder: (ctx, data) {
          if (data.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (data.error != null) {
            return Container(
              margin: const EdgeInsets.all(16),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.jpg',
                    fit: BoxFit.cover,
                  ),
                  Text(
                    'Welcome to Driver Friend App ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RaisedButton(
                    padding: const EdgeInsets.all(15),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(MechanicFormScreen.routeName);
                    },
                    color: Colors.purple,
                    child: Text(
                      'Create Profile',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }

          return Consumer<MechanicProvider>(builder: (ctx, mech, child) {
            mechanic = mech.mechanic;
            if (me['role'] == 'mechanic') {
              mechanic.name = me['userName'];
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 250,
                        width: double.infinity,
                        child: mechanic.profileImageUrl == null
                            ? Container(
                                color: Colors.black,
                              )
                            : Image.file(
                                mechanic.profileImageUrl,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Positioned(
                        top: 20,
                        left: 20,
                        child: FlatButton.icon(
                          onPressed: getImage,
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Edit photo',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.black45,
                    child: Column(
                      children: [
                        Text(
                          mechanic.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        if (mechanic.address != null)
                          FlatButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.location_on,
                              color: Colors.white,
                            ),
                            label: Text(
                              mechanic.address,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RatingBarIndicator(
                              rating: mechanic.rating,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.green,
                              ),
                              unratedColor: Colors.white,
                              itemCount: 5,
                              itemSize: 20.0,
                              direction: Axis.horizontal,
                            ),
                            Text(
                              mechanic.rating.toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (me['role'] == 'mechanic')
                    Container(
                      margin: const EdgeInsets.all(3),
                      child: Card(
                        elevation: 3,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
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
                  Container(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Card(
                          elevation: 3,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  MechanicContactScreen.routeName,
                                  arguments: mechanic);
                            },
                            child: const Text(
                              'Contacts',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 3,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(MapScreen.routeName);
                            },
                            child: const Text(
                              'Location',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        if (me['role'] == 'mechanic')
                          Card(
                            elevation: 3,
                            child: FlatButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(FAQ.routeName);
                              },
                              child: const Text(
                                'FAQ',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        if (me['role'] != 'mechanic')
                          Card(
                            elevation: 3,
                            child: FlatButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    CustomRatingWidget.routeName,
                                    arguments: {
                                      'driverId': me['id'],
                                      'id': mechanic.id,
                                      'ratings': mechanic.rating,
                                      'type': 'mechanic'
                                    });
                              },
                              child: const Text(
                                'Rate Me',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (mechanic.latitude != null || mechanic.longitude != null)
                    Container(
                      height: 200,
                      child: Card(
                        elevation: 20,
                        child: Image.network(
                          LocationHelper.generateGoogleImage(
                              lat: mechanic.latitude, long: mechanic.longitude),
                          fit: BoxFit.cover,
                        ),
                      ),
                      margin: const EdgeInsets.all(8),
                      width: double.infinity,
                    ),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}

class CustomeMechanicCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  final args;

  const CustomeMechanicCard({this.title, this.icon, this.route, this.args});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Container(
        child: Column(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(route, arguments: args);
              },
              icon: Icon(
                icon,
                color: Colors.purple,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomMechanicContact extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  final mechanic;

  const CustomMechanicContact(
      {this.title, this.icon, this.route, this.mechanic});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(route, arguments: mechanic);
      },
      child: Column(
        children: [
          Icon(
            icon,
            size: 50,
            color: Colors.purple,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.purple,
            ),
          ),
        ],
      ),
    );
  }
}
