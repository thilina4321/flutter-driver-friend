import 'package:driver_friend/model/drivert.dart';
import 'package:driver_friend/provider/driver_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentScreen extends StatefulWidget {
  static String routeName = 'appointment-driver';

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  Driver driver;
  @override
  void initState() {
    driver = Provider.of<DriverProvider>(context, listen: false).driver;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Appointments'),
      ),
      body: FutureBuilder(
          future: Provider.of<DriverProvider>(context, listen: false)
              .fetchAppointments(driver.id),
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
              print(appoinments);
              return ListView.builder(
                  itemCount: appoinments.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        children: [
                          Text(driver.name.toString()),
                        ],
                      ),
                    );
                  });
            });
          }),
    );
  }
}
