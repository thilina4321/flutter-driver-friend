import 'package:driver_friend/screen/driver/driver_profile_screes.dart';
import 'package:driver_friend/widget/static_map_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:location/location.dart';

class DriverFormScreen extends StatefulWidget {
  static String routeName = '/driver-form';

  @override
  _DriverFormScreenState createState() => _DriverFormScreenState();
}

class _DriverFormScreenState extends State<DriverFormScreen> {
  final _form = GlobalKey<FormState>();

  File _profileImage;
  File _vehicleImage;

  final picker = ImagePicker();
  var _mapImagePreview;

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

  Future vehicleImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _vehicleImage = File(pickedFile.path);
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
        title: Text('Driver Details'),
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
                    labelText: 'NIC',
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
                  decoration: InputDecoration(
                    labelText: 'Vehicle Number',
                  ),
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Vehicle Color',
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: FlatButton.icon(
                        onPressed: getProfileImage,
                        icon: Icon(
                          Icons.photo_camera,
                          color: Colors.purple,
                        ),
                        label: Text('Profile Picture'),
                      ),
                    ),
                    Expanded(
                      child: FlatButton.icon(
                        onPressed: vehicleImage,
                        icon: Icon(
                          Icons.photo_camera,
                          color: Colors.purple,
                        ),
                        label: Text('Vehicle Picture'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        alignment: Alignment.center,
                        child: _profileImage == null
                            ? Text('Profile Image')
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
                        height: 100,
                        alignment: Alignment.center,
                        child: _vehicleImage == null
                            ? Text('Vehicle Image')
                            : Container(
                                width: double.infinity,
                                child: Image.file(
                                  _vehicleImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                        ),
                      ),
                    ),
                  ],
                ),
                FlatButton.icon(
                  onPressed: getLocation,
                  icon: Icon(
                    Icons.map,
                    color: Colors.purple,
                  ),
                  label: Text('Your location'),
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  alignment: Alignment.center,
                  child: _mapImagePreview == null
                      ? Text('Location not select yet')
                      : Container(
                          width: double.infinity,
                          child: Image.network(
                            _mapImagePreview,
                            fit: BoxFit.cover,
                          ),
                        ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(DriverProfileScreen.routeName);
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
