import 'package:flutter/material.dart';

class IsPerformDialog {
  static bool type;
  static Future<bool> performStatus(context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              FlatButton(
                  onPressed: () {
                    type = false;
                    Navigator.of(context).pop();
                  },
                  child: Text('No')),
              FlatButton(
                  onPressed: () {
                    type = true;
                    Navigator.of(context).pop();
                  },
                  child: Text('Yes')),
            ],
            content: Text('Do you want to continue?'),
          );
        });

    return type;
  }
}
