import 'dart:io';

import 'package:driver_friend/screen/mechanic/Mechanic.dart';
import 'package:driver_friend/widget/static_map_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class MechanicFormScreen extends StatefulWidget {
  static String routeName = '/mechanic-form';

  @override
  _MechanicFormScreenState createState() => _MechanicFormScreenState();
}

class _MechanicFormScreenState extends State<MechanicFormScreen> {
  final _form = GlobalKey<FormState>();
  File _profileImage;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Mechanic Details'),
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
                    labelText: 'User Name',
                  ),
                ),
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
                    labelText: 'Address',
                  ),
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'About',
                  ),
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
                      ),
                    ),
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
                        height: 100,
                        child: Center(
                          child: _profileImage == null
                              ? Text('Profile Image')
                              : Container(
                                  width: double.infinity,
                                  child: Image.file(
                                    _profileImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        child: Center(
                          child: _mapImagePreview == null
                              ? Text('Your Location')
                              : Container(
                                  width: double.infinity,
                                  child: Image.network(
                                    _mapImagePreview,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
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
                          MechanicProfileScreen.routeName);
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
