import 'package:driver_friend/provider/driver_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Appointment extends StatelessWidget {
  static String routeName = 'appointment-driver';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmed Appointments'),
      ),
      body: FutureBuilder(
          future: Provider.of<DriverProvider>(context, listen: false)
              .fetchAppointments(),
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
              var appoinments = data.appointments;
              return ListView.builder(
                  itemCount: appoinments.length,
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
