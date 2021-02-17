import 'package:driver_friend/model/mechanic_model.dart';
import 'package:driver_friend/provider/driver_provider.dart';
import 'package:driver_friend/provider/mechanic_provider.dart';
import 'package:driver_friend/screen/mechanic/Mechanic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class MechanicListScreen extends StatelessWidget {
  static String routeName = 'mechanic-list';
  final _form = GlobalKey<FormState>();
  String place;

  filterMechanics(context) {
    _form.currentState.save();
    Provider.of<MechanicProvider>(context, listen: false).nearMechanics(place);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            onPressed: () => filterMechanics(context),
            child: Icon(Icons.search),
          ),
        ],
        leading: Form(
          key: _form,
          child: TextFormField(
            onSaved: (val) {
              place = val;
            },
          ),
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<MechanicProvider>(context, listen: false)
            .fetchMechanics(),
        builder: (ctx, data) {
          if (data.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (data.error != null) {
            if (data.error.toString().contains('404')) {
              return Center(child: Text('Sorry no mechanics found'));
            }
            return Center(child: Text("An error occured, try againg later"));
          }
          return Consumer<MechanicProvider>(builder: (ctx, mec, child) {
            List<Mechanic> mechanics = mec.mechanics;
            return ListView.builder(
                itemCount: mechanics.length,
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          MechanicProfileScreen.routeName,
                          arguments: mechanics[index]);
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
                          title: Text(mechanics[index].name),
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
