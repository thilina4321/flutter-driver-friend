import 'package:driver_friend/helper/error-helper.dart';
import 'package:driver_friend/model/drivert.dart';
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
  double initialValue = 0;
  bool isLoading = false;
  var myRate;

  Future<void> _saveRating() async {
    final isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }

    _form.currentState.save();
    setState(() {
      isLoading = true;
    });
    try {
      if (modalRouteData['type'] == 'mechanic') {
        await Provider.of<MechanicProvider>(context, listen: false)
            .serviceRating(initialValue, modalRouteData['id'],
                modalRouteData['driverId'], myRate);
      } else if (modalRouteData['type'] == 'service') {
        await Provider.of<ServiceCenterProvider>(context, listen: false)
            .serviceRating(initialValue, modalRouteData['id'],
                modalRouteData['driverId'], myRate);
      } else if (modalRouteData['type'] == 'spare') {
        await Provider.of<SpareShopProvider>(context, listen: false)
            .serviceRating(initialValue, modalRouteData['id'],
                modalRouteData['driverId'], myRate);
      }

      Navigator.of(context).pop(true);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ErrorDialog.errorDialog(context, 'Sorry something went wrong');
    }
  }

  Map modalRouteData;

  @override
  Widget build(BuildContext context) {
    modalRouteData = ModalRoute.of(context).settings.arguments as Map;

    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          future: Provider.of<DriverProvider>(context, listen: false)
              .findMyRatings(modalRouteData['type'], modalRouteData['id'],
                  modalRouteData['driverId']),
          builder: (context, rate) {
            if (rate.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (rate.error != null) {
              return Text('Sorry something went wrong');
            }
            return isLoading
                ? Center(child: CircularProgressIndicator())
                : Consumer<DriverProvider>(builder: (context, rate, child) {
                    myRate = rate.rating;
                    return Container(
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
                              rating: modalRouteData['ratings'] == null
                                  ? 0
                                  : double.parse(
                                      modalRouteData['ratings'].toString()),
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.green,
                              ),
                              itemCount: 5,
                              itemSize: 30.0,
                              direction: Axis.horizontal,
                            ),
                            Text(modalRouteData['ratings'].toString()),
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
                                    initialValue = double.parse(value);
                                    print(initialValue);
                                  },
                                  initialValue: myRate.toString(),
                                  validator: (value) {
                                    if (value == '') {
                                      value = '0';
                                    }
                                    if (double.parse(value) < 1 ||
                                        double.parse(value) > 5) {
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
                    );
                  });
          },
        ));
  }
}
