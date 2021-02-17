import 'dart:io';

import 'package:driver_friend/model/service_center.dart';
import 'package:driver_friend/model/userType.dart';
import 'package:driver_friend/provider/service_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/map/map_screen.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_form.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_services.dart';
import 'package:driver_friend/screen/serviceCenter/service_contact.dart';
import 'package:driver_friend/widget/driver_drawer.dart';
import 'package:driver_friend/widget/rating.dart';
import 'package:driver_friend/widget/service_center_drawer.dart';
import 'package:driver_friend/widget/static_map_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ServiceCenterProfileScreen extends StatefulWidget {
  static String routeName = '/service_center-profile';

  @override
  _ServiceCenterProfileScreenState createState() =>
      _ServiceCenterProfileScreenState();
}

class _ServiceCenterProfileScreenState
    extends State<ServiceCenterProfileScreen> {
  ServiceCenter serviceCenter = ServiceCenter();

  final picker = ImagePicker();
  var me;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        serviceCenter.profileImageUrl = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    me = Provider.of<UserProvider>(context, listen: false).me;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      drawer: ServiceCenterDrawer(),
      body: FutureBuilder(
        future: Provider.of<ServiceCenterProvider>(context, listen: false)
            .fetchServiceCenter(me['_id']),
        builder: (ctx, data) {
          if (data.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (data.error != null) {
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
                    'Welcome to Driver Friend App ' + me['userName'],
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
                          .pushNamed(ServiceCenterFormScreen.routeName);
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
          return Consumer<ServiceCenterProvider>(builder: (ctx, ser, child) {
            serviceCenter = ser.serviceCenter;
            serviceCenter.id = me['_id'];
            serviceCenter.name = me['userName'];

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        child: serviceCenter.profileImageUrl == null
                            ? Container(color: Colors.black)
                            : Image.file(
                                serviceCenter.profileImageUrl,
                                fit: BoxFit.cover,
                              ),
                      ),
                      if (me['role'] == 'serviceCenter')
                        Positioned(
                          top: 20,
                          left: 20,
                          child: Container(
                            color: Colors.black45,
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
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: serviceCenter.name == null
                        ? Text('')
                        : Text(
                            serviceCenter.name,
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
                      // RatingBarIndicator(
                      //   rating: serviceCenter.rating,
                      //   itemBuilder: (context, index) => Icon(
                      //     Icons.star,
                      //     color: Colors.green,
                      //   ),
                      //   unratedColor: Colors.black54,
                      //   itemCount: 5,
                      //   itemSize: 20.0,
                      //   direction: Axis.horizontal,
                      // ),
                      if (serviceCenter.rating != null)
                        Text(serviceCenter.rating.toString()),
                    ],
                  ),
                  if (me['role'] == 'serviceCenter')
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
                                  Navigator.of(context).pushNamed(
                                      ServiceCenterFormScreen.routeName);
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
                                  ServiceCenterContactScreen.routeName,
                                  arguments: serviceCenter);
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
                                  .pushNamed(ServiceCenterServices.routeName);
                            },
                            child: const Text(
                              'Services',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
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
                        Card(
                          elevation: 3,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  CustomRatingWidget.routeName,
                                  arguments: serviceCenter.rating);
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
                  SizedBox(
                    height: 20,
                  ),
                  if (serviceCenter.latitude != null ||
                      serviceCenter.longitude != null)
                    Card(
                      elevation: 3,
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        child: Image.network(
                          LocationHelper.generateGoogleImage(
                              lat: serviceCenter.latitude,
                              long: serviceCenter.longitude),
                          fit: BoxFit.cover,
                        ),
                      ),
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
