import 'package:driver_friend/helper/error-helper.dart';
import 'package:driver_friend/model/drivert.dart';
import 'package:driver_friend/model/spare_shop.dart';
import 'package:driver_friend/model/userType.dart';
import 'package:driver_friend/provider/driver_provider.dart';
import 'package:driver_friend/provider/spare_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/map/map_screen.dart';

import 'package:driver_friend/screen/sparePartShop/spare_contact.dart';
import 'package:driver_friend/screen/sparePartShop/spare_part_shop_form_screen.dart';
import 'package:driver_friend/screen/sparePartShop/spare_shop_items.dart';
import 'package:driver_friend/widget/driver_drawer.dart';
import 'package:driver_friend/widget/pick_image.dart';
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
  bool profileLoad = false;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      await Provider.of<SpareShopProvider>(context, listen: false)
          .addProfilePicture(pickedFile, me['id']);
    } else {
      print('No image selected.');
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    me = Provider.of<UserProvider>(context, listen: false).me;
    var id = ModalRoute.of(context).settings.arguments;
    print(me['id']);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
        ),
        drawer: me['role'] != 'sparePartShop'
            ? DriverDrawer()
            : SparePartShopDrawer(),
        body: FutureBuilder(
            future: me['role'] != 'sparePartShop'
                ? Provider.of<SpareShopProvider>(context, listen: false)
                    .fetchSpareShop(id)
                : Provider.of<SpareShopProvider>(context, listen: false)
                    .fetchSpareShop(me['id']),
            builder: (ctx, data) {
              if (data.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (data.error != null) {
                return Container(
                  margin: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.jpg',
                        fit: BoxFit.cover,
                      ),
                      Text(
                        'Welcome to Driver Friend App ' + me['userName'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RaisedButton(
                        padding: const EdgeInsets.all(15),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(SparePartShopFormScreen.routeName);
                        },
                        color: Colors.purple,
                        child: Text(
                          'Create Profile',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Consumer<SpareShopProvider>(builder: (ctx, spare, child) {
                if (me['role'] == 'sparePartShop') {
                  spareShop = spare.spareShop;
                  spareShop.name = me['userName'];
                }

                spareShop = spare.spareShop;
                print(spareShop.userId);

                Future getImage() async {
                  var pickedFile;

                  try {
                    pickedFile =
                        await PickImageFromGalleryOrCamera.getProfileImage(
                            context, picker);
                    if (pickedFile != null) {
                      setState(() {
                        profileLoad = true;
                      });
                      await Provider.of<SpareShopProvider>(context,
                              listen: false)
                          .addProfilePicture(pickedFile, me['id']);
                    } else {
                      print('No image selected.');
                    }
                    setState(() {
                      profileLoad = false;
                    });
                  } catch (e) {
                    setState(() {
                      profileLoad = false;
                    });
                    ErrorDialog.errorDialog(context, e.toString());
                  }
                }

                return SingleChildScrollView(
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
                                : Image.network(
                                    spareShop.profileImageUrl,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          if (me['role'] == 'sparePartShop')
                            Positioned(
                              top: 20,
                              left: 20,
                              child: Container(
                                color: Colors.black45,
                                child: FlatButton.icon(
                                  onPressed: getImage,
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                  label: profileLoad
                                      ? CircularProgressIndicator(
                                          backgroundColor: Colors.white)
                                      : Text(
                                          'Edit photo',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        color: Colors.black45,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                spareShop.name.toString(),
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
                                  rating: spareShop.rating,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.green,
                                  ),
                                  unratedColor: Colors.black54,
                                  itemCount: 5,
                                  itemSize: 20.0,
                                  direction: Axis.horizontal,
                                ),
                                Text(spareShop.rating.toString()),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (me['role'] == 'sparePartShop')
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
                                      Navigator.of(context).pushNamed(
                                          SparePartShopFormScreen.routeName);
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
                                  Navigator.of(context).pushNamed(
                                      SpareShopItems.routeName,
                                      arguments: spareShop.userId);
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
                                  Navigator.of(context)
                                      .pushNamed(MapScreen.routeName);
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
                            if (me['role'] != 'sparePartShop')
                              Card(
                                elevation: 3,
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        CustomRatingWidget.routeName,
                                        arguments: {
                                          'driverId': me['id'],
                                          'id': spareShop.id,
                                          'ratings': spareShop.rating,
                                          'type': 'spare'
                                        });
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
                      SizedBox(
                        height: 20,
                      ),
                      if (spareShop.latitude != null ||
                          spareShop.longitude != null)
                        Container(
                          height: 200,
                          child: Card(
                            elevation: 3,
                            child: Image.network(
                              LocationHelper.generateGoogleImage(
                                  lat: spareShop.latitude,
                                  long: spareShop.longitude),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              });
            }));
  }
}
