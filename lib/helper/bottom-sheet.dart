import 'package:driver_friend/helper/error-helper.dart';
import 'package:driver_friend/helper/success-dialog.dart';
import 'package:driver_friend/provider/driver_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin CustomBottomSheet {
  static Future bottomSheet(BuildContext context, String name) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return MybottomSheet(name);
        });
  }
}

class MybottomSheet extends StatefulWidget {
  final String name;
  const MybottomSheet(this.name);

  @override
  _MybottomSheetState createState() => _MybottomSheetState();
}

class _MybottomSheetState extends State<MybottomSheet> {
  var pickedDate;
  var pickedTime;
  bool isLoading = false;

  pickDateMethod(date) {
    setState(() {
      pickedDate = date.year.toString() +
          '-' +
          date.month.toString() +
          '-' +
          date.day.toString();
    });
  }

  pickTimeMethod(time) {
    var timePhrase = int.parse(time.hour.toString()) < 12 ? ' am' : ' pm';
    setState(() {
      pickedTime =
          time.hour.toString() + ' : ' + time.minute.toString() + timePhrase;
    });
  }

  _appointment(context) async {
    // isLoading = true;
    // try {
    //   await Provider.of<DriverProvider>(context, listen: false)
    //       .makeAppointment();
    //   SuccessDialog.successDialog(context, 'Successfuly make an appointment');
    //   isLoading = false;
    // } catch (e) {
    //   isLoading = false;
    //   ErrorDialog.errorDialog(context, e.toString());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Appointment',
            style: TextStyle(fontSize: 25, color: Colors.purple),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            'Welcome ' + widget.name,
            style: TextStyle(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (pickedDate != null) Text(pickedDate),
              FlatButton.icon(
                icon: Icon(Icons.date_range),
                label: pickedDate != null
                    ? Text('Change Date')
                    : Text('Select Date'),
                hoverColor: Colors.green,
                onPressed: () {
                  return showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(
                      Duration(days: 7),
                    ),
                  ).then((date) => {pickDateMethod(date)});
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (pickedTime != null) Text(pickedTime.toString()),
              FlatButton.icon(
                icon: Icon(Icons.timer_outlined),
                onPressed: () {
                  return showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(hour: 00, minute: 00),
                  ).then((time) => {pickTimeMethod(time)});
                },
                label: pickedTime != null
                    ? Text('Change Time')
                    : Text('Select Time'),
              ),
            ],
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
  }
}
