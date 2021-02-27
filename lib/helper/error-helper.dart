import 'package:flutter/material.dart';

class ErrorDialog {
  static Future errorDialog(BuildContext context, String error) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(error),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ok'),
              ),
            ],
          );
        });
  }
}
