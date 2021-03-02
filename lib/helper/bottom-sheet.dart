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
  DateTime pickedDate;
  TimeOfDay pickedTime;
  bool isLoading = false;

  pickDateMethod(date) {
    setState(() {
      pickedDate = date;
    });
  }

  pickTimeMethod(time) {
    setState(() {
      pickedTime = time;
    });
  }

  _appointment(context) async {
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
          Text(widget.name),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (pickedDate != null)
                Text(pickedDate.year.toString() +
                    '/' +
                    pickedDate.month.toString() +
                    '/' +
                    pickedDate.day.toString()),
              FlatButton(
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
                child: pickedDate != null
                    ? Text('Change Date')
                    : Text('Select Date'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (pickedTime != null)
                Text(pickedTime.hour.toString() +
                    ':' +
                    pickedTime.minute.toString()),
              FlatButton(
                onPressed: () {
                  return showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(hour: 00, minute: 00),
                  ).then((time) => {pickTimeMethod(time)});
                },
                child: pickedTime != null
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
