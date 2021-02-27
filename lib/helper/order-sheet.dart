import 'package:driver_friend/helper/error-helper.dart';
import 'package:driver_friend/provider/driver_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderSheet {
  static bool isLoading = false;

  static _makeOrder(context, shopId, name, price) async {
    var data = {'shopId': shopId, 'name': name, 'price': price};
    isLoading = true;

    try {
      await Provider.of<DriverProvider>(context, listen: false).makeAnOrder();
      isLoading = false;
    } catch (e) {
      ErrorDialog.errorDialog(context, 'Unable to make an order now');
      isLoading = false;
    }
  }

  static ordersheet(
      BuildContext context, String shopId, String itemName, double price) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Do you really need to order this item',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 30,
                  ),
                ),
                Text('name'),
                Text('price'),
                RaisedButton(
                    onPressed: () =>
                        _makeOrder(context, shopId, itemName, price),
                    color: Colors.purple,
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            'Order',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ))
              ],
            ),
          );
        });
  }
}
