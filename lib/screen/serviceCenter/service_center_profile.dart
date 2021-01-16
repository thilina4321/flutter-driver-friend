import 'dart:io';

import 'package:driver_friend/model/service_center.dart';
import 'package:driver_friend/model/userType.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/map/map_screen.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_form.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_services.dart';
import 'package:driver_friend/screen/serviceCenter/service_contact.dart';
import 'package:driver_friend/widget/driver_drawer.dart';
import 'package:driver_friend/widget/service_center_drawer.dart';
import 'package:driver_friend/widget/static_map_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
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

  File _profileImage;
  String _mapImagePreview;

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
    final ServiceCenter data = ModalRoute.of(context).settings.arguments;
    if (data != null) {
      serviceCenter = data;
    } else {
      serviceCenter =
          Provider.of<UserProvider>(context, listen: false).serviceCenter;
    }

    final UserType user =
        Provider.of<UserProvider>(context, listen: false).user;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      drawer: user == UserType.driver ? DriverDrawer() : ServiceCenterDrawer(),
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
                  top: 40,
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
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
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
                RatingBarIndicator(
                  rating: serviceCenter.rating,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.green,
                  ),
                  unratedColor: Colors.black54,
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
                Text(serviceCenter.rating.toString()),
              ],
            ),
            if (user == UserType.serviceCenter)
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
                        Navigator.of(context).pushNamed(MapScreen.routeName);
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
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 3,
              child: Container(
                height: 200,
                width: double.infinity,
                child: _mapImagePreview == null
                    ? Center(child: Text('No Location yet..'))
                    : Image.network(
                        _mapImagePreview,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
