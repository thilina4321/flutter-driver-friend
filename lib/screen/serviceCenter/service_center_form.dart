import 'dart:io';

import 'package:driver_friend/model/service_center.dart';
import 'package:driver_friend/provider/service_provider.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_profile.dart';
import 'package:driver_friend/widget/pick_image.dart';
import 'package:driver_friend/widget/static_map_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class ServiceCenterFormScreen extends StatefulWidget {
  static String routeName = '/service_center-form';

  @override
  _ServiceCenterFormScreenState createState() =>
      _ServiceCenterFormScreenState();
}

class _ServiceCenterFormScreenState extends State<ServiceCenterFormScreen> {
  final _form = GlobalKey<FormState>();

  final picker = ImagePicker();

  Future saveImage(context) async {
    var pickedFile;
    try {
      pickedFile =
          await PickImageFromGalleryOrCamera.getProfileImage(context, picker);
      setState(() {
        if (pickedFile != null) {
          serviceCenter.profileImageUrl = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getLocation() async {
    try {
      final locData = await Location().getLocation();
      serviceCenter.latitude = locData.latitude;
      serviceCenter.longitude = locData.longitude;
      final img = LocationHelper.generateGoogleImage(
          lat: locData.latitude, long: locData.longitude);
      setState(() {
        serviceCenter.mapImagePreview = img;
      });
    } catch (e) {
      print('error');
    }
  }

  ServiceCenter serviceCenter = ServiceCenter();

  Future<void> _saveServiceCenter() async {
    _form.currentState.save();
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    await Provider.of<ServiceCenterProvider>(context, listen: false)
        .createServiceCenter(serviceCenter);
    Navigator.of(context)
        .pushReplacementNamed(ServiceCenterProfileScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    ServiceCenter editableServiceCenter =
        Provider.of<ServiceCenterProvider>(context, listen: false).service;

    if (editableServiceCenter != null) {
      serviceCenter = editableServiceCenter;
    }

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
                  onSaved: (value) {
                    serviceCenter.address = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Address is required';
                    }

                    return null;
                  },
                  initialValue: serviceCenter.address,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Address',
                  ),
                ),
                TextFormField(
                  onSaved: (value) {
                    serviceCenter.mobile = int.parse(value);
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Mobile number is required';
                    }

                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  initialValue: serviceCenter.mobile.toString(),
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                  ),
                ),
                TextFormField(
                  onSaved: (value) {
                    serviceCenter.openingTime = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Open Time is required';
                    }

                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.datetime,
                  initialValue: serviceCenter.openingTime,
                  decoration: InputDecoration(
                    labelText: 'Open time',
                  ),
                ),
                TextFormField(
                  onSaved: (value) {
                    serviceCenter.closingTime = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Close time is required';
                    }

                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.datetime,
                  initialValue: serviceCenter.closingTime,
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
                      onPressed: () => saveImage(context),
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
                        child: serviceCenter.profileImageUrl == null
                            ? Center(child: Text('Profile Image'))
                            : Container(
                                width: double.infinity,
                                child: Image.file(
                                  serviceCenter.profileImageUrl,
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
                        child: serviceCenter.mapImagePreview == null
                            ? Center(
                                child: Text('Your Location'),
                              )
                            : Container(
                                child: Image.network(
                                serviceCenter.mapImagePreview,
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
                    onPressed: _saveServiceCenter,
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
