import 'package:driver_friend/model/appointment.dart';
import 'package:driver_friend/provider/driver_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ManageAppointment extends StatelessWidget {
  static String routeName = 'manage-appointment-service';
  _makingPhoneCall(mobile) async {
    final url = 'tel:$mobile';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Appointments'),
      ),
      body: FutureBuilder(
          future: Provider.of<DriverProvider>(context, listen: false)
              .fetchAppointments('driver.id'),
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
              List<Appointment> appoinments = data.appointments;
              return ListView.builder(
                  itemCount: appoinments.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        elevation: 3,
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Appointment for ' +
                                    appoinments[index].serviceName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.purple, fontSize: 25),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Service Center : ' +
                                    appoinments[index].centerName.toString()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Date : ' +
                                    appoinments[index].date.toString()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Time : ' +
                                    appoinments[index].time.toString()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Status : ' +
                                    appoinments[index].status.toString()),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                child: Card(
                                  elevation: 5,
                                  child: FlatButton(
                                    onPressed: () => _makingPhoneCall(
                                        appoinments[index].centerMobile),
                                    child: Text(
                                      'Call',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        color: Colors.purple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            });
          }),
    );
  }
}
