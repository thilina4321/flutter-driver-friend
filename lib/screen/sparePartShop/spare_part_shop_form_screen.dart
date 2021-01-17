import 'dart:io';

import 'package:driver_friend/model/spare_shop.dart';
import 'package:driver_friend/provider/spare_provider.dart';
import 'package:driver_friend/screen/sparePartShop/Spare_part_shop_profile_screen.dart';
import 'package:driver_friend/widget/static_map_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class SparePartShopFormScreen extends StatefulWidget {
  static String routeName = '/spare_part_shop-form';

  @override
  _SparePartShopFormScreenState createState() =>
      _SparePartShopFormScreenState();
}

class _SparePartShopFormScreenState extends State<SparePartShopFormScreen> {
  final _form = GlobalKey<FormState>();

  SparePartShop sparePartShop = SparePartShop();

  Future<void> getLocation() async {
    try {
      final locData = await Location().getLocation();
      sparePartShop.latitude = locData.latitude;
      sparePartShop.longitude = locData.longitude;

      final img = LocationHelper.generateGoogleImage(
          lat: locData.latitude, long: locData.longitude);
      setState(() {
        sparePartShop.mapImagePreview = img;
      });
    } catch (e) {
      print('error');
    }
  }

  final picker = ImagePicker();
  SparePartShop spareShop = SparePartShop();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        sparePartShop.profileImageUrl = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _saveSpareShop() {
    _form.currentState.save();
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    Provider.of<SpareShopProvider>(context, listen: false)
        .createMechanic(spareShop);
    Navigator.of(context)
        .pushReplacementNamed(SparePartShopProfileScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    SparePartShop editablrSpareShop =
        Provider.of<SpareShopProvider>(context, listen: false).spare;

    if (editablrSpareShop != null) {
      sparePartShop = editablrSpareShop;
    }

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
                  initialValue: sparePartShop.address,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Address',
                  ),
                ),
                TextFormField(
                  initialValue: sparePartShop.mobile.toString(),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                  ),
                ),
                TextFormField(
                  initialValue: sparePartShop.about,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'About',
                  ),
                ),
                TextFormField(
                  initialValue: sparePartShop.openingTime,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Opening time',
                  ),
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  initialValue: sparePartShop.closingTime,
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
                        child: sparePartShop.profileImageUrl == null
                            ? Text('Profile Image')
                            : Container(
                                width: double.infinity,
                                child: Image.file(
                                  sparePartShop.profileImageUrl,
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
                        child: sparePartShop.mapImagePreview == null
                            ? Center(child: Text('Location'))
                            : Image.network(sparePartShop.mapImagePreview),
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
                    onPressed: _saveSpareShop,
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
