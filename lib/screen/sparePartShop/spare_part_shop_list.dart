import 'package:driver_friend/helper/error-helper.dart';
import 'package:driver_friend/helper/search-helper.dart';
import 'package:driver_friend/model/spare_shop.dart';
import 'package:driver_friend/provider/driver_provider.dart';
import 'package:driver_friend/provider/service_provider.dart';
import 'package:driver_friend/provider/spare_provider.dart';
import 'package:driver_friend/screen/sparePartShop/Spare_part_shop_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class SparepartShopListScreen extends StatefulWidget {
  static String routeName = 'spare-list';

  @override
  _SparepartShopListScreenState createState() =>
      _SparepartShopListScreenState();
}

class _SparepartShopListScreenState extends State<SparepartShopListScreen> {
  var place;

  var select1;

  List<SparePartShop> spareShops;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search shop'),
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
        future: Provider.of<DriverProvider>(context, listen: false).nearSpare(),
        builder: (ctx, data) {
          if (data.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (data.error != null) {
            if (data.error.toString().contains('404')) {
              return Center(child: Text('Sorry no spare part shops found'));
            }
            return Center(child: Text(data.error.toString()));
          }
          return Consumer<DriverProvider>(builder: (ctx, spare, child) {
            if (place == null) {
              spareShops = spare.nearSpares;
            } else {
              select1 = spare.findSpareShopByPlace(place);
              spareShops = select1;
            }
            return spareShops.length == 0
                ? Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('No spare part shop found'),
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
                    itemCount: spareShops.length,
                    itemBuilder: (ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              SparePartShopProfileScreen.routeName,
                              arguments: spareShops[index].userId);
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
                              title: Text(spareShops[index].name.toString()),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RatingBarIndicator(
                                    rating: spareShops[index].rating == 0
                                        ? 0
                                        : spareShops[index].rating / 5,
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
