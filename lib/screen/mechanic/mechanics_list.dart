import 'package:driver_friend/provider/mechanic_provider.dart';
import 'package:driver_friend/screen/mechanic/Mechanic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class MechanicListScreen extends StatelessWidget {
  static String routeName = 'mechanic-list';

  @override
  Widget build(BuildContext context) {
    final mechanics =
        Provider.of<MechanicProvider>(context, listen: false).mechanics;
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearest Mechanics'),
      ),
      body: ListView.builder(
          itemCount: mechanics.length,
          itemBuilder: (ctx, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(MechanicProfileScreen.routeName,
                    arguments: mechanics[index]);
              },
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/mec_pro.jpg'),
                    ),
                    title: Text(mechanics[index].name),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBarIndicator(
                          rating: mechanics[index].rating / 5,
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
          }),
    );
  }
}