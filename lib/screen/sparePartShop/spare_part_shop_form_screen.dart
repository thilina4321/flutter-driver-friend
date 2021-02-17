import 'dart:io';

import 'package:driver_friend/model/spare_shop.dart';
import 'package:driver_friend/provider/spare_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/sparePartShop/Spare_part_shop_profile_screen.dart';
import 'package:driver_friend/widget/pick_image.dart';
import 'package:driver_friend/widget/static_map_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;

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
  var me;

  Future<void> getLocation() async {
    try {
      final locData = await Location().getLocation();
      sparePartShop.latitude = locData.latitude;
      sparePartShop.longitude = locData.longitude;

      List<geoCoding.Placemark> placemarks =
          await geoCoding.placemarkFromCoordinates(
              sparePartShop.latitude, sparePartShop.longitude);
      print(placemarks[0].name);
      sparePartShop.city = placemarks[0].name;

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

  Future<void> _saveSpareShop() async {
    _form.currentState.save();
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }

    sparePartShop.id = me['_id'];
    print(sparePartShop.id);

    await Provider.of<SpareShopProvider>(context, listen: false)
        .createSpareShop(sparePartShop);
    Navigator.of(context)
        .pushReplacementNamed(SparePartShopProfileScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    SparePartShop editablrSpareShop =
        Provider.of<SpareShopProvider>(context, listen: false).spareShop;

    if (editablrSpareShop != null) {
      sparePartShop = editablrSpareShop;
    }

    me = Provider.of<UserProvider>(context, listen: false).me;
    print(me['_id']);

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
                  onSaved: (value) {
                    sparePartShop.address = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Address is required';
                    }

                    return null;
                  },
                  initialValue: sparePartShop.address,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Address',
                  ),
                ),
                TextFormField(
                  onSaved: (value) {
                    sparePartShop.mobile = int.parse(value);
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Mobile number is required';
                    }

                    if (value.length != 10) {
                      print('10');
                      return 'Invalid mobile number';
                    }

                    return null;
                  },
                  initialValue: sparePartShop.mobile.toString(),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                  ),
                ),
                TextFormField(
                  onSaved: (value) {
                    sparePartShop.about = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'About is required';
                    }

                    return null;
                  },
                  maxLines: null,
                  initialValue: sparePartShop.about,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'About',
                  ),
                ),
                TextFormField(
                  onSaved: (value) {
                    sparePartShop.openingTime = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Opening Time is required';
                    }

                    return null;
                  },
                  initialValue: sparePartShop.openingTime,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Opening time',
                  ),
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  initialValue: sparePartShop.closingTime,
                  onSaved: (value) {
                    sparePartShop.closingTime = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Closing Time is required';
                    }

                    return null;
                  },
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
