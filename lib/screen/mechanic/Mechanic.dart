import 'dart:io';

import 'package:driver_friend/model/mechanic_model.dart';
import 'package:driver_friend/model/userType.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/map/map_screen.dart';
import 'package:driver_friend/screen/mechanic/mechanic_contact_screen.dart';
import 'package:driver_friend/screen/mechanic/mechnic_form_screen.dart';
import 'package:driver_friend/widget/driver_drawer.dart';
import 'package:driver_friend/widget/mechanic_drawer.dart';
import 'package:driver_friend/widget/rating.dart';

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
  Mechanic data = Mechanic();

  File _profileImage;
  String _mapImage;

  final picker = ImagePicker();

  Future getImage() async {
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
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user == UserType.driver) {
      data = ModalRoute.of(context).settings.arguments;
    } else {
      data = Provider.of<UserProvider>(context, listen: false).mechanic;
    }

    print(data.name);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      drawer: user == UserType.driver ? DriverDrawer() : MechanicDrawer(),
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
                          data.name,
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
                            data.address,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: data.rating,
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
                              data.rating.toString(),
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
                        onPressed: getImage),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CustomeMechanicCard(
                        title: 'Edit',
                        icon: Icons.edit,
                        route: MechanicFormScreen.routeName,
                      ),
                      CustomeMechanicCard(
                          title: 'Contact',
                          args: data,
                          icon: Icons.contact_page,
                          route: MechanicContactScreen.routeName),
                      CustomeMechanicCard(
                        title: 'Location',
                        icon: Icons.location_on,
                        route: MapScreen.routeName,
                      ),
                      CustomeMechanicCard(
                        title: 'Rate',
                        icon: Icons.star_rate,
                        route: CustomRatingWidget.routeName,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 300,
              child: _mapImage == null
                  ? Center(child: Text('No location yet..'))
                  : Image.network(
                      _mapImage,
                      fit: BoxFit.cover,
                    ),
              margin: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.purple),
              ),
            ),
          ],
        ),
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
