import 'package:driver_friend/model/service_center.dart';
import 'package:driver_friend/provider/service_provider.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ServiceCenterList extends StatelessWidget {
  static String routeName = 'service-list';

  @override
  Widget build(BuildContext context) {
    final List<ServiceCenter> serviceCenters =
        Provider.of<ServiceCenterProvider>(context, listen: false)
            .serviceCenters;
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearest Service Center'),
      ),
      body: ListView.builder(
          itemCount: serviceCenters.length,
          itemBuilder: (ctx, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                    ServiceCenterProfileScreen.routeName,
                    arguments: serviceCenters[index]);
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
                    title: Text(serviceCenters[index].name),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBarIndicator(
                          rating: serviceCenters[index].rating / 6,
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
          }),
    );
  }
}
