import 'package:driver_friend/model/spare_shop.dart';
import 'package:driver_friend/model/userType.dart';
import 'package:driver_friend/provider/spare_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/map/map_screen.dart';

import 'package:driver_friend/screen/sparePartShop/spare_contact.dart';
import 'package:driver_friend/screen/sparePartShop/spare_part_shop_form_screen.dart';
import 'package:driver_friend/screen/sparePartShop/spare_shop_items.dart';
import 'package:driver_friend/widget/driver_drawer.dart';
import 'package:driver_friend/widget/rating.dart';
import 'package:driver_friend/widget/spare_part_shop_drawer.dart';
import 'package:driver_friend/widget/static_map_image.dart';
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
  SparePartShop spareShop = SparePartShop();

  final picker = ImagePicker();
  var me;

  @override
  Widget build(BuildContext context) {
    final UserType user =
        Provider.of<UserProvider>(context, listen: false).user;
    if (user == UserType.driver) {
      spareShop = ModalRoute.of(context).settings.arguments;
    } else {
      spareShop =
          Provider.of<SpareShopProvider>(context, listen: false).spareShop;
    }
    // print(spareShops.mobile);

    me = Provider.of<UserProvider>(context, listen: false).me;

    if (Provider.of<SpareShopProvider>(context, listen: false).spareShop !=
        null) {
      print('object');
      spareShop =
          Provider.of<SpareShopProvider>(context, listen: false).spareShop;
    } else {
      spareShop = SparePartShop(id: me['_id'], name: me['userName']);
    }

    spareShop.id = me['_id'];
    spareShop.name = me['userName'];

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
                  child: spareShop.profileImageUrl == null
                      ? Container(
                          color: Colors.black,
                        )
                      : Image.file(
                          spareShop.profileImageUrl,
                          fit: BoxFit.cover,
                        ),
                ),
                // Image.asset(
                //   'assets/images/spare.jpg',
                //   fit: BoxFit.cover,
                // ),

                if (user == UserType.sparePartShop)
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Container(
                      color: Colors.black45,
                      child: FlatButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Edit photo',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                spareShop.name,
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
            // if (user == UserType.sparePartShop)
            Container(
              margin: const EdgeInsets.all(3),
              child: Card(
                elevation: 3,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
            Container(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Card(
                    elevation: 3,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            SpareShopContactScreen.routeName,
                            arguments: spareShop);
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
                        Navigator.of(context)
                            .pushNamed(SpareShopItems.routeName);
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
                  Card(
                    elevation: 3,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            CustomRatingWidget.routeName,
                            arguments: spareShop.rating);
                      },
                      child: const Text(
                        'Rate us',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (spareShop.latitude == null)
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                      SparePartShopFormScreen.routeName,
                      arguments: spareShop.id);
                },
                color: Colors.purple,
                child: Text(
                  'Create profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            SizedBox(
              height: 20,
            ),
            if (spareShop.latitude != null)
              Container(
                height: 200,
                child: Card(
                  elevation: 3,
                  child: Image.network(
                    LocationHelper.generateGoogleImage(
                        lat: 37.42796133580664, long: -122.085749655962),
                    // fit: BoxFit.cover,
                  ),

                  // spareShops.mapImagePreview == null
                  //     ? Center(child: Text('No Location yet..'))
                  //     : Container(
                  //         height: 200,
                  //         width: double.infinity,
                  //         child: Image.network(
                  //           spareShops.mapImagePreview,
                  //           fit: BoxFit.cover,
                  //         ),
                  //       ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
