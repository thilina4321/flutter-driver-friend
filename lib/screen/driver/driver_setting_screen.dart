import 'package:driver_friend/model/drivert.dart';
import 'package:driver_friend/provider/driver_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/widget/driver_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DriverSettignScreen extends StatefulWidget {
  static String routeName = 'driver-setting';

  @override
  _DriverSettignScreenState createState() => _DriverSettignScreenState();
}

class _DriverSettignScreenState extends State<DriverSettignScreen> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<DriverProvider>(context, listen: false).driver;
    bool isLoading = false;

    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Settings Page'),
      ),
      drawer: DriverDrawer(),
      body: Column(
        children: [
          if (isLoading) Center(child: CircularProgressIndicator()),
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
                                      try {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        await Provider.of<DriverProvider>(
                                                context,
                                                listen: false)
                                            .deleteDriver(user.id, user.userId);
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
                                                content: Text(
                                                  e.toString(),
                                                ),
                                                actions: [
                                                  FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('Ok'),
                                                  ),
                                                ],
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
