import 'dart:developer';

import 'package:driver_friend/helper/bottom-sheet.dart';
import 'package:driver_friend/model/drivert.dart';
import 'package:driver_friend/model/service-model.dart';
import 'package:driver_friend/provider/driver_provider.dart';
import 'package:driver_friend/provider/service_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceCenterServices extends StatefulWidget {
  static String routeName = 'service-center-services';

  @override
  _ServiceCenterServicesState createState() => _ServiceCenterServicesState();
}

class _ServiceCenterServicesState extends State<ServiceCenterServices> {
  bool isLoading = false;
  String id;
  var me;
  Driver driver;

  @override
  Widget build(BuildContext context) {
    id = ModalRoute.of(context).settings.arguments;
    me = Provider.of<UserProvider>(context, listen: false).me;

    if (me['role'] != 'serviceCenter') {
      driver = Provider.of<DriverProvider>(context, listen: false).driver;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Services'),
        ),
        body: FutureBuilder(
          future: Provider.of<ServiceCenterProvider>(context, listen: false)
              .fetchServices(id),
          builder: (context, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (data.error != null) {
              if (data.error.toString().contains('404')) {
                return Center(child: Text('Sorry no spare part shops found'));
              }
              return Center(child: Text(data.error.toString()));
            }

            return isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<ServiceCenterProvider>(
                    builder: (context, service, child) {
                      List<Service> services = service.services;
                      return services.length == 0
                          ? Center(
                              child: Text('No services have yet, '),
                            )
                          : ListView.builder(
                              itemCount: services.length,
                              itemBuilder: (ctx, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(2),
                                    topRight: Radius.circular(2),
                                  ),
                                  child: Card(
                                    elevation: 3,
                                    child: Column(
                                      children: [
                                        if (services[index].image == null)
                                          Container(
                                            height: 200,
                                            child: Image.asset(
                                              'assets/images/ser_cover.PNG',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          services[index].name,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                              Text(services[index].description),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Rs.' +
                                                    services[index]
                                                        .price
                                                        .toString(),
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            if (me['role'] == 'serviceCenter')
                                              FlatButton(
                                                  onPressed: () {},
                                                  child: Text(
                                                    'Edit',
                                                    style: TextStyle(
                                                        color: Colors.purple),
                                                  )),
                                            if (me['role'] != 'serviceCenter')
                                              FlatButton(
                                                onPressed: () {
                                                  CustomBottomSheet.bottomSheet(
                                                      context, driver.userName);
                                                },
                                                child: Text(
                                                  'Appointment',
                                                  style: TextStyle(
                                                      color: Colors.purple),
                                                ),
                                              ),
                                            if (me['role'] == 'serviceCenter')
                                              FlatButton(
                                                onPressed: () async {
                                                  try {
                                                    setState(() {
                                                      isLoading = true;
                                                    });
                                                    await Provider.of<
                                                                ServiceCenterProvider>(
                                                            context,
                                                            listen: false)
                                                        .deleteService(
                                                            services[index].id);
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                  } catch (e) {
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                    return showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            content: Text(
                                                              e.toString(),
                                                            ),
                                                            actions: [
                                                              FlatButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    Text('OK'),
                                                              ),
                                                            ],
                                                          );
                                                        });
                                                  }
                                                },
                                                child: Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                    },
                  );
          },
        ));
  }
}
