import 'dart:io';

import 'package:driver_friend/helper/error-helper.dart';
import 'package:driver_friend/model/service_center.dart';
import 'package:driver_friend/provider/service_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_profile.dart';
import 'package:driver_friend/widget/pick_image.dart';
import 'package:driver_friend/widget/static_map_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;

class ServiceCenterFormScreen extends StatefulWidget {
  static String routeName = '/service_center-form';

  @override
  _ServiceCenterFormScreenState createState() =>
      _ServiceCenterFormScreenState();
}

class _ServiceCenterFormScreenState extends State<ServiceCenterFormScreen> {
  final _form = GlobalKey<FormState>();

  final picker = ImagePicker();
  ServiceCenter serviceCenter = ServiceCenter();
  var me;
  bool isLoading = false;

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

  bool isLoadingMap = false;

  Future<void> getLocation() async {
    setState(() {
      isLoadingMap = true;
    });
    try {
      final locData = await Location().getLocation();
      serviceCenter.latitude = locData.latitude;
      serviceCenter.longitude = locData.longitude;
      final img = LocationHelper.generateGoogleImage(
          lat: locData.latitude, long: locData.longitude);

      List<geoCoding.Placemark> placemarks =
          await geoCoding.placemarkFromCoordinates(
              serviceCenter.latitude, serviceCenter.longitude);
      serviceCenter.city = placemarks[0].name;

      setState(() {
        isLoadingMap = false;
      });
      setState(() {
        serviceCenter.mapImagePreview = img;
      });
    } catch (e) {
      setState(() {
        isLoadingMap = false;
      });
      ErrorDialog.errorDialog(context, 'Some thing went wrong');
    }
  }

  Future<void> _saveServiceCenter() async {
    _form.currentState.save();
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    serviceCenter.userId = me["id"];
    serviceCenter.name = me['userName'];
    try {
      setState(() {
        isLoading = true;
      });
      await Provider.of<ServiceCenterProvider>(context, listen: false)
          .createServiceCenter(serviceCenter);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushNamed(ServiceCenterProfileScreen.routeName);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Container(
                  child: Text(
                e.toString(),
              )),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    me = Provider.of<UserProvider>(context, listen: false).me;

    ServiceCenter editableServiceCenter =
        Provider.of<ServiceCenterProvider>(context, listen: false)
            .serviceCenter;
    print(editableServiceCenter.openingTime);
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    serviceCenter.mobile = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Mobile number is required';
                    }

                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  initialValue: serviceCenter.mobile,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                Text(
                  'Please notice when you add your location. We determine your location as current location',
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                if (isLoadingMap) Center(child: CircularProgressIndicator()),
                serviceCenter.mapImagePreview == null
                    ? SizedBox(
                        height: 1,
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              child: Container(
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
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text(
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
