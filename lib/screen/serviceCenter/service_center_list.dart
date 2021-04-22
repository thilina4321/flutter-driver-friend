import 'package:driver_friend/helper/error-helper.dart';
import 'package:driver_friend/helper/search-helper.dart';
import 'package:driver_friend/model/service_center.dart';
import 'package:driver_friend/provider/driver_provider.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ServiceCenterList extends StatefulWidget {
  static String routeName = 'service-list';

  @override
  _ServiceCenterListState createState() => _ServiceCenterListState();
}

class _ServiceCenterListState extends State<ServiceCenterList> {
  var place;

  var select1;
  List<ServiceCenter> serviceCenters;
  var select2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Centers'),
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
            Provider.of<DriverProvider>(context, listen: false).nearService(),
        builder: (ctx, data) {
          if (data.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (data.error != null) {
            if (data.error.toString().contains('404')) {
              return Center(child: Text('Sorry no service centers found'));
            }
            return Center(child: Text("An error occured, try againg later"));
          }
          return Consumer<DriverProvider>(builder: (ctx, ser, child) {
            //
            if (place == null) {
              serviceCenters = ser.nearServices;
            } else {
              select1 = ser.findMechanicsByPlace(place);
              select2 = select1;
              serviceCenters = select1;
            }

            return serviceCenters.length == 0
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
                    itemCount: serviceCenters.length,
                    itemBuilder: (ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              ServiceCenterProfileScreen.routeName,
                              arguments: serviceCenters[index].userId);
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
                              title:
                                  Text(serviceCenters[index].name.toString()),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RatingBarIndicator(
                                    rating: serviceCenters[index].rating == 0.0
                                        ? 0.0
                                        : serviceCenters[index].rating / 5,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.green,
                                    ),
                                    itemCount: 1,
                                    itemSize: 20.0,
                                    direction: Axis.horizontal,
                                  ),
                                  Text(serviceCenters[index].rating.toString())
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
