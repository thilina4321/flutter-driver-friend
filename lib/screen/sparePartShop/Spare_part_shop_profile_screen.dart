import 'dart:io';

import 'package:driver_friend/model/spare_shop.dart';
import 'package:driver_friend/model/userType.dart';
import 'package:driver_friend/provider/spare_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/map/map_screen.dart';

import 'package:driver_friend/screen/serviceCenter/service_center_form.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_services.dart';
import 'package:driver_friend/screen/serviceCenter/service_contact.dart';
import 'package:driver_friend/screen/sparePartShop/spare_contact.dart';
import 'package:driver_friend/screen/sparePartShop/spare_part_shop_form_screen.dart';
import 'package:driver_friend/screen/sparePartShop/spare_shop_items.dart';
import 'package:driver_friend/widget/driver_drawer.dart';
import 'package:driver_friend/widget/spare_part_shop_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SparePartShopProfileScreen extends StatefulWidget {
  static String routeName = '/spare_part_shop-profile';

  @override
  _SparePartShopProfileScreenState createState() =>
      _SparePartShopProfileScreenState();
}

class _SparePartShopProfileScreenState
    extends State<SparePartShopProfileScreen> {
  SparePartShop spareShops = SparePartShop();

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final UserType user =
        Provider.of<UserProvider>(context, listen: false).user;
    if (user == UserType.driver) {
      spareShops = ModalRoute.of(context).settings.arguments;
    } else {
      spareShops = Provider.of<SpareShopProvider>(context, listen: false).spare;
    }
    print(spareShops.mobile);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      drawer: user == UserType.driver ? DriverDrawer() : SparePartShopDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  child: spareShops.profileImageUrl == null
                      ? Center(child: Text('Spare shop'))
                      : Image.file(
                          spareShops.profileImageUrl,
                          fit: BoxFit.cover,
                        ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                spareShops.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBarIndicator(
                  rating: 4,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.green,
                  ),
                  unratedColor: Colors.black54,
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
                Text('4'),
              ],
            ),
            if (user == UserType.sparePartShop)
              Container(
                margin: const EdgeInsets.all(3),
                child: Card(
                  elevation: 3,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Row(
                      children: [
                        Text(
                          'Change Details',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(SparePartShopFormScreen.routeName);
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            Row(
              children: [
                Card(
                  elevation: 3,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          SpareShopContactScreen.routeName,
                          arguments: spareShops);
                    },
                    child: const Text(
                      'Contacts',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 3,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(SpareShopItems.routeName);
                    },
                    child: const Text(
                      'Items',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 3,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(MapScreen.routeName);
                    },
                    child: const Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              child: Card(
                elevation: 3,
                child: spareShops.mapImagePreview == null
                    ? Center(child: Text('No Location yet..'))
                    : Container(
                        height: 200,
                        width: double.infinity,
                        child: Image.network(
                          spareShops.mapImagePreview,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
