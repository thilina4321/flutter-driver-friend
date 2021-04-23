import 'package:flutter/material.dart';

class AppointmentStatus {
  static Future<bool> appointmentStatus(context) async {
    bool status;
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              FlatButton(
                  onPressed: () {
                    status = false;
                    Navigator.of(context).pop();
                  },
                  child: Text('Reject')),
              FlatButton(
                  onPressed: () {
                    status = true;
                    Navigator.of(context).pop();
                  },
                  child: Text('Accept')),
            ],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Text('Do you Accept this appointment or Reject it')],
            ),
          );
        });
    return status;
  }
}
