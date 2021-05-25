import 'dart:io';

import 'package:driver_friend/helper/error-helper.dart';
import 'package:driver_friend/model/service_center.dart';
import 'package:driver_friend/model/userType.dart';
import 'package:driver_friend/provider/service_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/map/map_screen.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_form.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_services.dart';
import 'package:driver_friend/screen/serviceCenter/service_contact.dart';
import 'package:driver_friend/widget/driver_drawer.dart';
import 'package:driver_friend/widget/pick_image.dart';
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

    if (pickedFile != null) {
      await Provider.of<ServiceCenterProvider>(context, listen: false)
          .addProfilePicture(pickedFile, me['id']);
    } else {
      print('No image selected.');
    }

    setState(() {});
  }

  var idData;
  bool profileLoad = false;

  @override
  Widget build(BuildContext context) {
    me = Provider.of<UserProvider>(context, listen: false).me;

    if (me['role'] != 'serviceCenter') {
      idData = ModalRoute.of(context).settings.arguments;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      drawer: me['role'] == 'serviceCenter'
          ? ServiceCenterDrawer()
          : DriverDrawer(),
      body: FutureBuilder(
        future: me['role'] == 'serviceCenter'
            ? Provider.of<ServiceCenterProvider>(context, listen: false)
                .fetchServiceCenter(me['id'])
            : Provider.of<ServiceCenterProvider>(context, listen: false)
                .fetchServiceCenter(idData),
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
            if (me['role'] == 'serviceCenter') {
              serviceCenter.name = me['userName'];
            }

            Future getImage() async {
              var pickedFile;

              try {
                pickedFile = await PickImageFromGalleryOrCamera.getProfileImage(
                    context, picker);
                if (pickedFile != null) {
                  setState(() {
                    profileLoad = true;
                  });
                  await Provider.of<ServiceCenterProvider>(context,
                          listen: false)
                      .addProfilePicture(pickedFile, me['id']);
                } else {
                  print('No image selected.');
                }
                setState(() {
                  profileLoad = false;
                });
              } catch (e) {
                setState(() {
                  profileLoad = false;
                });
                ErrorDialog.errorDialog(context, e.toString());
              }
            }

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
                            : Image.network(
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
                              onPressed: getImage,
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                              label: profileLoad
                                  ? CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    )
                                  : Text(
                                      'Edit photo',
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.black45,
                    child: Column(
                      children: [
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
                      ],
                    ),
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
                              Navigator.of(context).pushNamed(
                                  ServiceCenterServices.routeName,
                                  arguments: {
                                    'userId': serviceCenter.userId,
                                    'centerName': serviceCenter.name,
                                    'centerMobile': serviceCenter.mobile
                                  });
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
                        if (me['role'] != 'serviceCenter')
                          Card(
                            elevation: 3,
                            child: FlatButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    CustomRatingWidget.routeName,
                                    arguments: {
                                      'driverId': me['id'],
                                      'id': serviceCenter.id,
                                      'ratings': serviceCenter.rating,
                                      'type': 'service'
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
