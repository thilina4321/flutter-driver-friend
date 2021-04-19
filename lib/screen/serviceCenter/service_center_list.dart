import 'package:driver_friend/model/service_center.dart';
import 'package:driver_friend/provider/driver_provider.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ServiceCenterList extends StatelessWidget {
  static String routeName = 'service-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Centers'),
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
            List<ServiceCenter> serviceCenters = ser.nearServices;
            print(serviceCenters[0].userId);
            return serviceCenters.length == 0
                ? Center(
                    child: Container(
                    child: Text('No Service centers found'),
                  ))
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
                              title: Text('Name'),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RatingBarIndicator(
                                    rating: 2,
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
