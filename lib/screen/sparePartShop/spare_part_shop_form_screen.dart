import 'dart:io';

import 'package:driver_friend/screen/sparePartShop/Spare_part_shop_profile_screen.dart';
import 'package:driver_friend/widget/static_map_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class SparePartShopFormScreen extends StatefulWidget {
  static String routeName = '/spare_part_shop-form';

  @override
  _SparePartShopFormScreenState createState() =>
      _SparePartShopFormScreenState();
}

class _SparePartShopFormScreenState extends State<SparePartShopFormScreen> {
  final _form = GlobalKey<FormState>();

  File _profileImage;
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
        title: Text('Spare part shop Details'),
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
                    labelText: 'Shop Name',
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
                  decoration: InputDecoration(
                    labelText: 'About',
                  ),
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Opening time',
                  ),
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'closing time',
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
                          label: Text('Profile Image')),
                    ),
                    Expanded(
                      child: FlatButton.icon(
                        onPressed: getLocation,
                        icon: Icon(
                          Icons.photo_camera,
                          color: Colors.purple,
                        ),
                        label: Text('Location'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 150,
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
                        height: 150,
                        child: _mapImagePreview == null
                            ? Center(child: Text('Location'))
                            : Image.network(_mapImagePreview),
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
                          SparePartShopProfileScreen.routeName);
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
