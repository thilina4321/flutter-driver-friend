import 'package:driver_friend/model/spare_shop.dart';
import 'package:driver_friend/provider/spare_provider.dart';
import 'package:driver_friend/screen/sparePartShop/Spare_part_shop_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class SparepartShopListScreen extends StatelessWidget {
  static String routeName = 'spare-list';

  @override
  Widget build(BuildContext context) {
    final List<SparePartShop> spareShops =
        Provider.of<SpareShopProvider>(context, listen: false).spareShops;
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearest Spare part shops'),
      ),
      body: ListView.builder(
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
          }),
    );
  }
}
