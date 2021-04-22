import 'package:driver_friend/model/spare_shop.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SpareShopContactScreen extends StatefulWidget {
  static String routeName = 'spare-contact';
  @override
  _SpareShopContactScreenState createState() => _SpareShopContactScreenState();
}

class _SpareShopContactScreenState extends State<SpareShopContactScreen> {
  SparePartShop spareShop = SparePartShop();

  _makingPhoneCall() async {
    final url = 'tel:${spareShop.mobile}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    spareShop = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Contact ${spareShop.name}'),
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
                  '${spareShop.name} is a spare part shop in Driver Friend Application',
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
                    'Our brand name is ${spareShop.name}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'We are ${spareShop.rating} start rated spare part shop in Driver Friend App',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Our company address is ${spareShop.address}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'You can contact me from this Number ${spareShop.mobile}',
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
