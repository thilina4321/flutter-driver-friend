import 'dart:io';

import 'package:driver_friend/screen/serviceCenter/service_center_profile.dart';
import 'package:driver_friend/widget/static_map_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class ServiceCenterFormScreen extends StatefulWidget {
  static String routeName = '/service_center-form';

  @override
  _ServiceCenterFormScreenState createState() =>
      _ServiceCenterFormScreenState();
}

class _ServiceCenterFormScreenState extends State<ServiceCenterFormScreen> {
  final _form = GlobalKey<FormState>();

  File _profileImage;

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

  String _mapImagePreview;

  Future<void> getLocation() async {
    try {
      final locData = await Location().getLocation();
      print(locData);
      final img = LocationHelper.generateGoogleImage(
          lat: locData.latitude, long: locData.longitude);
      setState(() {
        _mapImagePreview = img;
      });
    } catch (e) {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Service Center Details'),
      ),
      body: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Address',
                  ),
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                  ),
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: 'Open time',
                  ),
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: 'Close time',
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                        child: FlatButton.icon(
                      onPressed: getImage,
                      icon: Icon(
                        Icons.photo_camera,
                        color: Colors.purple,
                      ),
                      label: Text('Profile Picture'),
                    )),
                    Expanded(
                      child: FlatButton.icon(
                          onPressed: getLocation,
                          icon: Icon(
                            Icons.location_on,
                            color: Colors.purple,
                          ),
                          label: Text('Location')),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        child: _profileImage == null
                            ? Center(child: Text('Profile Image'))
                            : Container(
                                width: double.infinity,
                                child: Image.file(
                                  _profileImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: _mapImagePreview == null
                            ? Center(
                                child: Text('Your Location'),
                              )
                            : Container(
                                child: Image.network(
                                _mapImagePreview,
                                fit: BoxFit.cover,
                              )),
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(
                          ServiceCenterProfileScreen.routeName);
                    },
                    color: Colors.purple,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
