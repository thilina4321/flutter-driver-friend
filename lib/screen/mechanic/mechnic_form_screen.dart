import 'dart:io';

import 'package:driver_friend/model/mechanic_model.dart';
import 'package:driver_friend/provider/mechanic_provider.dart';
import 'package:driver_friend/screen/mechanic/Mechanic.dart';
import 'package:driver_friend/widget/pick_image.dart';
import 'package:driver_friend/widget/static_map_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;

import 'package:provider/provider.dart';

class MechanicFormScreen extends StatefulWidget {
  static String routeName = '/mechanic-form';

  @override
  _MechanicFormScreenState createState() => _MechanicFormScreenState();
}

class _MechanicFormScreenState extends State<MechanicFormScreen> {
  final _form = GlobalKey<FormState>();
  var id;

  Mechanic mechanic = Mechanic();

  Future<void> _saveMechanic() async {
    _form.currentState.save();
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    mechanic.id = id;
    await Provider.of<MechanicProvider>(context, listen: false)
        .createMechanic(mechanic);
    Navigator.of(context).pushReplacementNamed(MechanicProfileScreen.routeName);
  }

  Future<void> getLocation() async {
    try {
      final locData = await Location().getLocation();
      mechanic.latitude = locData.latitude;
      mechanic.longitude = locData.longitude;

      final img = LocationHelper.generateGoogleImage(
          lat: locData.latitude, long: locData.longitude);

      List<geoCoding.Placemark> placemarks = await geoCoding
          .placemarkFromCoordinates(mechanic.latitude, mechanic.longitude);
      print(placemarks[0].name);
      mechanic.city = placemarks[0].name;

      setState(() {
        mechanic.mapImagePreview = img;
      });
    } catch (e) {
      print('error');
    }
  }

  final picker = ImagePicker();

  Future saveImage(context) async {
    var pickedFile;
    try {
      pickedFile =
          await PickImageFromGalleryOrCamera.getProfileImage(context, picker);
      setState(() {
        if (pickedFile != null) {
          mechanic.profileImageUrl = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Mechanic editableMechanic =
        Provider.of<MechanicProvider>(context, listen: false).mechanic;
    if (editableMechanic != null) {
      mechanic = editableMechanic;
    }
    id = ModalRoute.of(context).settings.arguments;
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
                  onSaved: (value) {
                    mechanic.nic = value;
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
                  textInputAction: TextInputAction.next,
                  initialValue: mechanic.nic,
                  decoration: InputDecoration(
                    labelText: 'NIC',
                  ),
                ),
                TextFormField(
                  onSaved: (value) {
                    mechanic.mobile = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Mobile number is required';
                    }
                    if (value.length != 10) {
                      return 'Invalid Mobile Number';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  initialValue: mechanic.mobile,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                  ),
                ),
                TextFormField(
                  maxLines: null,
                  onSaved: (value) {
                    mechanic.address = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Address is required';
                    }

                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  initialValue: mechanic.address,
                  decoration: InputDecoration(
                    labelText: 'Address',
                  ),
                ),
                TextFormField(
                  onSaved: (value) {
                    mechanic.about = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'About is required';
                    }

                    return null;
                  },
                  maxLines: null,
                  textInputAction: TextInputAction.next,
                  initialValue: mechanic.about,
                  decoration: InputDecoration(
                    labelText: 'About',
                  ),
                ),
                Row(
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
                Row(
                  children: [
                    SizedBox(
                      width: 2,
                    ),
                    Expanded(
                      child: Container(
                        height: 200,
                        child: Center(
                          child: mechanic.mapImagePreview == null
                              ? Text('Your Location')
                              : Container(
                                  width: double.infinity,
                                  child: Image.network(
                                    mechanic.mapImagePreview,
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
                    onPressed: _saveMechanic,
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
