import 'dart:developer';

import 'package:driver_friend/helper/bottom-sheet.dart';
import 'package:driver_friend/helper/is-perform.dart';
import 'package:driver_friend/model/drivert.dart';
import 'package:driver_friend/model/service-model.dart';
import 'package:driver_friend/provider/driver_provider.dart';
import 'package:driver_friend/provider/service_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/serviceCenter/add-services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceCenterServices extends StatefulWidget {
  static String routeName = 'service-center-services';

  @override
  _ServiceCenterServicesState createState() => _ServiceCenterServicesState();
}

class _ServiceCenterServicesState extends State<ServiceCenterServices> {
  bool isLoading = false;
  var modalRouteData;
  var me;
  Driver driver;

  @override
  Widget build(BuildContext context) {
    me = Provider.of<UserProvider>(context, listen: false).me;

    if (me['role'] != 'serviceCenter') {
      modalRouteData = ModalRoute.of(context).settings.arguments as Map;
      driver = Provider.of<DriverProvider>(context, listen: false).driver;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Services'),
        ),
        body: FutureBuilder(
          future: me['role'] == 'serviceCenter'
              ? Provider.of<ServiceCenterProvider>(context, listen: false)
                  .fetchServices(me['id'])
              : Provider.of<ServiceCenterProvider>(context, listen: false)
                  .fetchServices(modalRouteData['userId']),
          builder: (context, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (data.error != null) {
              if (data.error.toString().contains('404')) {
                return Center(child: Text('Sorry no spare part shops found'));
              }
              return Center(
                  child: Text('Something went wrong. Try again later.'));
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
                                        if (services[index].image != null)
                                          Container(
                                            height: 200,
                                            width: double.infinity,
                                            child: Image.network(
                                              services[index].image,
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
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            CreateNewServiceScreen
                                                                .routeName,
                                                            arguments:
                                                                services[index]
                                                                    .id);
                                                  },
                                                  child: Text(
                                                    'Edit',
                                                    style: TextStyle(
                                                        color: Colors.purple),
                                                  )),
                                            if (me['role'] != 'serviceCenter')
                                              FlatButton(
                                                onPressed: () {
                                                  CustomBottomSheet
                                                      .bottomSheet({
                                                    'context': context,
                                                    'driverName':
                                                        driver.userName,
                                                    'driverId': driver.id,
                                                    'centerId': modalRouteData[
                                                        'userId'],
                                                    'serviceName':
                                                        services[index].name,
                                                    'centerName':
                                                        modalRouteData[
                                                            'centerName'],
                                                    'centerMobile':
                                                        modalRouteData[
                                                            'centerMobile'],
                                                  });
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
                                                    bool isPerform =
                                                        await IsPerformDialog
                                                            .performStatus(
                                                                context);

                                                    if (isPerform)
                                                      setState(() {
                                                        isLoading = true;
                                                      });
                                                    if (isPerform)
                                                      await Provider.of<
                                                                  ServiceCenterProvider>(
                                                              context,
                                                              listen: false)
                                                          .deleteService(
                                                              services[index]
                                                                  .id);
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
