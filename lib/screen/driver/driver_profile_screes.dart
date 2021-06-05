import 'dart:io';

import 'package:driver_friend/helper/error-helper.dart';
import 'package:driver_friend/model/drivert.dart';
import 'package:driver_friend/provider/driver_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/faq/FAQ.dart';
import 'package:driver_friend/screen/driver/driver_form_screen.dart';
import 'package:driver_friend/screen/mechanic/mechanics_list.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_list.dart';
import 'package:driver_friend/screen/sparePartShop/spare_part_shop_list.dart';
import 'package:driver_friend/widget/driver_drawer.dart';
import 'package:driver_friend/widget/pick_image.dart';
import 'package:driver_friend/widget/static_map_image.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class DriverProfileScreen extends StatefulWidget {
  static String routeName = '/driver-profile';

  @override
  _DriverProfileScreenState createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  var me;

  final picker = ImagePicker();
  bool profileLoading = false;
  bool coverLoading = false;

  Driver user;

  @override
  Widget build(BuildContext context) {
    me = Provider.of<UserProvider>(context, listen: false).me;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      drawer: DriverDrawer(),
      body: FutureBuilder(
        future: Provider.of<DriverProvider>(context, listen: false)
            .fetchDriver(me['id']),
        builder: (ctx, data) {
          if (data.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (data.error != null) {
            if (data.error.toString().contains('404')) {
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
                      'Welcome to Driver Friend App',
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
                            .pushNamed(DriverFormScreen.routeName);
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
            return Center(
                child: Text(
                    'Sorry something went wrong, please try againg later'));
          }

          return Consumer<DriverProvider>(builder: (ctx, dri, child) {
            user = dri.driver;

            user.userId = me['id'];
            user.name = me['userName'];

            Future saveImage(context, [String imageType = 'profile']) async {
              var pickedFile;
              try {
                pickedFile = await PickImageFromGalleryOrCamera.getProfileImage(
                    context, picker);
                if (pickedFile != null) {
                  if (imageType == 'profile') {
                    setState(() {
                      profileLoading = true;
                    });
                    await Provider.of<DriverProvider>(context, listen: false)
                        .addProfilePicture(pickedFile, me['id']);
                  } else {
                    setState(() {
                      coverLoading = true;
                    });
                    await Provider.of<DriverProvider>(context, listen: false)
                        .addCoverPicture(pickedFile, me['id']);
                  }
                } else {
                  print('No image');
                }

                setState(() {
                  profileLoading = false;
                  coverLoading = false;
                });
              } catch (e) {
                setState(() {
                  profileLoading = false;
                  coverLoading = false;
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
                        child: user.vehicleImageUrl == null
                            ? Container(
                                color: Colors.black,
                              )
                            : Image.network(
                                user.vehicleImageUrl,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Positioned(
                        right: 20,
                        top: 20,
                        child: Container(
                          color: Colors.black54,
                          child: FlatButton.icon(
                            onPressed: () => saveImage(context, 'cover'),
                            label: coverLoading
                                ? CircularProgressIndicator()
                                : Text(
                                    'Edit cover photo',
                                    style: TextStyle(color: Colors.white),
                                  ),
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 20,
                        top: 60,
                        child: Container(
                          color: Colors.black45,
                          child: FlatButton.icon(
                            onPressed: () => saveImage(context),
                            label: profileLoading
                                ? CircularProgressIndicator()
                                : Text(
                                    'Edit profile photo',
                                    style: TextStyle(color: Colors.white),
                                  ),
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 100,
                        left: (MediaQuery.of(context).size.width / 2.5) - 35,
                        child: user.profileImageUrl == null
                            ? CircleAvatar(
                                child: Text(
                                  'Profile',
                                  textAlign: TextAlign.center,
                                ),
                                radius: 70,
                                backgroundColor: Colors.grey,
                              )
                            : CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.teal,
                                child: CircleAvatar(
                                  radius: 68,
                                  backgroundColor: Colors.grey,
                                  backgroundImage:
                                      NetworkImage(user.profileImageUrl),
                                ),
                              ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: user.name == null
                        ? Text('')
                        : Text(
                            user.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: user.name == null
                        ? Text('')
                        : Text(
                            '${user.name} is a vehicle owner of the driver friend mobile application',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
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
                                    Navigator.of(context).pushNamed(
                                        MechanicListScreen.routeName);
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
                                    child:
                                        Center(child: Text('Service Centers')),
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
                                    Navigator.of(context).pushNamed(
                                        SparepartShopListScreen.routeName);
                                  },
                                  child: Card(
                                    elevation: 3,
                                    child:
                                        Center(child: Text('Spare Part Shop')),
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
                                  Navigator.of(context)
                                      .pushNamed(FAQ.routeName);
                                },
                                icon: Icon(Icons.question_answer_rounded,
                                    color: Colors.green),
                                label: Text('FAQ Section')),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'My Home',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Card(
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            child: user.latitude == null
                                ? Center(
                                    child: Text('My Location'),
                                  )
                                : Image.network(
                                    LocationHelper.generateGoogleImage(
                                        lat: user.latitude,
                                        long: user.longitude),
                                    // fit: BoxFit.cover,
                                  ),
                          ),
                        )
                      ],
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
