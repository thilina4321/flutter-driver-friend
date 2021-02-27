import 'package:driver_friend/helper/error-helper.dart';
import 'package:driver_friend/helper/success-dialog.dart';
import 'package:driver_friend/provider/driver_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBottomSheet {
  static bool isLoading = false;
  static _appointment(context) async {
    print(pickedDate.toString());
    print(pickedTime.format(context));
    isLoading = true;
    // try {
    //   await Provider.of<DriverProvider>(context, listen: false)
    //       .makeAppointment();
    //   SuccessDialog.successDialog(context, 'Successfuly make an appointment');
    // isLoading = false;
    // } catch (e) {
    // isLoading = false;
    //   ErrorDialog.errorDialog(context, e.toString());
    // }
  }

  static DateTime pickedDate;
  static TimeOfDay pickedTime;

  static Future bottomSheet(BuildContext context, String name) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Appointment',
                  style: TextStyle(fontSize: 25, color: Colors.purple),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(name),
                FlatButton(
                  onPressed: () {
                    return showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        Duration(days: 7),
                      ),
                    ).then((date) => {pickedDate = date});
                  },
                  child: Text('Select Date'),
                ),
                FlatButton(
                  onPressed: () {
                    return showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: 00, minute: 00),
                    ).then((time) => {pickedTime = time});
                  },
                  child: Text('Select Time'),
                ),
                RaisedButton(
                  color: Colors.purple,
                  onPressed: () => _appointment(context),
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Text(
                          'Make the Appointment',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                ),
              ],
            ),
          );
        });
  }
}
