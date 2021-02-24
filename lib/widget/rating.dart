import 'package:driver_friend/provider/driver_provider.dart';
import 'package:driver_friend/provider/mechanic_provider.dart';
import 'package:driver_friend/provider/service_provider.dart';
import 'package:driver_friend/provider/spare_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class CustomRatingWidget extends StatefulWidget {
  static String routeName = 'rating';
  @override
  _CustomRatingWidgetState createState() => _CustomRatingWidgetState();
}

class _CustomRatingWidgetState extends State<CustomRatingWidget> {
  final _form = GlobalKey<FormState>();
  int initialValue = 0;
  double rating;
  String id;
  String role;

  Future<void> _saveRating() async {
    final isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }

    _form.currentState.save();
    try {
      if (role == 'driver') {
        await Provider.of<MechanicProvider>(context, listen: false)
            .mechanicRating(id, rating);
      }
      if (role == 'spare') {
        await Provider.of<SpareShopProvider>(context, listen: false)
            .spareRating(id, rating);
      }
      if (role == 'service') {
        await Provider.of<ServiceCenterProvider>(context, listen: false)
            .serviceRating(id, rating);
      }
      Navigator.of(context).pop();
    } catch (e) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Container(
                child: Text(
                  e.toString(),
                ),
              ),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments as Map;
    rating = data['rating'];
    id = data['id'];

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: 500,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Rate Me',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RatingBarIndicator(
                rating: rating,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.green,
                ),
                itemCount: 5,
                itemSize: 30.0,
                direction: Axis.horizontal,
              ),
              Text(rating.toString()),
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _form,
                  child: TextFormField(
                    onSaved: (value) {
                      if (value == '') {
                        value = '0';
                      }
                      initialValue = int.parse(value);
                    },
                    validator: (value) {
                      if (value == '') {
                        value = '0';
                      }
                      if (double.parse(value) < 1 || double.parse(value) > 5) {
                        return 'Rate should between 1-5';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter Rating',
                      suffixIcon: FlatButton(
                        onPressed: _saveRating,
                        child: Text('Rate'),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
