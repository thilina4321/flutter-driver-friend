import 'package:driver_friend/model/spare_shop.dart';
import 'package:driver_friend/provider/spare_provider.dart';
import 'package:driver_friend/widget/driver_drawer.dart';
import 'package:driver_friend/widget/spare_part_shop_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SparePartShopSettignScreen extends StatefulWidget {
  static String routeName = 'spare-setting';

  @override
  _SparePartShopSettignScreenState createState() =>
      _SparePartShopSettignScreenState();
}

class _SparePartShopSettignScreenState
    extends State<SparePartShopSettignScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    SparePartShop user =
        Provider.of<SpareShopProvider>(context, listen: false).spareShop;

    return Scaffold(
      appBar: AppBar(
        title: Text('Spare Shop Settings Page'),
      ),
      drawer: SparePartShopDrawer(),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Welcome To Settings And Account Details Page Of The Application',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Advanced Setting',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Delete My Account from the application',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          FlatButton(
            onPressed: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25)),
                  ),
                  context: context,
                  builder: (ctx) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            child: Text(
                              'Do you really want to delete your accounts',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Please consider following things before deleting the account',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'If you delete the account all the data of you deleted imedietly'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'You can not recover this account again'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Are you really want to delete the account',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: FlatButton(
                                    onPressed: () async {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      try {
                                        await Provider.of<SpareShopProvider>(
                                                context,
                                                listen: false)
                                            .deleteShop(user.id, user.userId);
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Navigator.of(context)
                                            .pushReplacementNamed('/');
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
                                                  ),
                                                ),
                                              );
                                            });
                                      }
                                    },
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: Text(
              'Delete',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
