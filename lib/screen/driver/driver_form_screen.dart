import 'package:driver_friend/helper/error-helper.dart';
import 'package:driver_friend/model/drivert.dart';
import 'package:driver_friend/provider/driver_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/driver/driver_profile_screes.dart';
import 'package:driver_friend/widget/static_map_image.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;
import 'package:image_picker/image_picker.dart';
import 'dart:async';

import 'package:location/location.dart';
import 'package:provider/provider.dart';

class DriverFormScreen extends StatefulWidget {
  static String routeName = '/driver-form';

  @override
  _DriverFormScreenState createState() => _DriverFormScreenState();
}

class _DriverFormScreenState extends State<DriverFormScreen> {
  final _form = GlobalKey<FormState>();
  Driver driver = Driver();

  final picker = ImagePicker();
  bool isLoading = false;

  Future<void> getLocation() async {
    try {
      setState(() {
        isLoading = true;
      });
      final locData = await Location().getLocation();
      driver.latitude = locData.latitude;
      driver.longitude = locData.longitude;

      final img = LocationHelper.generateGoogleImage(
          lat: locData.latitude, long: locData.longitude);

      List<geoCoding.Placemark> placemarks = await geoCoding
          .placemarkFromCoordinates(driver.latitude, driver.longitude);
      driver.city = placemarks[0].name;

      setState(() {
        isLoading = false;
        driver.mapImagePreview = img;
      });
    } catch (e) {
      isLoading = false;
      print('error');
    }
  }

  var me;

  Future<void> _saveDriver() async {
    _form.currentState.save();
    final isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }

    driver.userId = me['id'];
    driver.userName = me['userName'];
    setState(() {
      isLoading = true;
    });

    try {
      await Provider.of<DriverProvider>(context, listen: false)
          .createDriver(driver, driverId);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacementNamed(DriverProfileScreen.routeName);
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ErrorDialog.errorDialog(context, 'Something went wrong');
    }
  }

  String driverId;

  @override
  Widget build(BuildContext context) {
    me = Provider.of<UserProvider>(context).me;

    Driver editable =
        Provider.of<DriverProvider>(context, listen: false).driver;

    if (editable != null) {
      driver = editable;
      driverId = driver.id;
    }

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
                  onSaved: (value) {
                    driver.nic = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'NIC is required';
                    }
                    if (value.length != 10) {
                      return 'Invalid NIC';
                    }
                    return null;
                  },
                  initialValue: driver.nic,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'NIC',
                  ),
                ),
                TextFormField(
                  onSaved: (value) {
                    driver.mobile = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Mobile number is required';
                    }
                    if (value.length != 10) {
                      return 'Invalid Mobile number';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  initialValue: driver.mobile,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                  ),
                ),
                TextFormField(
                  onSaved: (value) {
                    driver.vehicleNumber = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Vehicle number is required';
                    }

                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  initialValue: driver.vehicleNumber,
                  decoration: InputDecoration(
                    labelText: 'Vehicle Number',
                  ),
                ),
                TextFormField(
                  onSaved: (value) {
                    driver.vehicleColor = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Vehicle color is required';
                    }

                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  initialValue: driver.vehicleColor,
                  decoration: InputDecoration(
                    labelText: 'Vehicle Color',
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                if (isLoading) CircularProgressIndicator(),
                FlatButton.icon(
                  onPressed: getLocation,
                  icon: Icon(
                    Icons.map,
                    color: Colors.purple,
                  ),
                  label: Text('Location'),
                ),
                Container(
                  child: Text(
                    'Please notice we consider your location as current location. How ever you can set location later or you can change it later',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (driver.mapImagePreview != null)
                  Container(
                    width: double.infinity,
                    height: 200,
                    alignment: Alignment.center,
                    child: Container(
                      width: double.infinity,
                      child: Image.network(
                        driver.mapImagePreview,
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
                    onPressed: _saveDriver,
                    color: Colors.purple,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              driverId != null ? 'Update' : 'Save',
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
