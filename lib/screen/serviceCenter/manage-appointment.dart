import 'package:driver_friend/helper/error-helper.dart';
import 'package:driver_friend/model/appointment.dart';
import 'package:driver_friend/provider/driver_provider.dart';
import 'package:driver_friend/provider/service_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/widget/appointment-status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ManageAppointment extends StatefulWidget {
  static String routeName = 'manage-appointment-service';

  @override
  _ManageAppointmentState createState() => _ManageAppointmentState();
}

class _ManageAppointmentState extends State<ManageAppointment> {
  bool isLoading = false;
  List<Appointment> appoinments;

  _appointmentStatus(context, id) async {
    try {
      bool status = await AppointmentStatus.appointmentStatus(context);
      print(status);

      if (status != null) {
        setState(() {
          isLoading = true;
        });
        await Provider.of<ServiceCenterProvider>(context, listen: false)
            .changeAppointmentStatus(id, status ? 'Approve' : 'Reject');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ErrorDialog.errorDialog(context, 'Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    var me = Provider.of<UserProvider>(context, listen: false).me;
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Appointments'),
      ),
      body: FutureBuilder(
          future: Provider.of<ServiceCenterProvider>(context, listen: false)
              .getAppointments(me['id']),
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

            return Consumer<ServiceCenterProvider>(
                builder: (context, data, child) {
              appoinments = data.appointments;
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
                                    onPressed: () => _appointmentStatus(
                                        context, appoinments[index].id),
                                    child: Text(
                                      'Approve or Reject',
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
