import 'package:driver_friend/model/spare_shop.dart';
import 'package:driver_friend/provider/driver_provider.dart';
import 'package:driver_friend/provider/service_provider.dart';
import 'package:driver_friend/provider/spare_provider.dart';
import 'package:driver_friend/screen/sparePartShop/Spare_part_shop_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class SparepartShopListScreen extends StatelessWidget {
  static String routeName = 'spare-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearest Spare part shops'),
      ),
      body: FutureBuilder(
        future: Provider.of<DriverProvider>(context, listen: false).nearSpare(),
        builder: (ctx, data) {
          if (data.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (data.error != null) {
            if (data.error.toString().contains('404')) {
              return Center(child: Text('Sorry no spare part shops found'));
            }
            return Center(child: Text("An error occured, try againg later"));
          }
          return Consumer<DriverProvider>(builder: (ctx, spare, child) {
            List<SparePartShop> spareShops = spare.nearSpares;
            return ListView.builder(
                itemCount: spareShops.length,
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          SparePartShopProfileScreen.routeName,
                          arguments: spareShops[index]);
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
                          title: Text(spareShops[index].name),
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
                              Text(spareShops[index].rating.toString())
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
