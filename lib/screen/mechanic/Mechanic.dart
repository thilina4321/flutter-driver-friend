import 'dart:io';

import 'package:driver_friend/model/mechanic_model.dart';
import 'package:driver_friend/model/userType.dart';
import 'package:driver_friend/provider/mechanic_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
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

    setState(() {
      if (pickedFile != null) {
        mechanic.profileImageUrl = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  var me;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    // if (user == UserType.driver) {
    //   mechanic = ModalRoute.of(context).settings.arguments;
    //   print(mechanic.profileImageUrl);
    // } else {
    //   mechanic = Provider.of<MechanicProvider>(context, listen: false).mechanic;
    // }

    me = Provider.of<UserProvider>(context, listen: false).me;

    if (Provider.of<MechanicProvider>(context).mechanic != null) {
      mechanic = Provider.of<MechanicProvider>(context).mechanic;
    } else {
      mechanic = Mechanic(id: me['_id'], name: me['userName']);
    }

    mechanic.id = me['_id'];
    mechanic.name = me['userName'];

    print(mechanic.latitude);
    print('mechanic.nic');

    print(mechanic.address);

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
                  child:
                      // Image.asset(
                      //   'assets/images/mec_pro.jpg',
                      //   fit: BoxFit.cover,
                      // )),
                      mechanic.profileImageUrl == null
                          ? Container(
                              color: Colors.black,
                            )
                          : Image.network(
                              'mechanic.profileImageUrl',
                              fit: BoxFit.cover,
                            ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: FlatButton.icon(
                    onPressed: () {},
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
                Positioned(
                  top: 150,
                  left: MediaQuery.of(context).size.width / 4,
                  child: Container(
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
                              'mechanic.address',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        if (mechanic.rating != null)
                          Row(
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
                ),
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
                      // if (user == UserType.mechanic)
                      CustomeMechanicCard(
                        title: 'Edit',
                        icon: Icons.edit,
                        route: MechanicFormScreen.routeName,
                      ),
                      CustomeMechanicCard(
                          title: 'Contact',
                          args: mechanic,
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
                          args: mechanic.rating),
                    ],
                  ),
                ),
              ),
            ),
            if (mechanic.nic == null)
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(MechanicFormScreen.routeName,
                      arguments: mechanic.id);
                },
                color: Colors.purple,
                child: Text(
                  'Create profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            if (mechanic.latitude != null)
              Container(
                height: 200,
                child: Card(
                  elevation: 20,
                  child: Image.network(
                    LocationHelper.generateGoogleImage(
                        lat: 37.42796133580664, long: -122.085749655962),
                    // fit: BoxFit.cover,
                  ),
                  //  mechanic.latitude == null
                  //     ? Center(
                  //         child: Text('My place'),
                  //       )
                  //     : Image.network(
                  //         LocationHelper.generateGoogleImage(),
                  //         // mechanic.mapImagePreview,
                  //         fit: BoxFit.cover,
                  //       ),
                ),
                //  mechanic.mapImagePreview == null
                //     ? Center(child: Text('No location yet..'))
                //     : Card(
                //         elevation: 20,
                //         child: Image.network(
                //           LocationHelper.generateGoogleImage(),
                //           // mechanic.mapImagePreview,
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                margin: const EdgeInsets.all(8),
                width: double.infinity,
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
