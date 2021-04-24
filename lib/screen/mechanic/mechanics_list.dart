import 'package:driver_friend/helper/error-helper.dart';
import 'package:driver_friend/helper/search-helper.dart';
import 'package:driver_friend/model/mechanic_model.dart';
import 'package:driver_friend/provider/driver_provider.dart';
import 'package:driver_friend/provider/mechanic_provider.dart';
import 'package:driver_friend/screen/mechanic/Mechanic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class MechanicListScreen extends StatefulWidget {
  static String routeName = 'mechanic-list';

  @override
  _MechanicListScreenState createState() => _MechanicListScreenState();
}

class _MechanicListScreenState extends State<MechanicListScreen> {
  final _form = GlobalKey<FormState>();
  List<Mechanic> mechanics;

  String place;

  filterMechanics(context) {
    _form.currentState.save();
    Provider.of<MechanicProvider>(context, listen: false).nearMechanics(place);
  }

  var select1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mechanics'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () async {
          try {
            place = await SearchHelper.userSearch(context);
          } catch (e) {
            ErrorDialog.errorDialog(context, 'Something went wrong');
          }
        },
        child: Icon(Icons.search),
      ),
      body: FutureBuilder(
        future:
            Provider.of<DriverProvider>(context, listen: false).nearMechanic(),
        builder: (ctx, data) {
          if (data.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (data.error != null) {
            if (data.error.toString().contains('404')) {
              return Center(child: Text('Sorry no mechanics found'));
            }
            return Center(child: Text("An error occured, try againg later"));
          }
          return Consumer<DriverProvider>(builder: (ctx, mec, child) {
            if (place == null) {
              mechanics = mec.nearMechanics;
            } else {
              select1 = mec.findMechanicsByPlace(place);
              mechanics = select1;
            }

            return mechanics.length == 0
                ? Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('No mechanics found'),
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                place = null;
                              });
                            },
                            child: Icon(
                              Icons.refresh,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: mechanics.length,
                    itemBuilder: (ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              MechanicProfileScreen.routeName,
                              arguments: mechanics[index].userId);
                        },
                        child: Card(
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage('assets/images/ser_cover.PNG'),
                              ),
                              title: Text(mechanics[index].name.toString()),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RatingBarIndicator(
                                    rating: mechanics[index].rating == 0.0
                                        ? 0.0
                                        : mechanics[index].rating / 5,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.green,
                                    ),
                                    itemCount: 1,
                                    itemSize: 20.0,
                                    direction: Axis.horizontal,
                                  ),
                                  Text(mechanics[index].rating.toString())
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
          });
        },
      ),
    );
  }
}
