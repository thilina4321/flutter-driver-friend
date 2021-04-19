import 'package:driver_friend/model/service_center.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceCenterContactScreen extends StatefulWidget {
  static String routeName = 'service-contact';
  @override
  _ServiceCenterContactScreenState createState() =>
      _ServiceCenterContactScreenState();
}

class _ServiceCenterContactScreenState
    extends State<ServiceCenterContactScreen> {
  ServiceCenter serviceCenter = ServiceCenter();

  _makingPhoneCall() async {
    final url = 'tel:${serviceCenter.mobile}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    serviceCenter = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Contact ${serviceCenter.name}'),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${serviceCenter.name} is a serviceCenter in Driver Friend Application',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                const Text(
                  'Welcome To My Profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.purple,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'I am ${serviceCenter.name}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'My address is ${serviceCenter.address}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'You can contact me from this Number ${serviceCenter.mobile}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Spacer(),
                    Card(
                      elevation: 5,
                      child: FlatButton(
                        onPressed: _makingPhoneCall,
                        child: Text(
                          'Call',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
