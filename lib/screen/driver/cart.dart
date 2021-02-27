import 'package:driver_friend/provider/driver_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  static String routeName = 'cart-driver';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmed Cart'),
      ),
      body: FutureBuilder(
          future:
              Provider.of<DriverProvider>(context, listen: false).fetchCart(),
          builder: (context, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (data.error != null) {
              if (data.error.toString().contains('404')) {
                return Text('No appointments found yet');
              }
              return Text('Something went wrong');
            }

            return Consumer<DriverProvider>(builder: (context, data, child) {
              var cart = data.cart;
              return ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        children: [Text('Name')],
                      ),
                    );
                  });
            });
          }),
    );
  }
}
